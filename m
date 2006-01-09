Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbWAIRVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbWAIRVu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbWAIRVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:21:50 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:29668 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1030197AbWAIRVt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:21:49 -0500
Date: Mon, 9 Jan 2006 10:21:49 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Jeff Mahoney <jeffm@suse.com>
Cc: linux-ia64@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ia64: including <asm/signal.h> alone causes compilation errors
Message-ID: <20060109172149.GQ19769@parisc-linux.org>
References: <20060109171514.GA25096@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109171514.GA25096@locomotive.unixthugs.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 12:15:14PM -0500, Jeff Mahoney wrote:
> +++ linux-2.6.15-ocfs2/include/asm-ia64/signal.h	2006-01-09 11:08:16.404700640 -0500
> @@ -1,6 +1,8 @@
>  #ifndef _ASM_IA64_SIGNAL_H
>  #define _ASM_IA64_SIGNAL_H
>  
> +#include <linux/types.h>
> +
>  /*
>   * Modified 1998-2001, 2003
>   *	David Mosberger-Tang <davidm@hpl.hp.com>, Hewlett-Packard Co
> @@ -122,8 +124,6 @@
>  
>  # ifndef __ASSEMBLY__
>  
> -#  include <linux/types.h>
> -
>  /* Avoid too many header ordering problems.  */
>  struct siginfo;

Is it still possible to include this file from assembly?  Do we still
need to do that?
