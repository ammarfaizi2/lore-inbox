Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbVCLRWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVCLRWh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 12:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVCLRWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 12:22:37 -0500
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:3592 "EHLO
	roarinelk.homelinux.net") by vger.kernel.org with ESMTP
	id S261974AbVCLRWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 12:22:33 -0500
Message-ID: <4233254F.3000509@roarinelk.homelinux.net>
Date: Sat, 12 Mar 2005 18:22:23 +0100
From: Manuel Lauss <mano@roarinelk.homelinux.net>
User-Agent: TB/1.0 (X11/ppc64-smp) Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Guido Villa <piribillo@yahoo.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: Error with Sil3112A SATA controller and Maxtor 300GB HDD
References: <20050312160704.22527.qmail@gg.mine.nu>
In-Reply-To: <20050312160704.22527.qmail@gg.mine.nu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Guido Villa wrote:
> Hello, 
> 
> I have an error as described in subject.
> I couldn't find a previous report for this kind of error, so maybe you are 
> interested in it. 
> 
> Motherboard: ASUS TUV4X, BIOS rev. 1005
> SATA controller: Silicon Image 3112A, bios rev. 4.2.50
> Hard disk: Maxtor Maxtor 6B300S0 (300GB, SATA) 
> 
> This is the only HDD attached to the controller. It is not the boot device, 
> I have other HDDs on the IDE channels, but I don't think it matters. 

I happen to have a SiI 3112A controller and a Maxtor 6B300S0 attached to
it, formatted with ext2. Never had any problems. I just copied
200GB of data to it, worked flawlessly. (Vanilla 2.6.11)
Maybe its the Motherboard?

> Kernels: 2.6.9, 2.6.10, 2.6.11.2
> I also patched the 2.6.11.2 by adding this Maxtor disk to the sata_sil.c 
> blacklist (once with the SIL_QUIRK_MOD15WRITE and once with the 
> SIL_QUIRK_UDMA5MAX), but the behaviour did not change. 
> 
> Problem:
> I create a single partition on the hard disk, I format it with ext2, I mount 
> it, I begin writing onto the partition. After seconds (or minutes) of 
> copying, I get this error: 
> 
> EXT2-fs error (device sda1): ext2_new_block: Allocating block in system zone 
>  - block = 22413316 
> 
> I have also tried with ext3, in this case it prints more error messages: 
> 
> EXT3-fs error (device sda1): ext3_new_block: Allocating block in system zone 
>  - block = 61997060
> Aborting journal on device sda1.
> EXT3-fs error (device sda1) in ext3_prepare_write: Journal has aborted
> __journal_remove_journal_head: freeing b_committed_data
> __journal_remove_journal_head: freeing b_frozen_data
> __journal_remove_journal_head: freeing b_committed_data
> __journal_remove_journal_head: freeing b_frozen_data
> __journal_remove_journal_head: freeing b_committed_data
> __journal_remove_journal_head: freeing b_frozen_data
> __journal_remove_journal_head: freeing b_committed_data
> __journal_remove_journal_head: freeing b_frozen_data
> __journal_remove_journal_head: freeing b_frozen_data
> ext3_abort called.
> EXT3-fs error (device sda1): ext3_journal_start_sb: Detected aborted journal
> Remounting filesystem read-only
> EXT3-fs error (device sda1) in start_transaction: Journal has aborted 

-- 
  Manuel Lauss
