Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWFYUNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWFYUNG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 16:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWFYUNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 16:13:06 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:20070 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932244AbWFYUNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 16:13:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hoof6pok4ZgUPXbbd5Z0MJ46OF/MtSWJIkhyBVi6nJ78EYxbpv9l8ycFFkb+z8zVlymJw0ZY2IDVSmizAYTUHXFJfhzbg93nutZzL0nKnBCP0Xxd7JwvzbJIeqAffRudLZTbkNDV9MhxFAd5ZJwg8lo29G+tr2lcyxX1asUo/Q4=
Message-ID: <a44ae5cd0606251313n5e7654f3t652df65e811325b5@mail.gmail.com>
Date: Sun, 25 Jun 2006 13:13:04 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: 2.6.17-mm2 -- drivers/built-in.o: In function `is_pci_dock_device':acpiphp_glue.c:(.text+0x12364): undefined reference to `is_dock_device'
Cc: "Kristen Accardi" <kristen.c.accardi@intel.com>,
       "Dave Hansen" <haveblue@us.ibm.com>, "Andrew Morton" <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, gregkh@suse.de,
       len.brown@intel.com, linux-acpi@vger.kernel.org
In-Reply-To: <20060625200953.GF23314@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0606251256m74182e7fw4eb2692c89b0e2f8@mail.gmail.com>
	 <20060625200953.GF23314@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Should I attach my entire .config file in the future?  It's large enough that
I try to trim it to avoid bloating people's inboxes.

Yes, that's right.  It is compiled as a module.  So this just needs
a tweaked config rule, right?

Thanks,
         Miles

On 6/25/06, Adrian Bunk <bunk@stusta.de> wrote:
> On Sun, Jun 25, 2006 at 12:56:44PM -0700, Miles Lane wrote:
> > drivers/built-in.o: In function
> > `is_pci_dock_device':acpiphp_glue.c:(.text+0x12364): undefined
> > reference to `is_dock_device'
> > drivers/built-in.o: In function
> > `cleanup_bridge':acpiphp_glue.c:(.text+0x12bc4): undefined reference
> > to `is_dock_device'
> > :acpiphp_glue.c:(.text+0x12bd3): undefined reference to
> > `unregister_hotplug_dock_device'
> > :acpiphp_glue.c:(.text+0x12bdb): undefined reference to
> > `unregister_dock_notifier'
> > drivers/built-in.o: In function
> > `register_slot':acpiphp_glue.c:(.text+0x13ac0): undefined reference to
> > `is_dock_device'
> > :acpiphp_glue.c:(.text+0x13cd9): undefined reference to `is_dock_device'
> > :acpiphp_glue.c:(.text+0x13cf0): undefined reference to
> > `register_hotplug_dock_device'
> > :acpiphp_glue.c:(.text+0x13d1d): undefined reference to
> > `register_dock_notifier'
> > make: *** [.tmp_vmlinux1] Error 1
> >
> > #
> > # PCI Hotplug Support
> > #
> > CONFIG_HOTPLUG_PCI=y
> > CONFIG_HOTPLUG_PCI_FAKE=y
> > CONFIG_HOTPLUG_PCI_COMPAQ=y
> > # CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
> > CONFIG_HOTPLUG_PCI_ACPI=y
> > CONFIG_HOTPLUG_PCI_ACPI_IBM=y
> > CONFIG_HOTPLUG_PCI_CPCI=y
> > # CONFIG_HOTPLUG_PCI_CPCI_ZT5550 is not set
> > CONFIG_HOTPLUG_PCI_CPCI_GENERIC=y
> > CONFIG_HOTPLUG_PCI_SHPC=y
> > # CONFIG_HOTPLUG_PCI_SHPC_POLL_EVENT_MODE is not set
>
>
> You hadn't attached your complete .config, but is it correct when I
> assume you have CONFIG_ACPI_DOCK=m? This would explain the problem.
>
>
> cu
> Adrian
>
> --
>
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
>
>
