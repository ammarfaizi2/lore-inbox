Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWINBTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWINBTu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 21:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWINBTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 21:19:49 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:49070 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1751296AbWINBTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 21:19:48 -0400
Date: Thu, 14 Sep 2006 11:19:48 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/7] Implement a general integer log2 facility in the
 kernel [try #3]
Message-Id: <20060914111948.3c11242d.sfr@canb.auug.org.au>
In-Reply-To: <20060913183529.22109.76479.stgit@warthog.cambridge.redhat.com>
References: <20060913183522.22109.10565.stgit@warthog.cambridge.redhat.com>
	<20060913183529.22109.76479.stgit@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Just a small nit ...

On Wed, 13 Sep 2006 19:35:29 +0100 David Howells <dhowells@redhat.com> wrote:
>
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index 681dea8..b4b4eae 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -784,9 +782,9 @@ static int ext2_fill_super(struct super_
>  	sbi->s_sbh = bh;
>  	sbi->s_mount_state = le16_to_cpu(es->s_state);
>  	sbi->s_addr_per_block_bits =
> -		log2 (EXT2_ADDR_PER_BLOCK(sb));
> +		ilog2 (EXT2_ADDR_PER_BLOCK(sb));
>  	sbi->s_desc_per_block_bits =
> -		log2 (EXT2_DESC_PER_BLOCK(sb));
> +		ilog2 (EXT2_DESC_PER_BLOCK(sb));

While you are here, could you get rid of the spaces before the parentheses?

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
