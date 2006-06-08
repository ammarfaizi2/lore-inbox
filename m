Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbWFHRrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWFHRrB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 13:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbWFHRrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 13:47:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:906 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964925AbWFHRrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 13:47:01 -0400
Date: Thu, 8 Jun 2006 10:46:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Suzuki <suzuki@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fix Compilation error for UM Linux
Message-Id: <20060608104655.70c6836f.akpm@osdl.org>
In-Reply-To: <44883C68.8010307@in.ibm.com>
References: <44883C68.8010307@in.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jun 2006 20:34:08 +0530
Suzuki <suzuki@in.ibm.com> wrote:

> Hi,
> 
> This patch fixes the compilation error for UM Linux with linux-2.6.17-rc5.
> 
> It complains of using (void *) in arithmetic.

Really?  We often do arithmetic on void*.  Are you using gcc, with standard
kbuild and standard compiler options?

> Thanks.
> 
> Suzuki K P
> Linux Technology Center,
> IBM Software Labs.
> 
> 
> 
> * Fix the compilation error for um-linux.
> 
> Signed Off by: Suzuki K P <suzuki@in.ibm.com>

"Signed-off-by:", please.

> --- arch/um/include/mem.h       2006-05-25 01:45:04.000000000 -0700
> +++ arch/um/include/mem.h~fix_compilation_error 2006-06-08 
> 07:46:21.000000000 -0700
> @@ -22,7 +22,7 @@ static inline unsigned long to_phys(void
> 
>   static inline void *to_virt(unsigned long phys)
>   {
> -       return((void *) uml_physmem + phys);
> +       return (void *) (uml_physmem + phys);
>   }
> 
>   #endif
