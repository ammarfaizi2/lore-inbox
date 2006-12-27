Return-Path: <linux-kernel-owner+w=401wt.eu-S1753598AbWL0I1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753598AbWL0I1G (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 03:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753545AbWL0I1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 03:27:06 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36967 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598AbWL0I1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 03:27:05 -0500
Date: Wed, 27 Dec 2006 08:27:02 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Horms <horms@verge.net.au>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [patch] linux/preempt.h needs linux/thread_info.h
Message-ID: <20061227082702.GO17561@ftp.linux.org.uk>
References: <20061227081701.GA19379@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061227081701.GA19379@verge.net.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2006 at 05:17:02PM +0900, Horms wrote:
> It seems that linux/preempt.h needs to include linux/thread_info.h
> in order to access current_thread_info(), which is used in
> preempt_count().
> 
> I guess that all callers of preempt_count() must include
> both linux/thread_info.h and linux/preempt.h directly or indirectly,
> as this does not cause a compile error. I noticed the problem while
> working on an unrelated issue in xen-land.
> 
> Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> Index: linux-2.6/include/linux/preempt.h
> ===================================================================
> --- linux-2.6.orig/include/linux/preempt.h	2006-12-27 16:58:46.000000000 +0900
> +++ linux-2.6/include/linux/preempt.h	2006-12-27 17:13:12.000000000 +0900
> @@ -8,6 +8,7 @@
>  
>  #include <linux/thread_info.h>
>  #include <linux/linkage.h>
> +#include <linux/thread_info.h>

Huh?  It's just been included two lines above...
