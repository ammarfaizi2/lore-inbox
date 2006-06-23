Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751752AbWFWQgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbWFWQgO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 12:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbWFWQgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 12:36:13 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:36265 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751752AbWFWQgN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 12:36:13 -0400
Date: Fri, 23 Jun 2006 11:35:40 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] make kernel/utsname.c:clone_uts_ns()
Message-ID: <20060623163540.GB32224@sergelap.austin.ibm.com>
References: <20060621034857.35cfe36f.akpm@osdl.org> <20060623105551.GR9111@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623105551.GR9111@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

True.

Acked-by: Serge Hallyn <serue@us.ibm.com>

thanks,
-serge

Quoting Adrian Bunk (bunk@stusta.de):
> This patch makes the needlessly global clone_uts_ns() static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.17-mm1-full/kernel/utsname.c.old	2006-06-22 20:53:20.000000000 +0200
> +++ linux-2.6.17-mm1-full/kernel/utsname.c	2006-06-22 20:53:31.000000000 +0200
> @@ -19,7 +19,7 @@
>   * @old_ns: namespace to clone
>   * Return NULL on error (failure to kmalloc), new ns otherwise
>   */
> -struct uts_namespace *clone_uts_ns(struct uts_namespace *old_ns)
> +static struct uts_namespace *clone_uts_ns(struct uts_namespace *old_ns)
>  {
>  	struct uts_namespace *ns;
>  
