Return-Path: <linux-kernel-owner+w=401wt.eu-S932448AbWLLVtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWLLVtK (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 16:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWLLVtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 16:49:10 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:58547 "EHLO
	mail.clusterfs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932448AbWLLVtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 16:49:07 -0500
Date: Tue, 12 Dec 2006 14:49:04 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Josh Boyer <jwboyer@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, jffs-dev@axis.com,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH/RFC] Delete JFFS (version 1)
Message-ID: <20061212214904.GR5937@schatzie.adilger.int>
Mail-Followup-To: Josh Boyer <jwboyer@gmail.com>,
	Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, jffs-dev@axis.com,
	David Woodhouse <dwmw2@infradead.org>
References: <457EA2FE.3050206@garzik.org> <20061212095359.51483704.akpm@osdl.org> <625fc13d0612121038l22a2b252v3d3773caa8826e41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <625fc13d0612121038l22a2b252v3d3773caa8826e41@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 12, 2006  12:38 -0600, Josh Boyer wrote:
> On 12/12/06, Andrew Morton <akpm@osdl.org> wrote:
> >It would be good to provide unignorable notice of this in 2.6.20.  Via a
> >loud printk, or perhaps even CONFIG_BROKEN or CONFIG_EMBEDDED.
> 
> Something like the below?
> 
> Make CONFIG_JFFS depend on CONFIG_BROKEN
> 
> Signed-off-by: Josh Boyer <jwboyer@gmail.com>
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index b3b5aa0..4ac367d 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -1204,13 +1204,16 @@ config EFS_FS
> 
> config JFFS_FS
> 	tristate "Journalling Flash File System (JFFS) support"
> -	depends on MTD && BLOCK
> +	depends on MTD && BLOCK && BROKEN
> 	help
> 	  JFFS is the Journalling Flash File System developed by Axis
> 	  Communications in Sweden, aimed at providing a crash/powerdown-safe
> 	  file system for disk-less embedded devices. Further information is
> 	  available at (<http://developer.axis.com/software/jffs/>).
> 
> +	  NOTE: This filesystem is deprecated and is scheduled for removal in
> +	  2.6.21.  See Documentation/feature-removal-schedule.txt
> +

It would be better to have a printk in the module init, since users with
upstream builds won't see the config help.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

