Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWAFNpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWAFNpt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 08:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWAFNpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 08:45:49 -0500
Received: from [81.2.110.250] ([81.2.110.250]:41426 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932420AbWAFNps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 08:45:48 -0500
Subject: Re: Problem with pci_fixups in drivers/pci/probe.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: alan <alan@clueserver.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0601051533430.27220-100000@www.fnordora.org>
References: <Pine.LNX.4.44.0601051533430.27220-100000@www.fnordora.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Jan 2006 13:48:07 +0000
Message-Id: <1136555288.30498.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-01-05 at 15:46 -0800, alan wrote:
> include/asm-x86_64/pci.h:18:#define pcibios_assign_all_busses() 0
> include/asm-i386/pci.h:14:extern unsigned int pcibios_assign_all_busses(void);
> include/asm-i386/pci.h:16:#define pcibios_assign_all_busses()   0
> include/asm-ia64/pci.h:18:#define pcibios_assign_all_busses()     0
> 
> This "fix" makes the patch absolutely useless to me.

Your system work sif this is set to 1 ?

If so you might want to use the DMI layer to make that function return 0
except for matches on problem systems.

Alan

