Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVB0OVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVB0OVF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 09:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVB0OVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 09:21:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40097 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261395AbVB0OVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 09:21:00 -0500
Date: Sun, 27 Feb 2005 07:00:00 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: nuclearcat <nuclearcat@nuclearcat.com>, torvalds@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pty_chars_in_buffer NULL pointer (kernel oops)
Message-ID: <20050227100000.GB22439@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(resending since first message didnt seem to go through)

Hi, 

On Fri, Feb 18, 2005 at 10:56:53AM +0200, nuclearcat wrote:

> Is discussed at

> http://kerneltrap.org/mailarchive/1/message/12508/thread 

> bug fixed in 2.4.x tree? Cause seems i have downloaded 2.4.29, and it
> is not fixed (still my kernel on vpn server crashing almost at start),
> i have grepped fast pre and bk patches, but didnt found any fixed
> related to tty/pty.

Can you please post the oops? Have you done so already? 

What makes you think it is the same race discussed in the above thread? 

BTW, I fail to see any drivers/char/pty.c change related to the race which triggers
the pty_chars_in_buffer->0 oops.

Quoting the first message from thread you mention:
"That last call trace entry is the call in pty_chars_in_buffer() to 

	/* The ldisc must report 0 if no characters available to be read */ 
	count = to->ldisc.chars_in_buffer(to);
"

Alan, Linus, what correction to the which the above thread discusses has 
been deployed? 

> Provided in thread patch from Linus working, but after night i have
> checked server, and see load average jumped to 700.
> Can anybody help in that? I am not kernel guru to provide a patch, but
> seems by search in google it is actual problem for people, who own
> poptop vpn servers, it is really causing serious instability for
> servers.

Can you compile a list of such v2.4 reports? 

