Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWG2JH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWG2JH3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 05:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWG2JH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 05:07:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:24979 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750763AbWG2JH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 05:07:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=EFAFXlmFqAydhuvicZguiaUu/xXudA+qELwgzx1uZ1hoeLzthB+qG/O9gYPB4+9zakUkJuaaD/5z9AbrqdxBKpVsvW4yNkDKXFegfRP0pi/EWj0AB5XWy8maHVSw1uSkD0fDwvRURyVos0kyDWRjnxvFKt94pQWREsmTeN8gal0=
Date: Sat, 29 Jul 2006 13:07:25 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@mars.ravnborg.org>
Subject: Re: [PATCH] kbuild: hardcode value of YACC&LEX for aic7-triple-x
Message-ID: <20060729090725.GF6843@martell.zuzino.mipt.ru>
References: <20060729071540.GA6738@mars.ravnborg.org> <11541575812597-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11541575812597-git-send-email-sam@ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 09:19:33AM +0200, sam@ravnborg.org wrote:
> When we introduced -rR then aic7xxx no loger could pick up definition
> of YACC&LEX from make - so do it explicit now.

> --- a/drivers/scsi/aic7xxx/aicasm/Makefile
> +++ b/drivers/scsi/aic7xxx/aicasm/Makefile
> @@ -14,6 +14,8 @@ LIBS=	-ldb
>  clean-files:= ${GENSRCS} ${GENHDRS} $(YSRCS:.y=.output) $(PROG)
>  # Override default kernel CFLAGS.  This is a userland app.
>  AICASM_CFLAGS:= -I/usr/include -I.
> +LEX= flex
> +YACC= bison
>  YFLAGS= -d
>  
>  NOMAN=	noman

SuSv3 lists "lex" and "yacc" as _the_ names. Is there any distro which
doesn't install compat symlinks?

