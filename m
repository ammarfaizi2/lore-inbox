Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWBBXiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWBBXiZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 18:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWBBXiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 18:38:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52149 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932474AbWBBXiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 18:38:23 -0500
Date: Thu, 2 Feb 2006 15:40:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Dushistov <dushistov@mail.ru>
Cc: adobriyan@gmail.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: Re [2]: [PATCH] Mark CONFIG_UFS_FS_WRITE as BROKEN
Message-Id: <20060202154022.19776a93.akpm@osdl.org>
In-Reply-To: <20060201200410.GA11747@rain.homenetwork>
References: <20060131234634.GA13773@mipter.zuzino.mipt.ru>
	<20060201200410.GA11747@rain.homenetwork>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Dushistov <dushistov@mail.ru> wrote:
>
> On Wed, Feb 01, 2006 at 02:46:34AM +0300, Alexey Dobriyan wrote:
> > Copying files over several KB will buy you infinite loop in
> > __getblk_slow(). Copying files smaller than 1 KB seems to be OK.
> > Sometimes files will be filled with zeros. Sometimes incorrectly copied
> > file will reappear after next file with truncated size.
> The problem as can I see, in very strange code in
> balloc.c:ufs_new_fragments. b_blocknr is changed without "restraint".
> 
> This patch just "workaround", not a clear solution. But it helps me
> copy files more than 4K. Can you try it and say is it really help?

Thanks for working on this.  I won't apply these two patches at this stage
as things don't seem to be finalised.  But if you and Alexey could come up
with some final thing which resurrects UFS write support, that'd be great.
