Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbULPSrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbULPSrY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 13:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbULPSrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 13:47:24 -0500
Received: from palrel10.hp.com ([156.153.255.245]:8158 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261981AbULPSqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 13:46:13 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16833.55270.601527.754270@napali.hpl.hp.com>
Date: Thu, 16 Dec 2004 10:45:58 -0800
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, willy@debian.org
Subject: Re: [PATCH] add legacy I/O port & memory APIs to /proc/bus/pci
In-Reply-To: <200412160850.20223.jbarnes@engr.sgi.com>
References: <200412160850.20223.jbarnes@engr.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 16 Dec 2004 08:50:19 -0800, Jesse Barnes <jbarnes@engr.sgi.com> said:

  Jesse> +int ia64_pci_legacy_read(struct pci_dev *dev, u16 port, u32 *val, u8 size)
  Jesse> +{
  Jesse> +	int ret = 0;
  Jesse>         :
  Jesse> +	case 1:
  Jesse> +		addr = (unsigned long *)paddr;
  Jesse> +		*val = (u8)(*(volatile u8 *)(addr));
  Jesse> +		break;
  Jesse> +	case 2:
  Jesse> +		addr = (unsigned long *)paddr;
  Jesse> +		*val = (u16)(*(volatile u16 *)(addr));
  Jesse> +		break;
  Jesse>          :
  Jesse> +}

  Jesse> +int ia64_pci_legacy_write(struct pci_dev *dev, u16 port, u32 val, u8 size)
  Jesse> +{
  Jesse> +	switch (size) {
  Jesse> +	case 1:
  Jesse> +		addr = (unsigned long *)paddr;
  Jesse> +		*(volatile u8 *)(addr) = (u8)(val);
  Jesse> +		break;
  Jesse> +	case 2:
  Jesse> +		addr = (unsigned long *)paddr;
  Jesse> +		*(volatile u16 *)(addr) = (u16)(val);
  Jesse> +		break;
  Jesse>           :
  Jesse> +	}

No offense, but what's up with this castamania?

	--david
