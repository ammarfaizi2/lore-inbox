Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbWAXI6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWAXI6x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 03:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbWAXI6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 03:58:53 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:8413 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030393AbWAXI6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 03:58:52 -0500
Date: Tue, 24 Jan 2006 09:58:51 +0100
From: Jan Kara <jack@suse.cz>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: [Patch] quota: remove unused sync_dquots_dev()
Message-ID: <20060124085850.GC6811@atrey.karlin.mff.cuni.cz>
References: <20060124044326.GB27513@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060124044326.GB27513@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> browsing through the quota code, I found that the
> already removed sync_dquots_dev(dev,type) is still
> defined in the no-quota case, so here is a patch
> to remove this unused define ...
  Yes, that's unused for some while. Please send it to Andrew/Linus
for inclusion.

> Signed-off-by: Herbert Pötzl <herbert@13thfloor.at>
  Acked-by: Jan Kara <jack@suse.cz>

								Honza
							
> --- ./include/linux/quotaops.h.orig	2006-01-03 17:30:10 +0100
> +++ ./include/linux/quotaops.h	2006-01-24 05:36:57 +0100
> @@ -190,7 +190,6 @@ static __inline__ int DQUOT_OFF(struct s
>   */
>  #define sb_dquot_ops				(NULL)
>  #define sb_quotactl_ops				(NULL)
> -#define sync_dquots_dev(dev,type)		(NULL)
>  #define DQUOT_INIT(inode)			do { } while(0)
>  #define DQUOT_DROP(inode)			do { } while(0)
>  #define DQUOT_ALLOC_INODE(inode)		(0)
> 
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
