Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751516AbWJPLMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbWJPLMa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 07:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWJPLMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 07:12:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27540 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751512AbWJPLM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 07:12:29 -0400
Subject: Re: [PATCH] gfs2 endianness bug: be16 assigned to be32 field
From: Steven Whitehouse <swhiteho@redhat.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20061014154930.GL29920@ftp.linux.org.uk>
References: <20061014154930.GL29920@ftp.linux.org.uk>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 16 Oct 2006 12:19:02 +0100
Message-Id: <1160997542.27980.82.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I the light of my earlier reply to Linus, I've applied this to the GFS2
git tree. Thanks,

Steve.
 
On Sat, 2006-10-14 at 16:49 +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/gfs2/dir.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
> index 459498c..d43caf0 100644
> --- a/fs/gfs2/dir.c
> +++ b/fs/gfs2/dir.c
> @@ -815,7 +815,7 @@ static struct gfs2_leaf *new_leaf(struct
>  	leaf = (struct gfs2_leaf *)bh->b_data;
>  	leaf->lf_depth = cpu_to_be16(depth);
>  	leaf->lf_entries = 0;
> -	leaf->lf_dirent_format = cpu_to_be16(GFS2_FORMAT_DE);
> +	leaf->lf_dirent_format = cpu_to_be32(GFS2_FORMAT_DE);
>  	leaf->lf_next = 0;
>  	memset(leaf->lf_reserved, 0, sizeof(leaf->lf_reserved));
>  	dent = (struct gfs2_dirent *)(leaf+1);

