Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161043AbWI1GtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161043AbWI1GtN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 02:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161044AbWI1GtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 02:49:13 -0400
Received: from natblert.rzone.de ([81.169.145.181]:32425 "EHLO
	natblert.rzone.de") by vger.kernel.org with ESMTP id S1161043AbWI1GtM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 02:49:12 -0400
Date: Thu, 28 Sep 2006 08:47:55 +0200
From: Olaf Hering <olaf@aepfle.de>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: Yanmin Zhang <yanmin.zhang@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: pcie_portdrv_restore_config undefined without CONFIG_PM
Message-ID: <20060928064755.GA16687@aepfle.de>
References: <20060927194235.GA9894@aepfle.de> <1159425359.20092.615.camel@ymzhang-perf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1159425359.20092.615.camel@ymzhang-perf.sh.intel.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, Zhang, Yanmin wrote:

> On Thu, 2006-09-28 at 03:42, Olaf Hering wrote:
> > PCI-Express AER implemetation: pcie_portdrv error handler
> > 
> > This patch breaks if CONFIG_PM is not enabled,
> > pcie_portdrv_restore_config() will be undefined.
> I move the definition of pcie_portdrv_restore_config
> out of CONFIG_PM.
> 
> Below patch is against 2.6.18-mm1. Could you try it?

This fixes arch/powerpc/configs/cell_defconfig. Thanks.
