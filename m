Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262207AbSK0Rkf>; Wed, 27 Nov 2002 12:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbSK0Rkf>; Wed, 27 Nov 2002 12:40:35 -0500
Received: from mhw.ulib.iupui.edu ([134.68.164.23]:55255 "EHLO
	mhw.ulib.iupui.edu") by vger.kernel.org with ESMTP
	id <S262207AbSK0Rke>; Wed, 27 Nov 2002 12:40:34 -0500
Date: Wed, 27 Nov 2002 12:47:54 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: A Kernel Configuration Tale of Woe
Message-ID: <Pine.LNX.4.33.0211271247020.30894-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2002, Otto Wyss wrote:
[snip]
> IMO each driver should be able (within resonable limits) to detect the
> hardware it is written for, returning a simple true/false. This way any
> driver could be asked if its hardware is available. With trial and error
> it should be possible to autodetect any hardware. This way there is no
> need for a centralize database. Of course if there is no driver one
> could ask that hardware never gets detected.

Please, no.  Try installing Microsoft Windows on some box if you want to
see this idea in action.  They've done it that way for years:  throw all
available drivers at the hardware and see which ones stick.  Pick a time
when you have a couple of hours to waste -- the process is agonizingly
slow.

Much better to simply ask each bus what's sitting on it.  Only non-PnP ISA
devices are unable to answer.  If the box has no ISA slots, then the
configuration can be done without any user intervention in a few
milliseconds.

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
MS Windows *is* user-friendly, but only for certain values of "user".

