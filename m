Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbUKQQX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbUKQQX6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 11:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbUKQQX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 11:23:58 -0500
Received: from imag.imag.fr ([129.88.30.1]:42999 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S262364AbUKQQX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 11:23:56 -0500
Date: Wed, 17 Nov 2004 17:23:54 +0100 (CET)
From: Catalin Drula <Catalin.Drula@imag.fr>
To: <linux-kernel@vger.kernel.org>
Subject: Re: AF_UNIX sockets: strange behaviour
Message-ID: <Pine.GSO.4.33.0411171717530.8987-100000@horus.imag.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Wed, 17 Nov 2004 17:23:54 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Dick Johnson wrote:
>
> > Catalin Drula wrote:
> >
> > - there is a skb in the sk_receive_queue with a len of 13
> > - 6 bytes are read from it
> > - a skb with the remaining 7 bytes is requeued in sk_receive_queue
> > - on the next call to unix_stream_recvmsg, the sk_receive_queue is
> >  empty (!)
> >
> > Thus, this confirms the behaviour observed from userspace. Is this a
> > bug? Who could be removing the skb from the receive_queue?
>
> If you need STREAM behavior I think you need to use recv(),
> recvfrom(),or read().
>
> If you use recvmsg(), the "message" will be removed even it you
> haven't read it all. Note in the 'man' page description:
> "If the a message is too long to fit in the supplied buffer, excess
> bytes may be discarded depending upon the type of socket the message
> is being received from...

At first I used read() and then I tried recv() as well.

Catalin

