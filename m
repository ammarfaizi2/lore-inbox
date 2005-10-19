Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751539AbVJSGEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbVJSGEb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 02:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbVJSGEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 02:04:30 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:8852 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1751527AbVJSGEa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 02:04:30 -0400
Date: Wed, 19 Oct 2005 08:05:37 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Kai Germaschewski <kai@germaschewski.name>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.14-rc4][RESEND] Export RCS_TAR_IGNORE for rpm targets
Message-ID: <20051019060537.GA7868@mars.ravnborg.org>
References: <20051018234512.GA13887@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018234512.GA13887@smtp.west.cox.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew - please apply. It's an obvious bugfix.

	Sam
	
On Tue, Oct 18, 2005 at 04:45:12PM -0700, Tom Rini wrote:
> [ Originally sent Oct 10, no comments but should be clearly correct ]
> 
> The variable RCS_TAR_IGNORE is used in scripts/packaging/Makefile, but
> not exported from the main Makefile, so it's never used.
> 
> This results in the rpm targets being very unhappy in quilted trees.
> 
> Signed-off-by: Tom Rini <trini@kernel.crashing.org>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

> 
> diff --git a/Makefile b/Makefile
> --- a/Makefile
> +++ b/Makefile
> @@ -372,7 +372,7 @@ export MODVERDIR := $(if $(KBUILD_EXTMOD
>  # Files to ignore in find ... statements
>  
>  RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc -o -name .hg \) -prune -o
> -RCS_TAR_IGNORE := --exclude SCCS --exclude BitKeeper --exclude .svn --exclude CVS --exclude .pc --exclude .hg
> +export RCS_TAR_IGNORE := --exclude SCCS --exclude BitKeeper --exclude .svn --exclude CVS --exclude .pc --exclude .hg
>  
>  # ===========================================================================
>  # Rules shared between *config targets and build targets
> 
> -- 
> Tom Rini
> http://gate.crashing.org/~trini/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
