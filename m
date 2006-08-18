Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030415AbWHROQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbWHROQM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 10:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWHROQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 10:16:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:15020 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751396AbWHROQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 10:16:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=c+o9VdB/BY/zXRO4MwrEJFIniPI8Y5IffnJQn1cFPBiY4j/wn7pwsAuQb0ccCnAM2t3zlxoPaa2qRyPaYsnAMh1jgSUe4xf0EMmXU57ZSovlnSgbZ6Z7spBYzStIuxaQzFz7OsE3zzFxNT/g3VpoBNJq3dwNdBROq17Wcc08Hwg=
Date: Fri, 18 Aug 2006 18:16:00 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Cc: netdev@vger.kernel.org, Christoph Raisch <raisch@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <osstklei@de.ibm.com>, Thomas Klein <tklein@de.ibm.com>
Subject: Re: [2.6.19 PATCH 5/7] ehea: main header files
Message-ID: <20060818141600.GD5201@martell.zuzino.mipt.ru>
References: <200608181334.57701.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608181334.57701.ossthema@de.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2006 at 01:34:57PM +0200, Jan-Bernd Themann wrote:
> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea.h
> +++ kernel/drivers/net/ehea/ehea.h

> +#include <linux/version.h>

Not needed.

> +#include <linux/module.h>
> +#include <linux/moduleparam.h>

Really?

> +#include <linux/kernel.h>
> +#include <linux/vmalloc.h>
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +#include <linux/sched.h>
> +#include <linux/err.h>
> +#include <linux/list.h>
> +#include <linux/netdevice.h>
> +#include <linux/etherdevice.h>
> +#include <linux/kthread.h>

Nothing is used here. grep kthread

> +#include <linux/ethtool.h>
> +#include <linux/if_vlan.h>

It this because of "struct vlan_group" just add "struct vlan_group;" at
the beginning of the headers.

> +#include <asm/ibmebus.h>
> +#include <asm/of_device.h>
> +#include <asm/abs_addr.h>
> +#include <asm/semaphore.h>
> +#include <asm/current.h>
> +#include <asm/io.h>

Please, use only headers you only really need. Full rebuilds are already pretty
enough. I've included half of include/linux disaster must stop.

