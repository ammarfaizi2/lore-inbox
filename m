Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319455AbSILGwF>; Thu, 12 Sep 2002 02:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319458AbSILGwF>; Thu, 12 Sep 2002 02:52:05 -0400
Received: from dp.samba.org ([66.70.73.150]:10927 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319455AbSILGwF>;
	Thu, 12 Sep 2002 02:52:05 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15744.14859.966809.289502@argo.ozlabs.ibm.com>
Date: Thu, 12 Sep 2002 16:54:03 +1000 (EST)
To: Jens Axboe <axboe@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] highmem I/O for ide-pmac.c
In-Reply-To: <20020911180502.GD1089@suse.de>
References: <20020911130209.GL1089@suse.de>
	<20020911185315.530@192.168.4.1>
	<20020911180502.GD1089@suse.de>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe writes:

> The above refers to ide_toggle_bounce() export, pmac_* variant is
> exactly the same. Sorry if that wasn't clear.

Why does ide_toggle_bounce assume we can only do DMA to highmem if
drive->media == ide_disk?  At the moment I can't see any reason why
the ide-pmac interface can't do DMA to highmem for a cdrom, for
instance.

Paul.
