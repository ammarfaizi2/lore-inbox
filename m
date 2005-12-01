Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751675AbVLAKEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbVLAKEV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 05:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbVLAKEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 05:04:21 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:41430 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751418AbVLAKEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 05:04:21 -0500
Date: Thu, 1 Dec 2005 11:00:41 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "Brown, Len" <len.brown@intel.com>
cc: akpm@osdl.org, bunk@stusta.de, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: RE: [patch 5/9] ACPI should depend on, not select PCI
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B300549CF57@hdsmsx401.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.61.0512011058220.1610@scrub.home>
References: <F7DC2337C7631D4386A2DF6E8FB22B300549CF57@hdsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Wed, 30 Nov 2005, Brown, Len wrote:

> No, I can't apply this -- it allows
> Kconfig to create IA64 configs without PCI,
> which do not build.

Why? Simply enable the PCI in IA64 like everyone else, what's the problem?

> > config ACPI
> > 	bool "ACPI Support"
> > 	depends on IA64 || X86
> >+	depends on PCI
> > 	select PM
> >-	select PCI
> > 
> > 	default y

This default should also go.

bye, Roman
