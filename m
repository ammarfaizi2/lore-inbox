Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWHPXfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWHPXfF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 19:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWHPXfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 19:35:04 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:51178 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751241AbWHPXfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 19:35:01 -0400
Date: Wed, 16 Aug 2006 16:35:48 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Josh Triplett <josht@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Dipkanar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH] rcu: Fix incorrect description of default for rcutorture nreaders parameter
Message-ID: <20060816233548.GB1291@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1155766624.9175.34.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155766624.9175.34.camel@josh-work.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 03:17:04PM -0700, Josh Triplett wrote:
> The comment for the nreaders parameter of rcutorture gives the default as
> 4*ncpus, but the value actually defaults to 2*ncpus; fix the comment.


Acked-by: Paul E. McKenney <paulmck@us.ibm.com>
> Signed-off-by: Josh Triplett <josh@freedesktop.org>
> ---
>  kernel/rcutorture.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
> index 0778a3d..e34d22b 100644
> --- a/kernel/rcutorture.c
> +++ b/kernel/rcutorture.c
> @@ -48,7 +48,7 @@ #include <linux/srcu.h>
>  
>  MODULE_LICENSE("GPL");
>  
> -static int nreaders = -1;	/* # reader threads, defaults to 4*ncpus */
> +static int nreaders = -1;	/* # reader threads, defaults to 2*ncpus */
>  static int stat_interval;	/* Interval between stats, in seconds. */
>  				/*  Defaults to "only at end of test". */
>  static int verbose;		/* Print more debug info. */
> -- 
> 1.4.1.1
> 
> 
