Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWAFO7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWAFO7z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 09:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWAFO7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 09:59:55 -0500
Received: from jdi.jdi-ict.nl ([82.94.239.5]:36530 "EHLO jdi.jdi-ict.nl")
	by vger.kernel.org with ESMTP id S1751482AbWAFO7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 09:59:55 -0500
Date: Fri, 6 Jan 2006 15:59:34 +0100 (CET)
From: Igmar Palsenberg <i.palsenberg@jdi-ict.nl>
X-X-Sender: igmar@jdi.jdi-ict.nl
To: erich@areca.com.tw, linux-kernel@vger.kernel.org
Subject: PROBLEM: arcmsr build-in driver shutdown issue
Message-ID: <Pine.LNX.4.58.0601061434530.30000@jdi.jdi-ict.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've got a machine with an ARC-1110 SATA RAID controller in it, and I'm 
experiencing problems when the driver is built in the kernel.

The problem appears on all versions I've tried, including the latest -mm, 
and a hacked-up version from Areca's website.

Description

: issuing a shutdown / halt on the system spits out FS erros after 
'Halting System' and before 'System halted', due to the fact it is 
performing IO to a device that is considered dead :

 0:0:0:0: rejecting I/O to dead device
EXT3-fs error (device sda1): ext3_find_entry: reading directory #65203 
offset 0

device always seems to be sda1, which is mounted on / on this machine. 
Since the action is a read-only one on a read-only FS, I haven't seen any FS 
corruption so far.

kernel :

2.6.15-mm1
2.6.15 + hacked up ARC-1xxx driver from the website.

Relevant .config stuff : 

CONFIG_SCSI_ARCMSR=y

CPU : dual Xeon 3.2 Ghz
Mem : 4GB (This isn't a PAE kernel yet)

I can post the fill .config and a dmesg log of desired, just let me know.


regards,


	Igmar
