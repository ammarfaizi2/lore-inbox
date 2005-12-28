Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbVL1IfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbVL1IfY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 03:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbVL1IfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 03:35:24 -0500
Received: from fmr17.intel.com ([134.134.136.16]:24281 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932507AbVL1IfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 03:35:23 -0500
Subject: Re: [PATCH 1/2]MSI(X) save/restore for suspend/resume
From: Shaohua Li <shaohua.li@intel.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1135758335.2935.0.camel@laptopd505.fenrus.org>
References: <1135649077.17476.14.camel@sli10-desk.sh.intel.com>
	 <1135670158.2926.15.camel@laptopd505.fenrus.org>
	 <1135733064.331.0.camel@sli10-desk.sh.intel.com>
	 <1135758335.2935.0.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Message-Id: <1135758486.13792.8.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 28 Dec 2005 16:28:06 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-28 at 16:25, Arjan van de Ven wrote:
> On Wed, 2005-12-28 at 09:24 +0800, Shaohua Li wrote:
> > On Tue, 2005-12-27 at 15:55, Arjan van de Ven wrote:
> > > > diff -puN include/linux/pci.h~msi_save_restore include/linux/pci.h
> > > > --- linux-2.6.15-rc5/include/linux/pci.h~msi_save_restore	2005-12-22 09:23:16.000000000 +0800
> > > > +++ linux-2.6.15-rc5-root/include/linux/pci.h	2005-12-22 09:23:16.000000000 +0800
> > > > @@ -135,6 +135,7 @@ struct pci_dev {
> > > >  	unsigned int	block_ucfg_access:1;	/* userspace config space access is blocked */
> > > >  
> > > >  	u32		saved_config_space[16]; /* config space saved at suspend time */
> > > > +	void		*saved_cap_space[PCI_CAP_ID_MAX + 1]; /* ext config space saved at suspend time */
> > > >  	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
> > > >  	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
> > > 
> > > 
> > > void feels like sort of the wrong thing here....
> > So what is good to you :)?
> 
> doesn't it contain u16's ?
It might contain u16 or u32 or anything else. And depends on the
specific capability.

Thanks,
Shaohua

