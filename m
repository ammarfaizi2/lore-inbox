Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265299AbTLGDak (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 22:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265300AbTLGDaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 22:30:20 -0500
Received: from tantale.fifi.org ([216.27.190.146]:41114 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S265299AbTLGDaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 22:30:13 -0500
To: Mark Symonds <mark@symonds.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 hard lock, 100% reproducible.
References: <20031207023650.GA772@symonds.net>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 06 Dec 2003 19:30:08 -0800
In-Reply-To: <20031207023650.GA772@symonds.net>
Message-ID: <87he0ds3sv.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Symonds <mark@symonds.net> writes:

> Hi, 
> 
> I've got a machine here that is locking hard under
> 2.4.23.  Normally would suspect it's a hardware problem
> but it runs fine on 2.4.22 and also 2.2 series kernels.  
> In a bit of a quandry here since that box has shell
> users... 
> 
> I'm getting no oopses on the monitor nor in the logs -
> this is a hard, instantaneous crash.  No kbd, no nothing,
> good night. 

Not even sysrq?
 
> I've got a kernel compiling right now with hacking
> support, but none of the additional hacking  options
> are enabled. 
> 
> Wondering if anyone else has seen this?  lspci output is
> below, will wait until requested before dumping a bunch
> of crap about my hardware onto the list. 

Same for me.

2.4.23 locks up hard. 2.4.22 worked perfectly (save the random usb
oops).

I was not able to capture a register trace or a process dump with
sysrq because this box has a usb keyboard and usb seems to get
shot. I've plugged a ps/2 keyboard to get more details the next
lock-up. If this fail, I might try the NMI oopser.

lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] (rev 23)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 11)
00:07.3 Host bridge: VIA Technologies, Inc. VT82C596 Power Management (rev 30)
00:0f.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
00:0f.1 Input device controller: Creative Labs SB Live! (rev 08)
00:10.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
00:12.0 SCSI storage controller: Adaptec 7892A (rev 02)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04)

Phil.
