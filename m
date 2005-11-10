Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbVKJMcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVKJMcW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 07:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbVKJMcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 07:32:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13003 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750809AbVKJMcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 07:32:22 -0500
Date: Thu, 10 Nov 2005 04:28:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-Id: <20051110042857.38b4635b.akpm@osdl.org>
In-Reply-To: <20051107200336.GH3847@stusta.de>
References: <20051107200336.GH3847@stusta.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> Currently, using an undeclared function gives a compile warning, but it 
>  can lead to a nasty runtime error if the prototype of the function is 
>  different from what gcc guessed.
> 
>  With -Werror-implicit-function-declaration, we are getting an immediate 
>  compile error instead.
> 
>  There will be some compile errors in cases where compilation previously
>  worked because the undefined function wasn't called due to gcc dead code
>  elimination, but in these cases a proper fix doesnt harm.
> 

Sorry, I need to build allmodconfig kernels on wacky architectures (eg
ppc64) and this patch is killing me.

