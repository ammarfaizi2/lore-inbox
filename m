Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbUAMJWc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 04:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbUAMJWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 04:22:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:34453 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261889AbUAMJWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 04:22:31 -0500
Date: Tue, 13 Jan 2004 10:22:24 +0100
From: Jens Axboe <axboe@suse.de>
To: Little Djo <hatred@iatp.festu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Two CDROM drives and module compilation of CDROM Support
Message-ID: <20040113092224.GI24638@suse.de>
References: <20040113190344.466e2a7d.hatred@iatp.festu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040113190344.466e2a7d.hatred@iatp.festu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13 2004, Little Djo wrote:
> Hi,
> 
> if I build CDROM support as module, then work only first CDROM (hdc):
> [root]# modprobe ide-cd
> [root]# dmesg | tail -3
> ide-cd: ignoring drive hdd
> hdc: ATAPI 52X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.12
> 
> if i compile CDROM support in kernel, all two drives work!
> 
> this feature present in kernel 2.6.0 (-test## also), 2.6.1, 2.6.1-mm1,
> but don't present in kernel 2.4.x

Most likely you have an entry in /etc/modules.conf ala

options ide-cd ignore=hdd

so ide-cd discards hdd (maybe you used to drive it with ide-scsi?)

-- 
Jens Axboe

