Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264418AbTLYXpf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 18:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264425AbTLYXpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 18:45:35 -0500
Received: from hendrix.ece.utexas.edu ([128.83.59.42]:32419 "EHLO
	hendrix.ece.utexas.edu") by vger.kernel.org with ESMTP
	id S264418AbTLYXpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 18:45:24 -0500
Date: Thu, 25 Dec 2003 17:45:10 -0600 (CST)
From: "Hmamouche, Youssef" <youssef@ece.utexas.edu>
To: Tomas Szepe <szepe@pinerecords.com>
cc: Gergely Tamas <dice@mfa.kfki.hu>, Keith Lea <keith@cs.oswego.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11 data loss
In-Reply-To: <20031225164628.GB22578@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.21.0312251710040.5486-100000@linux08.ece.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm getting a system freeze but no file corruption. The freeze happens
randomly after all rc.d scripts run. The freeze seems to happen slightly
at a "later" time when I applied the 2.6.0-mm1 patch(I was able to login
and startx) whereas before the freeze happened before/while logging
in. 

My boot parameters usually look like this:

BOOT_IMAGE=Linux-2.6.0 ro root=303 apm=on acpi=off

IBM Thinkpad T22
linux-2.6.0 | linux-2.6.0-mm1
slackware 9.1

bash-2.05b# lspci 
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
(rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge
(rev 03)
00:02.0 CardBus bridge: Texas Instruments PCI1450 (rev 03)
00:02.1 CardBus bridge: Texas Instruments PCI1450 (rev 03)
00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev
0c)
00:03.1 Serial controller: Lucent Microelectronics LT WinModem (rev 01)
00:05.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
00:07.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
01:00.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV (rev
13)


Now that I went back and tested the kernel(mm1) with the following
parameters, the system hasn't freezed yet. I'll report if anything goes
wrong.

BOOT_IMAGE=Linux-2.6.0 ro root=303 idebus=66 ide0=ata66 ide1=ata66
ide2=ata66 apm=on acpi=off

Thank you

On Thu, 25 Dec 2003, Tomas Szepe wrote:

> On Dec-24 2003, Wed, 23:22 +0100
> Gergely Tamas <dice@mfa.kfki.hu> wrote:
>

