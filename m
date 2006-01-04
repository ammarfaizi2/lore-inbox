Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751603AbWADQjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbWADQjR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 11:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbWADQjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 11:39:17 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:28356 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751603AbWADQjQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 11:39:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jaQyoUP47ninyEXNhmnyXq0wbTya2L+zvEpCK5Wc+mDZ2Sf2kOQ5pxVTne0iNTr5UbLKHYarm1s3w8ZyRx7SNWPUIGBk0PRY8kTsNHzBCyFigBQYkNer9Y2U9LDnLRBd+qrBTR93glIsJETgO97HvJBjGqJXbkcJC0Lj5YfawmQ=
Message-ID: <9a8748490601040839s58a0a26en454f54459006077c@mail.gmail.com>
Date: Wed, 4 Jan 2006 17:39:14 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [-mm patch] i386: enable 4k stacks by default
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060104145138.GN3831@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060104145138.GN3831@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/06, Adrian Bunk <bunk@stusta.de> wrote:
> This patch enables 4k stacks by default.
>
> 4k stacks have become a well-tested feature used fore a long time in
> Fedora and even in RHEL 4.
>
> There are no known problems in in-kernel code with 4k stacks still
> present after Neil's patch that went into -mm nearly two months ago.
>
> Defaulting to 4k stacks in -mm kernel will give some more testing
> coverage and should show whether there are really no problems left.
>
> Keeping the option for now should make the people happy who want to use
> the experimental -mm kernel but don't trust the well-tested 4k stacks.
>
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> --- linux-2.6.15-rc5-mm3-full/arch/i386/Kconfig.debug.old       2006-01-04 11:43:55.000000000 +0100
> +++ linux-2.6.15-rc5-mm3-full/arch/i386/Kconfig.debug   2006-01-04 11:44:14.000000000 +0100
> @@ -53,8 +53,8 @@
>           If in doubt, say "N".
>
>  config 4KSTACKS
> -       bool "Use 4Kb for kernel stacks instead of 8Kb"
> -       depends on DEBUG_KERNEL
> +       bool "Use 4Kb for kernel stacks instead of 8Kb" if DEBUG_KERNEL

Why "if DEBUG_KERNEL" ?


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
