Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVC1RHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVC1RHp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 12:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVC1RHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 12:07:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:65423 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261955AbVC1RHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 12:07:36 -0500
Date: Mon, 28 Mar 2005 18:07:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: ecashin@noserose.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11] aoe [7/12]: support configuration of AOE_PARTITIONS from Kconfig
Message-ID: <20050328170735.GA9567@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	ecashin@noserose.net, linux-kernel@vger.kernel.org
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com> <1111677688.29912@geode.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111677688.29912@geode.he.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 07:21:28AM -0800, ecashin@noserose.net wrote:
> 
> support configuration of AOE_PARTITIONS from Kconfig
> 
> Signed-off-by: Ed L. Cashin <ecashin@coraid.com>
> 
> diff -uprN a/drivers/block/Kconfig b/drivers/block/Kconfig
> --- a/drivers/block/Kconfig	2005-03-07 17:37:58.000000000 -0500
> +++ b/drivers/block/Kconfig	2005-03-10 12:19:54.000000000 -0500
> @@ -506,4 +506,19 @@ config ATA_OVER_ETH
>  	This driver provides Support for ATA over Ethernet block
>  	devices like the Coraid EtherDrive (R) Storage Blade.
>  
> +config AOE_PARTITIONS
> +	int "Partitions per AoE device" if ATA_OVER_ETH
> +	default "16"
> +	help
> +	  The default is to support 16 partitions per aoe device. Some
> +	  systems lack good support for devices with large minor
> +	  numbers.
> +
> +	  Such systems will be able to use more aoe disks when
> +	  AOE_PARTITIONS is set to one, but you won't be able to
> +	  partition the disks, and you must make sure your device
> +	  nodes are created to work with the value you select.
> +
> +	  If unsure, use 16.
> +

NACK.  this changes devices nodes based on a compile-time option.  Just
tell people to update their userland to a 2.6-copatible version.

