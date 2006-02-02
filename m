Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWBBXak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWBBXak (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 18:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWBBXak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 18:30:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61107 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932467AbWBBXaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 18:30:39 -0500
Date: Thu, 2 Feb 2006 15:32:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] extract-ikconfig: be sure binoffset exists before
 extracting
Message-Id: <20060202153241.48b206fb.akpm@osdl.org>
In-Reply-To: <20060201125658.GB8943@mipter.zuzino.mipt.ru>
References: <20060201125658.GB8943@mipter.zuzino.mipt.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  scripts/extract-ikconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/scripts/extract-ikconfig
> +++ b/scripts/extract-ikconfig
> @@ -4,6 +4,7 @@
>  # $arg1 is [b]zImage filename
>  
>  binoffset="./scripts/binoffset"
> +test -e $binoffset || cc -o $binoffset ./scripts/binoffset.c || exit 1
>  

OK, but it would be better if we could find a way of doing this within a
Makefile.

