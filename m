Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbUL0OtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbUL0OtS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 09:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbUL0OtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 09:49:18 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:31131 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261746AbUL0OtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 09:49:16 -0500
Subject: RE: the patch of restore-pci-config-space-on-resume break S1 on
	ASUS2400 NE
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       "Brown, Len" <len.brown@intel.com>,
       "Li, Shaohua" <shaohua.li@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net, "Fu, Michael" <michael.fu@intel.com>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8406A26924@pdsmsx403>
References: <3ACA40606221794F80A5670F0AF15F8406A26924@pdsmsx403>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104155089.20693.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 27 Dec 2004 13:44:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-27 at 10:14, Yu, Luming wrote:
>  Actually, the kernel (after removing restore-pci-config-space-on-resume patch) with option "ide=nodma" 
> can work with S1 suspend/resume without any hang so far.
>   So my suggestion for IDE driver is to disable DMA before entering S1, and enable
> DMA after resuming from S1 if DMA was enabled.  I need help from IDE guys to confirm it.

The IDE layer has no problem doing this, although it raises interesting
questions about why it would be neccessary. 

