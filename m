Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932951AbWF0E2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932951AbWF0E2f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933312AbWF0E2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:28:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:23700 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932951AbWF0E2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:28:34 -0400
From: Andi Kleen <ak@suse.de>
To: rajesh.shah@intel.com
Subject: Re: [patch 2/2] x86_64 PCI: improve extended config space verification
Date: Tue, 27 Jun 2006 06:28:53 +0200
User-Agent: KMail/1.9.1
Cc: gregkh@suse.de, len.brown@intel.com, akpm@osdl.org, arjan@linux.intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
References: <20060627004556.809330000@rshah1-sfield.jf.intel.com> <20060627004920.477788000@rshah1-sfield.jf.intel.com>
In-Reply-To: <20060627004920.477788000@rshah1-sfield.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606270628.54218.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Index: linux-2.6.17-mm2/arch/x86_64/pci/mmconfig.c
> ===================================================================
> --- linux-2.6.17-mm2.orig/arch/x86_64/pci/mmconfig.c
> +++ linux-2.6.17-mm2/arch/x86_64/pci/mmconfig.c
> @@ -16,6 +16,7 @@
>  /* aperture is up to 256MB but BIOS may reserve less */
>  #define MMCONFIG_APER_MIN	(2 * 1024*1024)
>  #define MMCONFIG_APER_MAX	(256 * 1024*1024)
> +extern int is_acpi_reserved(unsigned long start, unsigned long end);

The prototype belongs into some shared header.

-Andi

