Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262875AbVF3GiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262875AbVF3GiO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 02:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbVF3GiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 02:38:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64170 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262875AbVF3GiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 02:38:01 -0400
Date: Thu, 30 Jun 2005 08:37:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Wang Jian <larkwang@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12.1 problems I meet (please CC: me)
Message-ID: <20050630063721.GB2243@suse.de>
References: <20050630111916.FEA2.LARKWANG@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630111916.FEA2.LARKWANG@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30 2005, Wang Jian wrote:
> Hi,
> 
> I use a customized kernel to do packets analysis. The analysis code is
> linked into kernel. It will vmalloc() nearly 128M (a little less) when
> initialized.
> 
> The original code runs on 2.6.10 and works fine. The platform is a
> general P4 with 100M ethernet. The user space system is a 8M compressed
> ramdisk image which is a 32M filesystem.
> 
> Now I want to make it work on 2.6.12+ and on Athlon64 platform, for
> better driver and better CPU/NIC performance.
> 
> I have a P4 box (compilation bed, CB), a 2-way Athlon64 box (test bed,
> TB).
> 
> The problems are:
> 
> 1. I port the code directly to 2.6.12.1 on CB, and it compiles ok. But
> during boot, the kernel boot with error "unknown bus type 0" and freeze.
> Especially, it can't detect harddisk's partition table. I use "quiet" to
> strip non-error message and hand copy error messages

Which compiler? 2.6.12.2 should work for you, looks like you are hit my
the memcpy reordering bug.

-- 
Jens Axboe

