Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbULTTQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbULTTQm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 14:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbULTTQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 14:16:42 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:5797 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S261615AbULTTQg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 14:16:36 -0500
Date: Mon, 20 Dec 2004 19:15:40 +0000
From: Eric Buddington <ebuddington@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: SATA TX2/ST3160023AS on 2.6.10-rc2: "ata1: command timeout"
Message-ID: <20041220191540.GA2948@pool-151-203-151-16.wma.east.verizon.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.203.151.16] at Mon, 20 Dec 2004 13:16:35 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am suffering complete freezes on my system with a Promise TX2
controller tring to talk to a ST3160023AS drive. It works fine for
hours or days at a time, but will occasionally log an error of "ata1:
command timeout", then freeze within a minute, such that alt-SysRq-b
doesn't work.

This seems to happen more often when the drive is in heavy use. I
do not know a way to trigger it specifically.

Kernel: 2.6.10-rc2, unpatched

Hardware:
Athlon 950
Unknown mass storage controller: Promise Technology, Inc. PDC20375 (SATA150 TX2plus) (rev 2)
ST3160023AS
Hauppauge WinTV performing constant video capture (don't know if PCI saturation could contribute to this problem)

Last log entries (logged via netconsole):
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
scsi: unknown opcode 0x04
scsi: unknown opcode 0x2a
scsi: unknown opcode 0x35
scsi: unknown opcode 0x5b
scsi: unknown opcode 0x1e
ata1: command timeout

I hope this is enough information to be useful. Thanks to Jeff Garzik
for all his work on SATA...

-Eric

