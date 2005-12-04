Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbVLDQJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbVLDQJU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 11:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVLDQJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 11:09:20 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52752 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932262AbVLDQJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 11:09:19 -0500
Date: Sun, 4 Dec 2005 17:09:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Brown, Len" <len.brown@intel.com>
Cc: akpm@osdl.org, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 5/9] ACPI should depend on, not select PCI
Message-ID: <20051204160920.GS31395@stusta.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B300549CF57@hdsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B300549CF57@hdsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2005 at 08:58:22PM -0500, Brown, Len wrote:

> No, I can't apply this -- it allows
> Kconfig to create IA64 configs without PCI,
> which do not build.
> 
> there must be a better way.

According to arch/ia64/Kconfig, PCI support is optional on ia64.

Either arch/ia64/Kconfig should be fixed or the PCI=n builds must be 
fixed on ia64.

Looking closer, is the problem you are talking about caused by the fact 
that IA64_GENERIC select's options without ensuring that the 
dependencies of what it is select'ing are fulfilled?

> -Len 

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

