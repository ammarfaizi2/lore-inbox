Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264697AbSJOT6d>; Tue, 15 Oct 2002 15:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264700AbSJOT6d>; Tue, 15 Oct 2002 15:58:33 -0400
Received: from kim.it.uu.se ([130.238.12.178]:51900 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S264697AbSJOT6c>;
	Tue, 15 Oct 2002 15:58:32 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15788.29893.578475.122734@kim.it.uu.se>
Date: Tue, 15 Oct 2002 22:04:21 +0200
To: Patrick Mochel <mochel@osdl.org>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend
 devices
In-Reply-To: <Pine.LNX.4.44.0210150928340.1038-100000@cherise.pdx.osdl.net>
References: <200210132214.PAA00953@adam.yggdrasil.com>
	<Pine.LNX.4.44.0210150928340.1038-100000@cherise.pdx.osdl.net>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel writes:
 > Please don't try and convolute the code because you're worried about a few
 > microseconds. It's about correctness first; then we can worry about
 > micro-optimizing the hell out of it.

5 seconds is quite a bit more than "a few microseconds". That's
approximately how much longer it takes for my P4 to reboot, due
to 2.5.42's "oh lets spin down the disks on reboot" change.

It's even slower to reboot than to do a cold boot because on a cold
boot the disks start spinning up directly, but on a warm boot after
2.5.42 the disks don't start spinning up until the BIOS starts to
identify them and look for a bootable device.

2.5.42 is a PITA.
