Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVEJBfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVEJBfV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 21:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVEJBfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 21:35:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:12966 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261489AbVEJBep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 21:34:45 -0400
Date: Mon, 9 May 2005 18:34:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: blaisorblade@yahoo.it
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
Subject: Re: [patch 1/6] uml: remove elf.h [ compile-fix, for 2.6.12 ]
Message-Id: <20050509183401.28082cbc.akpm@osdl.org>
In-Reply-To: <20050509224509.0C105416E4@zion>
References: <20050509224509.0C105416E4@zion>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blaisorblade@yahoo.it wrote:
>
> 
> Actually remove elf.h in the tree. The previous patch, due to a quilt
> bug/misuse, left it in the tree as a 0-length file, preventing the build to
> see it as missing and to generate a symlink in its place.
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> ---
> 
>   |    0 
>  1 files changed
> 
> diff -L include/asm-um/elf.h -puN include/asm-um/elf.h~uml-remove-elf-h /dev/null

hmm, that's exciting.  How to tell diff and patch to remove a zero-length
file?

bix:/home/akpm> mkdir a b
bix:/home/akpm> touch a/a
bix:/home/akpm> diff -uNr a b
bix:/home/akpm> diff -u a b  
Only in a: a
bix:/home/akpm> diff -ur a b
Only in a: a
bix:/home/akpm> diff -uPr a b
Only in a: a

I'll just ask Linus to delete it ;)
