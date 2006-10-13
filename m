Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751818AbWJMTRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbWJMTRs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 15:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbWJMTRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 15:17:47 -0400
Received: from ironport-c10.fh-zwickau.de ([141.32.72.200]:26933 "EHLO
	ironport-c10.fh-zwickau.de") by vger.kernel.org with ESMTP
	id S1751730AbWJMTRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 15:17:46 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AY8CAFGCL0U
X-IronPort-AV: i="4.09,308,1157320800"; 
   d="scan'208"; a="4269128:sNHT31328736"
Date: Fri, 13 Oct 2006 21:17:45 +0200
From: Joerg Roedel <joro-lkml@zlug.org>
To: Jan Dittmer <jdi@l4x.org>
Cc: netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/02 V3] net/ipv6: seperate sit driver to extra module
Message-ID: <20061013191744.GA30089@zlug.org>
References: <20061010153745.GA27455@zlug.org> <452FD6F6.3090907@l4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452FD6F6.3090907@l4x.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 08:12:06PM +0200, Jan Dittmer wrote:
> This is missing the MODULE_LICENSE statements and taints the kernel upon
> loading. License is obvious from the beginning of the file.

Ah, ok. I forgot that. Thanks for the fix.

> Joerg Roedel wrote:
> > --- linux-2.6.18-vanilla/net/ipv6/sit.c	2006-09-20 05:42:06.000000000 +0200
> > +++ linux-2.6.18/net/ipv6/sit.c	2006-10-05 16:55:02.000000000 +0200
> > @@ -850,3 +850,6 @@ int __init sit_init(void)
> >  	inet_del_protocol(&sit_protocol, IPPROTO_IPV6);
> >  	goto out;
> >  }
> > +
> > +module_init(sit_init);
> > +module_exit(sit_cleanup);
> 
> Signed-off-by: Jan Dittmer <jdi@l4x.org>
Signed-off-by: Joerg Roedel <joro-lkml@zlug.org>

> 
> --- linux-2.6-amd64/net/ipv6/sit.c~	2006-10-13 17:39:45.000000000 +0200
> +++ linux-2.6-amd64/net/ipv6/sit.c	2006-10-13 17:39:49.000000000 +0200
> @@ -853,3 +853,4 @@ int __init sit_init(void)
> 
>  module_init(sit_init);
>  module_exit(sit_cleanup);
> +MODULE_LICENSE("GPL");
