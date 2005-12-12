Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbVLLHbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbVLLHbV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 02:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbVLLHbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 02:31:21 -0500
Received: from rgminet01.oracle.com ([148.87.122.30]:576 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751117AbVLLHbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 02:31:20 -0500
Date: Sun, 11 Dec 2005 23:27:53 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Mark Fasheh <mark.fasheh@oracle.com>,
       Kurt Hackel <kurt.hackel@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] fs/ocfs2/file.c: make ocfs2_extend_allocation() static
Message-ID: <20051212072753.GP18439@ca-server1.us.oracle.com>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, Mark Fasheh <mark.fasheh@oracle.com>,
	Kurt Hackel <kurt.hackel@oracle.com>, linux-kernel@vger.kernel.org
References: <20051211215424.GA23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051211215424.GA23349@stusta.de>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2005 at 10:54:24PM +0100, Adrian Bunk wrote:
> This patch makes the needlessly global function 
> ocfs2_extend_allocation() static.

	Already in our tree, from your last post, but I've been bad
about keeping the git tree up to date.  It will appear tomorrow.  And
feel free to keep kicking us in the butt on such topics.

Joel

> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
> This patch was already sent on:
> - 11 Nov 2005
> 
> --- linux-2.6.14-mm2-full/fs/ocfs2/file.c.old	2005-11-11 16:55:01.000000000 +0100
> +++ linux-2.6.14-mm2-full/fs/ocfs2/file.c	2005-11-11 16:55:19.000000000 +0100
> @@ -413,8 +413,8 @@
>  	return status;
>  }
>  
> -int ocfs2_extend_allocation(struct inode *inode,
> -			    u32 clusters_to_add)
> +static int ocfs2_extend_allocation(struct inode *inode,
> +				   u32 clusters_to_add)
>  {
>  	int status = 0;
>  	int restart_func = 0;
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

Life's Little Instruction Book #232

	"Keep your promises."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

