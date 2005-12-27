Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbVL0H4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbVL0H4F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 02:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbVL0H4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 02:56:05 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58537 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932259AbVL0H4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 02:56:02 -0500
Subject: Re: [PATCH 1/2]MSI(X) save/restore for suspend/resume
From: Arjan van de Ven <arjan@infradead.org>
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1135649077.17476.14.camel@sli10-desk.sh.intel.com>
References: <1135649077.17476.14.camel@sli10-desk.sh.intel.com>
Content-Type: text/plain
Date: Tue, 27 Dec 2005 08:55:57 +0100
Message-Id: <1135670158.2926.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> diff -puN include/linux/pci.h~msi_save_restore include/linux/pci.h
> --- linux-2.6.15-rc5/include/linux/pci.h~msi_save_restore	2005-12-22 09:23:16.000000000 +0800
> +++ linux-2.6.15-rc5-root/include/linux/pci.h	2005-12-22 09:23:16.000000000 +0800
> @@ -135,6 +135,7 @@ struct pci_dev {
>  	unsigned int	block_ucfg_access:1;	/* userspace config space access is blocked */
>  
>  	u32		saved_config_space[16]; /* config space saved at suspend time */
> +	void		*saved_cap_space[PCI_CAP_ID_MAX + 1]; /* ext config space saved at suspend time */
>  	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
>  	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */


void feels like sort of the wrong thing here....


