Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUHaQ3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUHaQ3y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 12:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUHaQ3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 12:29:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:40324 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268760AbUHaQ3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 12:29:37 -0400
Date: Tue, 31 Aug 2004 09:29:26 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
cc: Tim Fairchild <tim@bcs4me.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: K3b and 2.6.9?
In-Reply-To: <41341A31.3050301@bio.ifi.lmu.de>
Message-ID: <Pine.LNX.4.58.0408310926310.2295@ppc970.osdl.org>
References: <200408301047.06780.tim@bcs4me.com> <1093871277.30082.7.camel@localhost.localdomain>
 <200408311151.25854.tim@bcs4me.com> <Pine.LNX.4.58.0408301917360.2295@ppc970.osdl.org>
 <41341A31.3050301@bio.ifi.lmu.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Aug 2004, Frank Steiner wrote:

> Linus Torvalds wrote:
> 
> > Ehh.. This seems to imply that K3b opens the device for _reading_ when it 
> > wants to burn a CD-ROM. 
> 
> It seems that this problem is not K3B-only:

Yes. I suspect that these projects have at least looked at each other, so 
it's probably a problem that has its basis in cdrecord or some "original" 
program.

And yes, opening for reading used to work. After all, you didn't need a 
"write()" system call, and the ioctl functions didn't use to check. It's a 
potential security problem, and one that 2.6.8 fixed, and I don't think 
we're willing to go back to the old setup.

And trust me - I absolutely _hate_ breaking user-level programs. I'd love
to unbreak it from the kernel, but in this case I don't see any
alternatives, really.

			Linus
