Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264327AbTDPMRE (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 08:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264329AbTDPMRE 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 08:17:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41742 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264327AbTDPMRE (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 08:17:04 -0400
Date: Wed, 16 Apr 2003 14:28:56 +0200
From: Jan Kara <jack@suse.cz>
To: Pavel Roskin <proski@gnu.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [TRIVIAL PATCH] sync_dquots_dev in Linux 2.4.21-pre7-ac1
Message-ID: <20030416122856.GA21806@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.53.0304151217310.28540@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0304151217310.28540@marabou.research.att.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> sync_dquots_dev() is only implemented if CONFIG_QUOTA is defined.
> However, quote.c uses it unconditionally.  include/linux/quotaops.h has
> some macros to disable some functions when CONFIG_QUOTA is undefined, so
> it's probably where the fix belongs.  This patch helps:
> 
> ==============================
> --- linux.orig/include/linux/quotaops.h
> +++ linux/include/linux/quotaops.h
> @@ -193,6 +193,7 @@
>  #define DQUOT_SYNC_SB(sb)			do { } while(0)
>  #define DQUOT_OFF(sb)				do { } while(0)
>  #define DQUOT_TRANSFER(inode, iattr)		(0)
> +#define sync_dquots_dev(dev, type)		do { } while(0)
>  extern __inline__ int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
>  {
>  	lock_kernel();
> ==============================
  Oops... Yes. Please apply the patch Alan.

								Thanks
									Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
