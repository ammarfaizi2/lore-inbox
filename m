Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132500AbRDDWUh>; Wed, 4 Apr 2001 18:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132501AbRDDWU1>; Wed, 4 Apr 2001 18:20:27 -0400
Received: from chambertin.convergence.de ([212.84.236.2]:5641 "EHLO
	chambertin.convergence.de") by vger.kernel.org with ESMTP
	id <S132500AbRDDWUQ>; Wed, 4 Apr 2001 18:20:16 -0400
Date: Thu, 5 Apr 2001 00:19:22 +0200 (CEST)
From: "Joachim 'roh' Steiger" <roh@convergence.de>
To: Miles Lane <miles@megapathdsl.net>
cc: Thomas Dodd <ted@cypress.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>
Subject: Re: Contacts within AMD?  AMD-756 USB host-controller blacklisted
 due to
In-Reply-To: <3ACB6DEB.4020709@megapathdsl.net>
Message-ID: <Pine.LNX.4.21.0104050004060.21943-100000@campari.convergence.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i would like to help to track down this problem
i'm using a gigabyte 7IXE revision 1.1
kernel is 2.4.1

lspci output for usb:
00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-756 [Viper] USB
(rev 06) (prog-i
f 10 [OHCI])
        Flags: bus master, medium devsel, latency 16, IRQ 11
        Memory at efffc000 (32-bit, non-prefetchable) [size=4K]


On Wed, 4 Apr 2001, Miles Lane wrote:
> Thomas Dodd wrote:
> 
> > Alan Cox wrote:
> >
> >> because we dont know the full scope of the problem yet.
> > Exactly how many bug reports has this caused?
> > What kind of problems?

here i only have this kernelmessage floating around in my logfiles about 1
time the day: 

Apr  4 14:47:15 campari kernel: usb-ohci.c: bogus NDP=204 for OHCI 
usb-00:07.4
Apr  4 14:47:15 campari kernel: usb-ohci.c: rereads as NDP=4

> error."  Most of the time, when the error occurs, it seems
> pretty benign.  That is, I haven't noticed it crashing USB
> device connections, causing data corruption or OOPSen.
> Some folks _have_ reported OOPSen, though, that seemed to
> be triggered by the erratum #4 hardware bug.  I think I
> may have had one of these a long time ago.

as you see it's revision 6
i've had no other problems with usb for now and use this
 idVendor           0x046d Logitech Inc.
 idProduct          0xc00c 
usb-wheelmouse all the time

i've never had this kernel or previous kernel (2.4.0test8) oopsen 
and it runs perfectly stable here

> I believe David has found that there definitely are code
> paths where this hardware bug can cause failures of various
> sorts and that's why the AMD-756 has been blacklisted.

since i did'nt cause any troubles here i would not like to have the
complete AMD-756 blacklisted in the ohci-driver
eventually only some revisions are that bad

please correct me if i'm wrong i only don't want to blacklist complete
chipset-series

roh
-- 
Joachim 'roh' Steiger                      mailto:roh@convergence.de
Convergence Integrated Media GmbH          http://www.convergence.de
Rosenthaler Str. 51                        fon: +49(0)30-72 62 06 77
10178 Berlin, Germany                      fax: +49(0)30-72 62 06 55

