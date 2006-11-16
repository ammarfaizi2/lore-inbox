Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162277AbWKPE3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162277AbWKPE3w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 23:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162278AbWKPE3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 23:29:52 -0500
Received: from rrcs-24-153-218-104.sw.biz.rr.com ([24.153.218.104]:54205 "EHLO
	smtp.opengridcomputing.com") by vger.kernel.org with ESMTP
	id S1162277AbWKPE3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 23:29:50 -0500
Subject: Re: [PATCH] cxgb3: Chelsio T3 1G/10G ethernet device driver
From: Steve WIse <swise@opengridcomputing.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: divy <divy@chelsio.com>, Jeff Garzik <jeff@garzik.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061115163324.16263201@freekitty>
References: <455BACB8.4010902@chelsio.com>
	 <20061115163324.16263201@freekitty>
Content-Type: text/plain
Date: Wed, 15 Nov 2006 22:29:48 -0600
Message-Id: <1163651388.4963.12.camel@linux-q667.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-15 at 16:33 -0800, Stephen Hemminger wrote:
> On Wed, 15 Nov 2006 16:11:36 -0800
> divy <divy@chelsio.com> wrote:
> 
> > Hi,
> > 
> > This patch adds support for the latest Chelsio adapter, T3.
> > 
> > Since some files are bigger than the 40kB advertized in the submit
> > guidelines, a monolithic patch against 2.6.19-rc5 is posted at the
> > following URL: http://service.chelsio.com/kernel.org/cxgb3.patch.bz2
> > 
> > Please advise on any other form you would like to see the code.
> > 
> > We wish this patch to be considered for inclusion in 2.6.20. This driver
> > will be required by the Chelsio T3 RDMA driver which will be posted for
> > review asap.
> > 
> > Cheers,
> > Divy
> > -
> > To unsubscribe from this list: send the line "unsubscribe netdev" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> This took me an afternoon, so I don't see why Chelsio didn't do it.
> 
>     Port of Chelsio's 2.2.0 version driver from:
>         http://service.chelsio.com/drivers/linux/t210/cxgb2toe-2.2.0.tar.gz
>     
>     De-vendorized:
>         - removed all TCP Offload Engine support because those changes
>           will not be accepted in mainline kernel.
>         - new files run through Lindent
>         - removed code that was '#ifdef' for older kernel versions
>         - fix for 2.6.19 irq
>         - replace usage of TSC with ktime
>         - remove /proc trace debug stuff
>         - remove dead code
>         - incorporate GSO, etc.
>         - get rid of FILE_IDENT() macro
>         - fix sparse warnings by adding __iomem and __user
> 
> Also, I kept as many of the filenames and device names the same since
> it is really just an extension of existing driver.
> 
> I'm testing it now.
> 

Stephen,

Divy posted a new driver to support the new Chelsio T3 hardware, not the
210 hardware.

Steve.



