Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265107AbUF1SAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265107AbUF1SAY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 14:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265135AbUF1SAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 14:00:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:12758 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265107AbUF1SAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 14:00:17 -0400
Date: Mon, 28 Jun 2004 10:59:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andre Noll <noll@mathematik.tu-darmstadt.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfsroot oops 2.6.7-current
Message-Id: <20040628105914.018cffe5.akpm@osdl.org>
In-Reply-To: <slrnce0lrs.tq5.noll@p133.mathematik.tu-darmstadt.de>
References: <slrnce0lrs.tq5.noll@p133.mathematik.tu-darmstadt.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Noll <noll@mathematik.tu-darmstadt.de> wrote:
>
> --- linux-2.5/net/sunrpc/rpc_pipe.c	31 May 2004 03:06:56 -0000	1.19
>  +++ linux-2.5/net/sunrpc/rpc_pipe.c	28 Jun 2004 17:10:51 -0000
>  @@ -433,6 +433,7 @@
>   	nd->dentry = dget(rpc_mount->mnt_root);
>   	nd->last_type = LAST_ROOT;
>   	nd->flags = LOOKUP_PARENT;
>  +	nd->depth = 0;

Neat, thanks.  Quite a few people have been hitting that.
