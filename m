Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbUKFV10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbUKFV10 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 16:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbUKFV10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 16:27:26 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56337 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261476AbUKFV1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 16:27:21 -0500
Date: Sat, 6 Nov 2004 22:26:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Matthew Wilcox <matthew@wil.cx>
Cc: len.brown@intel.com, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ACPI] [2.6 patch] drivers/acpi: remove unused exported functions
Message-ID: <20041106212646.GO1295@stusta.de>
References: <20041105215021.GF1295@stusta.de> <20041106203934.GA27251@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041106203934.GA27251@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 08:39:34PM +0000, Matthew Wilcox wrote:
> On Fri, Nov 05, 2004 at 10:50:21PM +0100, Adrian Bunk wrote:
> > -acpi_status
> > -acpi_install_gpe_block (
> > -	acpi_handle                     gpe_device,
> > -	struct acpi_generic_address     *gpe_block_address,
> > -	u32                             register_count,
> > -	u32                             interrupt_level);
> > -
> > -acpi_status
> > -acpi_remove_gpe_block (
> > -	acpi_handle                     gpe_device);
> > -
> 
> I just wrote a driver that uses these two.  Probably best if you refer to
> http://developer.intel.com/technology/iapc/acpi/downloads/ACPICA-ProgRef.pdf
> before deleting "unused" functions as these are part of the published
> interfaces that the ACPICA provides.

If an in-kernel usage for some of the functions is coming soon simply 
ignore these parts of my patch.

But if there's EXPORT_SYMBOL'ed code since nearly since nearly three 
years in the kernel that has like drivers/acpi/hardware/hwtimer.c 
exactly zero users, the only effect of this code is a code bloat for all 
users of ACPI.

Prehaps #ifdef 0's are the best solution for published but unused 
interfaces?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

