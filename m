Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269807AbRHMFNT>; Mon, 13 Aug 2001 01:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269810AbRHMFNJ>; Mon, 13 Aug 2001 01:13:09 -0400
Received: from [24.159.204.122] ([24.159.204.122]:54030 "EHLO
	tweedle.cabbey.net") by vger.kernel.org with ESMTP
	id <S269807AbRHMFM5>; Mon, 13 Aug 2001 01:12:57 -0400
Date: Mon, 13 Aug 2001 00:12:43 -0500 (CDT)
From: Christopher Abbey <cabbey@cabbey.net>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: S2464 (K7 Thunder) hangs -- some lessons learned
In-Reply-To: <3B77302C.96C79272@randomlogic.com>
Message-ID: <Pine.LNX.4.33.0108130003050.17112-100000@tweedle.cabbey.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday, Paul G. Allen wrote:
> > 2. When you see a box hang that's clearly related to a daughtercard, *run*
> >    (do not walk) to your local /proc directory, cat /proc/pci and check out
> >    the IRQ assignments.

lspci -vvv is also usefull.

> Problem is, when it does hang, I can't get there as the system is
> completely locked, including ssh and telnet.

But the point is to go look at the pci interrupt assignments *before*
the hang occurs. I've seen the same situation, where two devices are
sharing an interupt, one on the mobo, the other in a PCI slot... it's
never been a good thing in my experience. As Eric pointed out if they're
both on the mobo you have to hope the designers built the hardware to
handle that, or if they're both in pci slots you can usually expect
the cards will play well with others. It's the third case that's
trouble, and then it's time to do as Eric did - get into the bios and
change the assignements (or in this case something that would cuase a
change to happen).

-- 
now the forces of openness have a powerful and
  unexpected new ally - http://ibm.com/linux

