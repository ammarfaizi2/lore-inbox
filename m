Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWH0EGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWH0EGW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 00:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWH0EGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 00:06:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:5549 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750731AbWH0EGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 00:06:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WNq+fWERvtEfKEhQ/uxN4Ku4XxY+8/CSCCUIZ1aBbbaIiggaVK/ccTfsOq8g4wB9uL2a7lqiFwwx1l0WL6UTal0x8GpPzmvkYYECs8HxLOcyNy9qMh38geFcrwmcwyEC6BIKtHbRZsA4R+fGGo3RD6EtB4KZ1OubBPNNeXRbz1Q=
Message-ID: <6b4e42d10608262106ibc44172h3eb3e6f68ba8a062@mail.gmail.com>
Date: Sat, 26 Aug 2006 21:06:20 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: "Len Brown" <lenb@kernel.org>
Subject: Re: memory leak fix in acpi_memhotplug.c, kmalloc to kzalloc conversion.
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
In-Reply-To: <200608262143.37390.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6b4e42d10608261721h7807e45h6f20a2327f368719@mail.gmail.com>
	 <200608262143.37390.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/06, Len Brown <len.brown@intel.com> wrote:
> On Saturday 26 August 2006 20:21, Om Narasimhan wrote:
> > Hi,
> > This patch fixes one memory leak in drivers/acpi/acpi_memhotplug.c
> > Replaces all kmalloc() calls succeeded by memset() to kzalloc() calls.
> > Applies cleanly to 2.6.18-rc4. Compile tested.
>
> Compile testing is more effective is you use a .config that
> builds each of the source files changed.
I have compiled it with .config files resulting from targets
'allmodconfig' and 'allyesconfig'.
> > diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> > index b0d4b14..eb8a5da 100644
> > --- a/drivers/acpi/acpi_memhotplug.c
> > +++ b/drivers/acpi/acpi_memhotplug.c
> > @@ -297,6 +297,7 @@ static int acpi_memory_disable_device(st
> >        * Ask the VM to offline this memory range.
> >        * Note: Assume that this function returns zero on success
> >        */
> > +     struct acpi_memory_info *info, *n;
>
> What tree is this patch against?
> This line is already present (above the comment) in 2.6.18-rc4.
This surprises me. This patch is against 2.6.18-rc4, git-pull -ed today morning.
Maybe I should do one more git-pull?

Thanks,
Om N
