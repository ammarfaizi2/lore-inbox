Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424279AbWKPQYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424279AbWKPQYl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 11:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424276AbWKPQYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 11:24:41 -0500
Received: from ns1.coraid.com ([65.14.39.133]:28995 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1424278AbWKPQYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 11:24:40 -0500
Date: Thu, 16 Nov 2006 11:15:56 -0500
From: "Ed L. Cashin" <ecashin@coraid.com>
To: Dennis Stosberg <dennis@stosberg.net>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aoe: Add forgotten NULL at end of attribute list in aoeblk.c
Message-ID: <20061116161556.GA7222@coraid.com>
References: <20061113081520.G77d5ed8a@leonov.stosberg.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061113081520.G77d5ed8a@leonov.stosberg.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 09:15:20AM +0100, Dennis Stosberg wrote:
> This caused the system to stall when the aoe module was loaded.  The
> error was introduced in commit 4ca5224f3ea4779054d96e885ca9b3980801ce13

Boy, I've been totally spoiled by the gitweb at kernel.org.  It's been
unavailable lately.

Anyway, thanks for the fix.  It looks good to me if it looks good to
Greg---after a google search it appears that your patch is a followup
to his consolidation of the attributes.
 
> Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
> ---
> 
> The log of the caused error can be found at
> http://stosberg.net/tmp/aoe_trace.txt
> 
>  drivers/block/aoe/aoeblk.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
> index d433f27..aa25f8b 100644
> --- a/drivers/block/aoe/aoeblk.c
> +++ b/drivers/block/aoe/aoeblk.c
> @@ -68,6 +68,7 @@ static struct attribute *aoe_attrs[] = {
>  	&disk_attr_mac.attr,
>  	&disk_attr_netif.attr,
>  	&disk_attr_fwver.attr,
> +	NULL
>  };
>  
>  static const struct attribute_group attr_group = {
> -- 
> 1.4.3.3

-- 
  Ed L Cashin <ecashin@coraid.com>
