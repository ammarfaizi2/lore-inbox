Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992726AbWJTTbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992726AbWJTTbk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 15:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992736AbWJTTbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 15:31:40 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:44487
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S2992726AbWJTTbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 15:31:39 -0400
Date: Fri, 20 Oct 2006 12:31:40 -0700 (PDT)
Message-Id: <20061020.123140.48805752.davem@davemloft.net>
To: eiichiro.oiwa.nm@hitachi.com
Cc: greg@kroah.com, alan@redhat.com, jesse.barnes@intel.com,
       linux-kernel@vger.kernel.org, steven.c.cook@intel.com,
       bjorn.helgaas@hp.com, tony.luck@intel.com
Subject: Re: pci_fixup_video change blows up on sparc64
From: David Miller <davem@davemloft.net>
In-Reply-To: <XNM1$9$0$4$$3$3$7$A$9002717U4538db22@hitachi.com>
References: <XNM1$9$0$4$$3$3$7$A$9002710U453840ab@hitachi.com>
	<20061020040324.GA8014@kroah.com>
	<XNM1$9$0$4$$3$3$7$A$9002717U4538db22@hitachi.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: <eiichiro.oiwa.nm@hitachi.com>
Date: Fri, 20 Oct 2006 23:20:21 +0900

> +			/*
> +			 * From information provided by 
> +			 * "David Miller" <davem@davemloft.net>
> +			 * The bridge control register is valid for PCI header
> +			 * type BRIDGE, or CARDBUS. Host to PCI controllers use
> +			 * PCI header type NORMAL.
> +			 */
> +			pci_read_config_byte(bridge, PCI_HEADER_TYPE,
> +						&config_header);

Use the software copy in "bridge->hdr_type", it's already been read
for you by the PCI device probing layer.
