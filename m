Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317767AbSHNMjz>; Wed, 14 Aug 2002 08:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317793AbSHNMjz>; Wed, 14 Aug 2002 08:39:55 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:17936 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317767AbSHNMjy>; Wed, 14 Aug 2002 08:39:54 -0400
Date: Wed, 14 Aug 2002 13:43:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Kendrick M. Smith" <kmsmith@umich.edu>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: patch 38/38: SERVER: giant patch importing NFSv4 server functionality
Message-ID: <20020814134347.B14609@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Kendrick M. Smith" <kmsmith@umich.edu>,
	linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
References: <Pine.SOL.4.44.0208131912340.25942-100000@rastan.gpcc.itd.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.SOL.4.44.0208131912340.25942-100000@rastan.gpcc.itd.umich.edu>; from kmsmith@umich.edu on Tue, Aug 13, 2002 at 07:12:53PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 07:12:53PM -0400, Kendrick M. Smith wrote:
> --- old/fs/nfsd/nfssvc.c	Fri Aug  9 11:16:02 2002
> +++ new/fs/nfsd/nfssvc.c	Thu Aug  8 09:53:23 2002
> @@ -77,6 +77,18 @@ nfsd_svc(unsigned short port, int nrserv
>  	int	none_left;
>  	struct list_head *victim;
> 
> +#ifdef CONFIG_NFSD_V4
> +	printk(KERN_INFO "Starting experimental NFSv4 server.\n");
> +	printk(KERN_INFO "Note 1: The NFSv4 pseudo filesystem is not yet implemented!\n");
> +	printk(KERN_INFO "   The first export in your /etc/exports has been arbitrarily\n");
> +	printk(KERN_INFO "   selected as the root of the pseudofs.  In order to see this\n");
> +	printk(KERN_INFO "   export, you will have to mount '/' instead of the export pathname.\n");
> +	printk(KERN_INFO "   Exports other than this one will not be available.\n");
> +	printk(KERN_INFO "Note 2: Most of the NFSv4 state model is not yet implemented;\n");
> +	printk(KERN_INFO "   this server patch should still provide basic functionality.\n");
> +	printk(KERN_INFO "   However, byte-range file locking is not available.\n");
> +#endif

This belongs into a readme, not into kernel messages..

