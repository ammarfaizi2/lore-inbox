Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbUKKPtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbUKKPtv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 10:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbUKKPtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 10:49:11 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:31498 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262272AbUKKPr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 10:47:27 -0500
Date: Thu, 11 Nov 2004 16:46:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Len Brown <len.brown@intel.com>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [ACPI] [2.6 patch] drivers/acpi: #ifdef unused functions away
Message-ID: <20041111154656.GE8417@stusta.de>
References: <1099707007.13834.1969.camel@d845pe> <20041106114844.GK1295@stusta.de> <418CEE3A.40503@conectiva.com.br> <20041106212917.GP1295@stusta.de> <418D403E.30608@conectiva.com.br> <1099933263.13831.9547.camel@d845pe> <20041110012134.GB4089@stusta.de> <20041111151727.GB1108@parcelfarce.linux.theplanet.co.uk> <20041111153650.GD8417@stusta.de> <20041111154017.GC1108@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111154017.GC1108@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 03:40:17PM +0000, Matthew Wilcox wrote:
> On Thu, Nov 11, 2004 at 04:36:50PM +0100, Adrian Bunk wrote:
> > On Thu, Nov 11, 2004 at 03:17:27PM +0000, Matthew Wilcox wrote:
> > > On Wed, Nov 10, 2004 at 02:21:34AM +0100, Adrian Bunk wrote:
> > > > This patch only #ifdef's completely unused code away - it does not make 
> > > > the many global functions only used inside the file they are defined in 
> > > > static.
> > > 
> > > It also ifdefs out the acpi_install_gpe_handler and acpi_remove_gpe_handler
> > > calls I use in the driver I posted on Sunday.  Please fix this.
> > 
> > ????
> > 
> > My patch doesn't #ifdef these functions away.
> 
> Sorry, acpi_remove_gpe_block, not acpi_remove_gpe_handler:
> 
> @@ -383,6 +398,7 @@
>  acpi_status
>  acpi_remove_gpe_block (
>         acpi_handle                     gpe_device);
> +#endif  /*  ACPI_FUTURE_USAGE  */

I didn't saw your patch on linux-kernel, and although Len has said that 
he'd apply my patches I have yet to hear an answer indicating either 
problems in my patches or that he'd applied them.

Did Len already integrate your driver into his tree?

If yes, I will correct the acpi_remove_gpe_block case (it's only this 
one function?) as soon as his tree appears in the next -mm.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

