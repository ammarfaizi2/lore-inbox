Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbVL1Bbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbVL1Bbi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 20:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbVL1Bbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 20:31:38 -0500
Received: from fmr18.intel.com ([134.134.136.17]:13538 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932347AbVL1Bbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 20:31:37 -0500
Subject: Re: [PATCH 1/2]MSI(X) save/restore for suspend/resume
From: Shaohua Li <shaohua.li@intel.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1135670158.2926.15.camel@laptopd505.fenrus.org>
References: <1135649077.17476.14.camel@sli10-desk.sh.intel.com>
	 <1135670158.2926.15.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Message-Id: <1135733064.331.0.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 28 Dec 2005 09:24:24 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-27 at 15:55, Arjan van de Ven wrote:
> > diff -puN include/linux/pci.h~msi_save_restore include/linux/pci.h
> > --- linux-2.6.15-rc5/include/linux/pci.h~msi_save_restore	2005-12-22 09:23:16.000000000 +0800
> > +++ linux-2.6.15-rc5-root/include/linux/pci.h	2005-12-22 09:23:16.000000000 +0800
> > @@ -135,6 +135,7 @@ struct pci_dev {
> >  	unsigned int	block_ucfg_access:1;	/* userspace config space access is blocked */
> >  
> >  	u32		saved_config_space[16]; /* config space saved at suspend time */
> > +	void		*saved_cap_space[PCI_CAP_ID_MAX + 1]; /* ext config space saved at suspend time */
> >  	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
> >  	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
> 
> 
> void feels like sort of the wrong thing here....
So what is good to you :)?

Thanks,
Shaohua

