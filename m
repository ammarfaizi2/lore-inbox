Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVBNJUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVBNJUA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 04:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVBNJUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 04:20:00 -0500
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:36792 "EHLO
	clueserver.org") by vger.kernel.org with ESMTP id S261373AbVBNJTr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 04:19:47 -0500
Subject: Odd problem with dual processor AMD system
From: Alan <alan@clueserver.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Feb 2005 01:19:34 -0800
Message-Id: <1108372774.1107.13.camel@dagon.fnordora.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a dual processor AMD machine.

It give apic errors after running for a while.  (Usually after heavy
disk i/o.)

 APIC error on CPU0: 02(02)
 APIC error on CPU1: 02(02)

After this occurs, read/writes to/from the drive slow down
substantially.

Unless...

If I set the scheduler to deadline (elevator=deadline on the kernel load
line), the APIC errors remain, but the disk slowdown goes away.

My initial thought is that something in the standard scheduler is
getting corrupted, but not when the deadline scheduler is used.

Is there a way to prove this?

This occurs on every 2.6.x kernel I have used.

On a similar, but different vein, if I use the "elevator=deadline" on
the dual processor AMD64 machine running Fedora Core 2 (64bit version),
the kernel blows up real good early enough to not leave a message in the
logs.  (The machine is a couple of hundred miles from me, so I am not
certain what the error message on the screen is on time of detonation.)

Ideas on how to log something that early in the boot process without
being in front of the machine?

-- 
Jag vill inte köpa den här lutefisk , den er skrapet.

