Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263253AbVBCRbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263253AbVBCRbw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 12:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263216AbVBCR3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 12:29:50 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22022 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263841AbVBCR2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 12:28:47 -0500
Date: Thu, 3 Feb 2005 18:28:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Matthew Wilcox <matthew@wil.cx>, Joel Soete <soete.joel@tiscali.be>,
       Roman Zippel <zippel@linux-m68k.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: NFSD needs EXPORTFS
Message-ID: <20050203172844.GC3121@stusta.de>
References: <20050203170111.GE20386@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050203170111.GE20386@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 05:01:11PM +0000, Matthew Wilcox wrote:
> 
> Got this report about 2.6.11-rc3.  Is this the correct solution?
> 
> ----- Forwarded message from Joel Soete <soete.joel@tiscali.be> -----
> 
> A short analyse, it seems that's because NFSD was builtin while EXPORTFS
> was a module in my previous config file. Imho EXPORTFS would be build as
> NFSD?
> 
> Is the following hunk would do the trick:
> --- fs/Kconfig.Orig     2005-02-03 16:45:13.562275206 +0100
> +++ fs/Kconfig  2005-02-03 16:46:36.496469111 +0100
> @@ -1400,6 +1400,7 @@
>         tristate "NFS server support"
>         depends on INET
>         select LOCKD
> +       select EXPORTFS
>         select SUNRPC
>         help
>           If you want your Linux box to act as an NFS *server*, so that other
> ========><========
> 
> Thanks in advance,
>     Joel


If the problem occured with CONFIG_XFS_FS=m I understand what went 
wrong.

It seems to be correct.

This was a side effect of Roman's fix for the XFS <-> EXPORTFS 
dependency.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

