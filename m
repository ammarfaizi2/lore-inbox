Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbWGFNka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbWGFNka (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 09:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWGFNka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 09:40:30 -0400
Received: from canuck.infradead.org ([205.233.218.70]:34720 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1030266AbWGFNka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 09:40:30 -0400
Subject: Re: [PATCH 1/6] FDPIC: Fix FDPIC compile errors [try #3]
From: David Woodhouse <dwmw2@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, bernds_cb1@t-online.de, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060706124719.7098.73359.stgit@warthog.cambridge.redhat.com>
References: <20060706124716.7098.5752.stgit@warthog.cambridge.redhat.com>
	 <20060706124719.7098.73359.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 14:40:17 +0100
Message-Id: <1152193217.2987.182.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 13:47 +0100, David Howells wrote:
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

Isn't this just working around a compiler problem -- a spurious warning?
It certainly shouldn't be a 'compile error',

-- 
dwmw2

