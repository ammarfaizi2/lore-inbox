Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbVJGRw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbVJGRw6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 13:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbVJGRw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 13:52:58 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:55723 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1030329AbVJGRw5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 13:52:57 -0400
Date: Fri, 7 Oct 2005 11:52:53 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net, rajesh.shah@intel.com, greg@kroah.com,
       len.brown@intel.com
Subject: Re: [Pcihpd-discuss] [patch 2/2] acpi: add ability to derive irq when doing a surprise removal of an adapter
Message-ID: <20051007175253.GC22697@parisc-linux.org>
References: <1128707174.11020.12.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128707174.11020.12.camel@whizzy>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2005 at 10:46:14AM -0700, Kristen Accardi wrote:
> +void acpi_pci_irq_disable_nodev(struct pci_dev *dev)
> +{
[...]
> +
> +			acpi_unregister_gsi(gsi);
> +			return_VOID;
> +		}
> +	}
> +	return_VOID;

I really don't think you want 'return_VOID' here, unless you want to add
the ACPI_FUNCTION_TRACE() to the beginning of the function.
