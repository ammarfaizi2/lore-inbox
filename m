Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272427AbTGaJF4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 05:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272442AbTGaJFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 05:05:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:59112 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S272427AbTGaJFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 05:05:38 -0400
Date: Thu, 31 Jul 2003 11:05:34 +0200
From: Jens Axboe <axboe@suse.de>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-megaraid-devel@dell.com'" <linux-megaraid-devel@dell.com>
Subject: Re: [ANNOUNCE] megaraid 2.00.6 patch for kernels without hostlock
Message-ID: <20030731090534.GF22104@suse.de>
References: <0E3FA95632D6D047BA649F95DAB60E570230C551@EXA-ATLANTA.se.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230C551@EXA-ATLANTA.se.lsil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30 2003, Bagalkote, Sreenivas wrote:
> Please apply this patch to megaraid 2.00.6 driver for kernels that don't
> support per host lock. This can be found at :
> 
> ftp://ftp.lsil.com/pub/linux-megaraid/drivers/version-2.00.6/

It's easily possible to keep the impact of maintaining a driver across
such kernels a lot smaller, by simply using the same lock in the
spin_lock calls and just assign that lock to adapter->lock or
io_request_lock depending on the kernel.

-- 
Jens Axboe

