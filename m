Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbUJXKN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbUJXKN2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 06:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUJXKLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 06:11:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:52203 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261424AbUJXKK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 06:10:58 -0400
Date: Sun, 24 Oct 2004 03:08:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: torvalds@osdl.org, sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.9-bk7] Select cpio_list or source directory for
 initramfs image updates [u]
Message-Id: <20041024030844.18f2fedd.akpm@osdl.org>
In-Reply-To: <1098533188.668.9.camel@nosferatu.lan>
References: <200410200849.i9K8n5921516@mail.osdl.org>
	<1098533188.668.9.camel@nosferatu.lan>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin Schlemmer [c]" <azarah@nosferatu.za.org> wrote:
>
> Here is some updates after talking to Sam Ravnborg.  He did not yet come
>  back to me, I am not sure if I understood 100% what he meant, but hopefully
>  somebody else will be so kind as to comment.
> 
>  Here is a shortish changelog:
> 
>  - Fix an issue reported by Esben Nielsen <simlo@phys.au.dk> (with
>  suggestion from Sam Ravnborg).  Build failed if $O (output dir) was
>  set.  This is done by pre-pending $srctree if the shipped list is
>  referenced.
> 
>  - Also fix calling of gen_initramfs_list.sh if $O (output dir) is set
>  by pre-pending $srctree.
> 
>  - I also moved initramfs_list to initramfs_list.shipped, to make sure we
>  always have an 'fall back' list (say you unset CONFIG_INITRAMFS_SOURCE
>  and deleted your custom intramfs source directory, then building will not
>  fail).
> 
>  - Kbuild style cleanups.
> 
>  - Improved error checking.  For example gen_initramfs_list.sh will
>  output a simple list if the target directory is empty, and we verify
>  that the shipped initramfs_list is present before touching it.
> 
>  - Only update the temp initramfs_list if the source list/directory have
>  changed.
> 
>  - Cleanup temporary initramfs_list when 'make clean' or 'make mrproper'
>  is called.
> 
> 
>  This patch should apply to both 2.6.9-bk7 and 2.6.9-mm1.

hmm.  You have a patch in the email body and two slightly different patches
as attachments.  All bases covered ;)

I'll stick
"select-cpio_list-or-source-directory-for-initramfs-image-v7.patch" into
-mm but would prefer that this patch come in via Sam's tree please.

