Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbTKDHvF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 02:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263783AbTKDHvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 02:51:05 -0500
Received: from ns.suse.de ([195.135.220.2]:59088 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263782AbTKDHvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 02:51:02 -0500
Date: Tue, 4 Nov 2003 08:49:28 +0100
From: Jens Axboe <axboe@suse.de>
To: ahuisman <ahuisman@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_IOSCHED_CFQ
Message-ID: <20031104074927.GA1477@suse.de>
References: <bnfrml$39g$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bnfrml$39g$1@news.cistron.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 26 2003, ahuisman wrote:
> wuuk:/boot# diff config-2.6.0-test8-mm1 config-2.6.0-test9
> 33d32
> < CONFIG_IOSCHED_CFQ=y
> 87,91d85
> < # CONFIG_X86_4G is not set
> < # CONFIG_X86_SWITCH_PAGETABLES is not set
> < # CONFIG_X86_4G_VM_LAYOUT is not set
> < # CONFIG_X86_UACCESS_INDIRECT is not set
> < # CONFIG_X86_HIGH_ENTRY is not set
> 111d104
> < CONFIG_BOOT_IOREMAP=y
> 257d249
> < # CONFIG_BLK_DEV_SGIIOC4 is not set
> 302a295
> > # CONFIG_SCSI_SATA is not set
> 483d475
> < # CONFIG_NET_POLL_CONTROLLER is not set
> 
> Conclusion:
> 
> CONFIG_IOSCHED_CFQ is removed from 2.6.0-test9
> 
> Questions:
> 
> Am i right with my conclusion ?
> Is this the reason for the loss of performance ?

No you are not correct, must be caused by something else. Just building
CFQ into the kernel doesn't enable it, you need to boot with
elevator=cfq for that to happen. So whether CONFIG_IOSCHED_CFQ is set or
not cannot make a difference by itself.

The performance difference must be caused by some other change between
test8-mm1 and -test9.

-- 
Jens Axboe

