Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312543AbSCaNqn>; Sun, 31 Mar 2002 08:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312544AbSCaNqd>; Sun, 31 Mar 2002 08:46:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36616 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312543AbSCaNqV>; Sun, 31 Mar 2002 08:46:21 -0500
Subject: Re: Linux 2.4.19-pre5: hotplug config
To: eyal@eyal.emu.id.au (Eyal Lebedinsky)
Date: Sun, 31 Mar 2002 15:02:45 +0100 (BST)
Cc: marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <3CA65AAE.4917313E@eyal.emu.id.au> from "Eyal Lebedinsky" at Mar 31, 2002 10:39:10 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16rfuv-0006gt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -dep_tristate '  IBM PCI Hotplug driver' CONFIG_HOTPLUG_PCI_IBM $CONFIG_HOTPLUG_PCI $CONFIG_X86_IO_APIC $CONFIG_X86
> +if [ "$CONFIG_X86_IO_APIC" = "y" ]; then
> +   dep_tristate '  IBM PCI Hotplug driver' CONFIG_HOTPLUG_PCI_IBM $CONFIG_HOTPLUG_PCI $CONFIG_X86
> +fi

What if I want hot plug and no apic??

See the fix in the 2.4.19-ac tree, that one ought to have been sufficient
