Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbVJFTTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbVJFTTa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 15:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbVJFTTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 15:19:30 -0400
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:12935 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751318AbVJFTT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 15:19:29 -0400
To: linux-kernel@vger.kernel.org
Date: Thu, 06 Oct 2005 21:19:22 +0200
From: Soeren Sonnenburg <kernel@nn7.de>
Message-ID: <pan.2005.10.06.19.19.22.673915@nn7.de>
Organization: Local Intranet News
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
References: <1128323544.4602.5.camel@localhost>
Subject: ide_wait_not_busy oops still with 2.6.14-rc3 (Re: 1GHz pbook 15", linux 2.6.14-rc2 oops on resume)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Oct 2005 07:12:24 +0000, Soeren Sonnenburg wrote:

> Hi all,
> 
> when a dvd featuring some iso content is in the dvd-drive and the
> machine is put to sleep mode, it will give the following oops on resume.
> It is working without problems if no media is in the drive.
> Voluntary preemption is ON.
> Find below the dmesg output when a dvd is in the drive.

now it is:

GPR00: 00000080 EDEF5C00 EF894780 00079C96 000088B8 00000000 00000000 C05A8A50 
GPR08: C05A8538 EDEF5CC8 00100000 00140040 22004222 
NIP [c0006fcc] __delay+0xc/0x14
LR [c02bc32c] ide_wait_not_busy+0x4c/0xc0
Call trace:
 [c02ba670] ide_do_request+0x5b0/0x990
 [c02bab10] ide_do_drive_cmd+0xc0/0x190
 [c02b72d0] generic_ide_resume+0x80/0xa0
 [c0294260] resume_device+0x70/0x150
 [c0294510] dpm_resume+0x100/0x1a0
 [c02945ec] device_resume+0x3c/0xa0
 [c05438cc] pmac_wakeup_devices+0xbc/0xe0
 [c0544adc] pmu_ioctl+0x58c/0x9b0
 [c008e344] do_ioctl+0x84/0x90
 [c008e3dc] vfs_ioctl+0x8c/0x450
 [c008e834] sys_ioctl+0x94/0xb0
 [c0004820] ret_from_syscall+0x0/0x44


Soeren


