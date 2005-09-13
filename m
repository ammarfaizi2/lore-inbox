Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbVIMAyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbVIMAyH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 20:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbVIMAyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 20:54:07 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:25731 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932388AbVIMAyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 20:54:06 -0400
Message-ID: <4326229B.6040002@gmail.com>
Date: Tue, 13 Sep 2005 02:51:39 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Sonny Rao <sonny@burdell.org>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       brking@us.ibm.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.13-mm3
References: <20050912194032.GA12426@kevlar.burdell.org> <200509122106.j8CL6WPk006092@wscnet.wsc.cz> <20050912214945.GA17729@kevlar.burdell.org> <20050912221023.GB18215@kevlar.burdell.org>
In-Reply-To: <20050912221023.GB18215@kevlar.burdell.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sonny Rao napsal(a):

>On Mon, Sep 12, 2005 at 05:49:45PM -0400, Sonny Rao wrote:
>  
>
>>--- linux-2.6.13-mm3/drivers/char/hvc_console.c~orig	2005-09-12 16:37:14.434077464 -0500
>>+++ linux-2.6.13-mm3/drivers/char/hvc_console.c	2005-09-12 16:37:25.466998360 -0500
>>@@ -597,7 +597,7 @@ static int hvc_poll(struct hvc_struct *h
>> 
>> 	/* Read data if any */
>> 	for (;;) {
>>-		count = tty_buffer_request_room(tty, N_INBUF);
>>+		int count = tty_buffer_request_room(tty, N_INBUF);
>> 
>> 		/* If flip is full, just reschedule a later read */
>> 		if (count == 0) {
>>@@ -633,7 +633,7 @@ static int hvc_poll(struct hvc_struct *h
>> 			tty_insert_flip_char(tty, buf[i], 0);
>> 		}
>> 
>>-		if (tty->flip.count)
>>+		if (tty->buf.tail->used)
>>    
>>
Is there any better way to gather this info? I think, that this was my 
bad idea. Some encapsulation needed.

thanks,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

