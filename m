Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422713AbWJNQdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422713AbWJNQdo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 12:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422714AbWJNQdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 12:33:44 -0400
Received: from web58114.mail.re3.yahoo.com ([68.142.236.137]:58019 "HELO
	web58114.mail.re3.yahoo.com") by vger.kernel.org with SMTP
	id S1422713AbWJNQdn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 12:33:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=3o36vkCmO5QFtQDR8gA/WeVRdJjt7/UVo97UebKEEWd073nfj6KIzyBgStfbaPZDVGjKH8jJcKIkS5hmGfUVkvsRx2s0XXerGeqOzsauCobMa5SniPvdHge7CKXlzpkOxbMcyXeWjRjYDmM8wmOSDx17n5pFYI6mnmSnkf9ZnYs=  ;
Message-ID: <20061014163342.36731.qmail@web58114.mail.re3.yahoo.com>
Date: Sat, 14 Oct 2006 09:33:42 -0700 (PDT)
From: Open Source <opensource3141@yahoo.com>
Subject: Re: USB performance bug since kernel 2.6.13 (CRITICAL???)
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Yes, I am on board with both Alans.  I did not know
about this very nifty option in strace.  I will look into
it in detail on Mon/Tue and report back.

Clearly something is weird, because there are no
other load-intensive processes running on the system.
I would think that the scheduler would wake up any
blocked processes rather than sitting idle for 4 ms.
In any case, I am open to the fact it may not be
USB per se.  We'll see what strace says.

As always, thanks for the suggestions.  Stay tuned....


----- Original Message ----
From: Alan Stern <stern@rowland.harvard.edu>
To: Open Source <opensource3141@yahoo.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>; USB development list <linux-usb-devel@lists.sourceforge.net>; Kernel development list <linux-kernel@vger.kernel.org>
Sent: Friday, October 13, 2006 7:11:39 PM
Subject: Re: [linux-usb-devel] USB performance bug since kernel 2.6.13 (CRITICAL???)

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






