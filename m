Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbUDXEpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUDXEpk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 00:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUDXEpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 00:45:40 -0400
Received: from [81.219.144.6] ([81.219.144.6]:56585 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S261931AbUDXEpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 00:45:31 -0400
Message-ID: <4089F0E5.3050006@pointblue.com.pl>
Date: Sat, 24 Apr 2004 05:45:25 +0100
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: ncunningham@linuxmail.com
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: fix error handling in "not enough swap space"
References: <4089DC36.5020806@pointblue.com.pl> <opr6xykbzqruvnp2@laptop-linux.wpcb.org.au> <4089E761.5050708@pointblue.com.pl> <opr6x0o10uruvnp2@laptop-linux.wpcb.org.au>
In-Reply-To: <opr6x0o10uruvnp2@laptop-linux.wpcb.org.au>
Content-Type: multipart/mixed;
 boundary="------------010903000105070001010801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010903000105070001010801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Nigel Cunningham wrote:

> Hmm.
>
> I agree with you; it does sound like the process of eating memory is  
> grabbing all the swap. I can't see how it could be doing that, 
> however. If  you really want to use Pavel's version, I'd suggest 
> adding some more debug  statements. Perhaps print out the number of 
> swap pages free at the start  of that loop.
>
Ok, now funny bit happends. Simple program like that:
while(1){
    char *a=malloc(1024*1024*16);
    if (a==NULL)
       break;
}

can allocate only about 200MB, than exits. That's the fist thing.
Second one, starting KDE, and when swap usage != 0 (just to be sure 
there is no problem with any assumption), gives me loads of error 
messages (see attached file).

Very bizzare behavior.



--------------010903000105070001010801
Content-Type: application/octet-stream;
 name="syslog.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="syslog.bz2"

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
QR5geWA=
--------------010903000105070001010801--

