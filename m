Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWHWNFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWHWNFH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 09:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWHWNFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 09:05:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:20771 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932450AbWHWNFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 09:05:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=mGHromnpUKluK2AfXUEihNaXkt61Z0jtm38JRmjoRtLd9uyvzBpU8ibybwm3K0S1C02R0xbxG/FzWOY+pgkJAuCqb+t1wx+ZbEe0w1oOSf2P1dmc4ViTjUVyMwD4DmV3R8JV03Pe4HwR7oj9obQQiFhcNSEq6CxITuIhiKY9MZs=
Date: Wed, 23 Aug 2006 17:04:52 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: [PATCH 1/6] BC: kconfig
Message-ID: <20060823130452.GA10449@martell.zuzino.mipt.ru>
References: <44EC31FB.2050002@sw.ru> <44EC35A3.7070308@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EC35A3.7070308@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 03:01:55PM +0400, Kirill Korotaev wrote:
> --- ./kernel/bc/Kconfig.bckm
> +++ ./kernel/bc/Kconfig
> @@ -0,0 +1,25 @@
> +#
> +# Resource beancounters (BC)
> +#
> +# Copyright (C) 2006 OpenVZ. SWsoft Inc
> +
> +menu "User resources"
> +
> +config BEANCOUNTERS
> +	bool "Enable resource accounting/control"
> +	default n
> +	help 
> +          This patch provides accounting and allows to configure
> +          limits for user's consumption of exhaustible system resources.

If BC will be merged there will be no patch, so text should be
rewritten slightly.

> +          The most important resource controlled by this patch is 
> unswappable +          memory (either mlock'ed or used by internal kernel 
> structures and +          buffers). The main goal of this patch is to 
> protect processes
> +          from running short of important resources because of an 
> accidental
> +          misbehavior of processes or malicious activity aiming to 
> ``kill'' +          the system. It's worth to mention that resource limits 
> configured +          by setrlimit(2) do not give an acceptable level of 
> protection +          because they cover only small fraction of resources 
> and work on a +          per-process basis.  Per-process accounting doesn't 
> prevent malicious
> +          users from spawning a lot of resource-consuming processes.

