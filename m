Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWESCmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWESCmM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 22:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWESCmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 22:42:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:2091 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932190AbWESCmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 22:42:10 -0400
X-IronPort-AV: i="4.05,143,1146466800"; 
   d="scan'208"; a="38421364:sNHT25908918"
Subject: Re: [Ipw2100-devel] [TRIVIAL] ipw2200: fix a gcc compile warning
From: Zhu Yi <yi.zhu@intel.com>
To: "jens m. noedler" <noedler@web.de>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org,
       ipw2100-devel@lists.sourceforge.net
In-Reply-To: <446C8BEE.2080807@web.de>
References: <446C8BEE.2080807@web.de>
Content-Type: text/plain
Organization: Intel Corp.
Date: Fri, 19 May 2006 10:42:44 +0800
Message-Id: <1148006564.16334.4.camel@debian.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-18 at 16:59 +0200, jens m. noedler wrote:
> --- drivers/net/wireless/ipw2200.c.orig 2006-05-18 16:26:39.000000000 +0200
> +++ drivers/net/wireless/ipw2200.c      2006-05-18 16:26:58.000000000 +0200
> @@ -45,8 +45,11 @@ MODULE_VERSION(DRV_VERSION);
>  MODULE_AUTHOR(DRV_COPYRIGHT);
>  MODULE_LICENSE("GPL");
> 
> -static int cmdlog = 0;
> +#ifdef CONFIG_IPW2200_DEBUG
>  static int debug = 0;
> +#endif
> +
> +static int cmdlog = 0;
>  static int channel = 0;
>  static int mode = 0;

The patch is already in wireless-2.6 GIT. Thank you anyway.

Thanks,
-yi
