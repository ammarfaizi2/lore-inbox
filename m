Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbVHOVeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbVHOVeK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 17:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbVHOVeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 17:34:10 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:14032 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S964983AbVHOVeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 17:34:09 -0400
Subject: Re: [PATCH 3/4] cciss 2.4: adds 2 ioctls for ia64 based systems
From: James Bottomley <James.Bottomley@SteelEye.com>
To: mikem <mikem@beardog.cca.cpqcorp.net>
Cc: marcelo.tosatti@cyclades.com, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050815212224.GD12760@beardog.cca.cpqcorp.net>
References: <20050815212224.GD12760@beardog.cca.cpqcorp.net>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 16:32:53 -0500
Message-Id: <1124141573.5089.55.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-15 at 16:22 -0500, mikem wrote:
> +#ifdef CONFIG_IA64
> +        case BLKGETLASTSECT:
> +        case BLKSETLASTSECT:
> +#endif
>  		return blk_ioctl(inode->i_rdev, cmd, arg);

What makes these two ioctls IA64 specific?  I think they're completely
general in 2.4, so there's no need for the #ifdef.

James


