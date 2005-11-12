Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbVKLHKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbVKLHKx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 02:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbVKLHKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 02:10:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44518 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932197AbVKLHKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 02:10:52 -0500
Date: Sat, 12 Nov 2005 07:10:47 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] removed useless SCSI_GENERIC_NCR5380_MMIO
Message-ID: <20051112071047.GA29051@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, James.Bottomley@SteelEye.com,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20051112043707.GX5376@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051112043707.GX5376@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 05:37:07AM +0100, Adrian Bunk wrote:
> This patch removes the useless SCSI_GENERIC_NCR5380_MMIO.
> 
> It's useless, since SCSI_G_NCR5380_MEM != CONFIG_SCSI_G_NCR5380_MEM.
> 
> This issue exists at least since kernel 2.6.0 and since it seems noone 
> noticed it I'd say we can safely remove it.

NACK.  I know at least Alan has hardware and might want to bring it
forward.  A better fix would be to convert the generic ncr5380 driver
to use ioread*/iowrite* so it can cover both mmio and pio in a single
binary.

