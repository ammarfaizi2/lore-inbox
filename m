Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752036AbWJNCLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbWJNCLm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 22:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752039AbWJNCLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 22:11:42 -0400
Received: from mx2.rowland.org ([192.131.102.7]:34308 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1752036AbWJNCLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 22:11:41 -0400
Date: Fri, 13 Oct 2006 22:11:39 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Open Source <opensource3141@yahoo.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] USB performance bug since kernel 2.6.13
 (CRITICAL???)
In-Reply-To: <1160785492.25218.96.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0610132209180.22133-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Oct 2006, Alan Cox wrote:

> Ar Gwe, 2006-10-13 am 16:30 -0700, ysgrifennodd Open Source:
> > There is an ioctl that is waiting for the URB to be reaped.
> > I am almost certain it is this syscall that is taking 4 ms (as
> > opposed to 1 ms with CONFIG_HZ=1000).
> 
> What does strace say about it ? This is measurable not speculation.

I completely agree with the other Alan.  You don't have to guess about
these things.  Use strace to see what your process is doing and at the
same time use usbmon to see what the USB stack is doing.  Run the 
experiment at both 1000 Hz and 250 Hz and compare the results.

Alan Stern

