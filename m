Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262641AbUJ0UcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbUJ0UcS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 16:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbUJ0U31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:29:27 -0400
Received: from waste.org ([209.173.204.2]:26281 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262671AbUJ0U1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:27:50 -0400
Date: Wed, 27 Oct 2004 15:27:33 -0500
From: Matt Mackall <mpm@selenic.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Rename SECTOR_SIZE to BIO_SECTOR_SIZE
Message-ID: <20041027202733.GG28904@waste.org>
References: <20041027060828.GA32396@taniwha.stupidest.org> <417F4497.3020205@pobox.com> <20041027065524.GA1524@taniwha.stupidest.org> <20041027072212.GN15910@suse.de> <20041027190523.GA19330@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027190523.GA19330@taniwha.stupidest.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 12:05:23PM -0700, Chris Wedgwood wrote:
> Rename (one of the uses of) SECTOR_SIZE to BIO_SECTOR_SIZE which is
> more appropriate.

> Index: cw-current/include/linux/ide.h
> ===================================================================
> --- cw-current.orig/include/linux/ide.h	2004-10-27 11:33:06.237319044 -0700
> +++ cw-current/include/linux/ide.h	2004-10-27 11:35:13.246711414 -0700
> @@ -202,8 +202,8 @@
>  #define PARTN_BITS	6	/* number of minor dev bits for partitions */
>  #define PARTN_MASK	((1<<PARTN_BITS)-1)	/* a useful bit mask */
>  #define MAX_DRIVES	2	/* per interface; 2 assumed by lots of code */
> -#define SECTOR_SIZE	512
> -#define SECTOR_WORDS	(SECTOR_SIZE / 4)	/* number of 32bit words per sector */
> +#define BIO_SECTOR_SIZE	512
> +#define SECTOR_WORDS	(BIO_SECTOR_SIZE / 4)	/* number of 32bit words per sector */
>  #define IDE_LARGE_SEEK(b1,b2,t)	(((b1) > (b2) + (t)) || ((b2) > (b1) + (t)))

So shouldn't this be in bio.h now?

-- 
Mathematics is the supreme nostalgia of our time.
