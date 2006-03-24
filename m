Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbWCXJj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbWCXJj7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 04:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbWCXJj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 04:39:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20151 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965025AbWCXJj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 04:39:58 -0500
Date: Fri, 24 Mar 2006 01:36:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: greg@kroah.com, kaneshige.kenji@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 2.6.16-mm1 1/4] PCI legacy I/O port free driver (take 6)
 - Changes to generic PCI code
Message-Id: <20060324013626.4e15082d.akpm@osdl.org>
In-Reply-To: <44238424.3080500@jp.fujitsu.com>
References: <442382F1.2050300@jp.fujitsu.com>
	<44238424.3080500@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> wrote:
>
> +/*
>  + * This helper routine makes bar mask from the type of resource.
>  + */
>  +static inline int pci_select_bars(struct pci_dev *dev, unsigned long flags)
>  +{
>  +	int i, bars = 0;
>  +	for (i = 0; i < PCI_NUM_RESOURCES; i++)
>  +		if (pci_resource_flags(dev, i) & flags)
>  +			bars |= (1 << i);
>  +	return bars;
>  +}

Can we please uninline this?
