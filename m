Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbWGETiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbWGETiY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 15:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbWGETiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 15:38:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47336 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965004AbWGETiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 15:38:23 -0400
Date: Wed, 5 Jul 2006 12:41:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, bernds_cb1@t-online.de, sam@ravnborg.org,
       dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] FDPIC: Fix FDPIC compile errors [try #2]
Message-Id: <20060705124142.7bec7597.akpm@osdl.org>
In-Reply-To: <20060705175443.12594.30741.stgit@warthog.cambridge.redhat.com>
References: <20060705175440.12594.43069.stgit@warthog.cambridge.redhat.com>
	<20060705175443.12594.30741.stgit@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> From: David Howells <dhowells@redhat.com>
> 
> The attached patch fixes FDPIC compile errors
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/binfmt_elf_fdpic.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index eba4e23..07624b9 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -459,6 +459,7 @@ #endif
>  	 */
>  	hwcap = ELF_HWCAP;
>  	k_platform = ELF_PLATFORM;
> +	u_platform = NULL;
>  
>  	if (k_platform) {
>  		platform_len = strlen(k_platform) + 1;

Methinks it actually fixes a warning, which was promoted to an error by
-Werror.  Which was fixed by adding an unneeded assignment, all becasue gcc
is dumb.

