Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262906AbSKANzQ>; Fri, 1 Nov 2002 08:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264958AbSKANzQ>; Fri, 1 Nov 2002 08:55:16 -0500
Received: from skunk.physik.uni-erlangen.de ([131.188.163.240]:34191 "EHLO
	skunk.physik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S262906AbSKANzQ>; Fri, 1 Nov 2002 08:55:16 -0500
From: Christian Vogel <vogel@skunk.physik.uni-erlangen.de>
Date: Fri, 1 Nov 2002 15:01:29 +0100
To: Alan Cox <alan@redhat.com>
Cc: Linux Kernel Mailing-List <linux-kernel@vger.kernel.org>
Subject: 2.4.20-pre10-ac2: proc_bus_pci_dir unresolved in pci_hotplug.o module
Message-ID: <20021101150129.A15230@skunk.physik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when insmodding the pci_hotplug.o module I get unresolved symbol
proc_bus_pci_dir on Kernel 2.4.20-pre10-ac2.

The symbol is declared extern here:

drivers/hotplug/pci_hutplug_core.c (line 131) has:
        extern struct proc_dir_entry *proc_bus_pci_dir

The symbol is defined here:

drivers/pci/proc.c (line 372) has:
        struct proc_dir_entry *proc_bus_pci_dir

Probably some EXPORT_SYMBOL(proc_bus_pci_dir) is missing
in the latter file?...

        Chris

-- 
L'urgent est fait, L'impossible est en cours,
Pour les miracles, ... prévoir un délai.
