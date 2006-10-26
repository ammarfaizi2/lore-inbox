Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161391AbWJZNv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161391AbWJZNv7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 09:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161396AbWJZNv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 09:51:58 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:49009 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1161393AbWJZNv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 09:51:57 -0400
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 2.6.19-rc3 2/2] ehea: 64K page support fix
Date: Thu, 26 Oct 2006 15:00:20 +0200
User-Agent: KMail/1.8.2
Cc: Jeff Garzik <jeff@garzik.org>, Thomas Klein <tklein@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>,
       Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
References: <200610251312.01235.ossthema@de.ibm.com> <20061025162126.GB25324@krispykreme>
In-Reply-To: <20061025162126.GB25324@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610261500.20898.ossthema@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

that is right, I'll send a new patch

Thanks,
Jan-Bernd

On Wednesday 25 October 2006 18:21, Anton Blanchard wrote:
> 
> Hi,
> 
> > +#ifdef CONFIG_PPC_64K_PAGES
> > +	/* To support 64k pages we must round to 64k page boundary */
> > +	epas->kernel.addr =
> > +		ioremap((paddr_kernel & 0xFFFFFFFFFFFF0000), PAGE_SIZE) +
> > +		(paddr_kernel & 0xFFFF);
> > +#else
> >  	epas->kernel.addr = ioremap(paddr_kernel, PAGE_SIZE);
> > +#endif
> 
> Cant you just use PAGE_MASK, ~PAGE_MASK and remove the ifdefs
> completely?
> 
> Anton
> 
