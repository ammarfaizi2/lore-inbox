Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758826AbWK2KGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758826AbWK2KGG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 05:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758825AbWK2KGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 05:06:05 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33979 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1758822AbWK2KGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 05:06:01 -0500
Date: Wed, 29 Nov 2006 10:06:00 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/sysv/: proper prototypes for 2 functions
Message-ID: <20061129100600.GA28151@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <20061129100405.GI11084@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129100405.GI11084@stusta.de>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 11:04:05AM +0100, Adrian Bunk wrote:
> This patch adds proper prototypes for sysv_{init,destroy}_icache()
> in sysv.h
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  fs/sysv/super.c |    3 ---
>  fs/sysv/sysv.h  |    3 +++
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> --- linux-2.6.19-rc6-mm2/fs/sysv/sysv.h.old	2006-11-29 09:21:02.000000000 +0100
> +++ linux-2.6.19-rc6-mm2/fs/sysv/sysv.h	2006-11-29 09:21:52.000000000 +0100
> @@ -143,6 +143,9 @@
>  extern int sysv_sync_file(struct file *, struct dentry *, int);
>  extern void sysv_set_inode(struct inode *, dev_t);
>  extern int sysv_getattr(struct vfsmount *, struct dentry *, struct kstat *);
> +int sysv_init_icache(void);
> +void sysv_destroy_icache(void);

Please follow the style used in the rest of the file and add the
extern keyword.

> +

And don't add a superflous blank line.

Except for that the patch is fine.
