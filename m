Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWIOLWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWIOLWz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 07:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWIOLWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 07:22:55 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54431 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751260AbWIOLWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 07:22:54 -0400
Subject: Re: Same MCE on 4 working machines (was Re: Early boot hang on
	recent 2.6 kernels (> 2.6.3), on x86-64 with 16gb of RAM)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robin Lee Powell <rlpowell@digitalkingdom.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060914190548.GI4610@chain.digitalkingdom.org>
References: <20060912223258.GM4612@chain.digitalkingdom.org>
	 <20060914190548.GI4610@chain.digitalkingdom.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 12:45:42 +0100
Message-Id: <1158320742.29932.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-09-14 am 12:05 -0700, ysgrifennodd Robin Lee Powell:
> NET: Registered protocol family 16
> CPU 0: Machine Check Exception:                7 Bank 3: b40000000000083b
> RIP 10:<ffffffff8023a44c> {pci_conf1_read+0xac/0xe0}
> TSC d189cea ADDR fdfc000cfe

We went to do a PCI configuration cycle and your box blew up. Thats
pretty clear. Could be down to the various changes in how we do PCI
accesses tripping up a problem box, or triggering a bug.

See what effect 

	pci=bios
	pci=conf1
	pci=conf2

	pci=nommconf
	pci=nomsi

have and report back.

What drivers do you have enabled and what pci devices are present ?

Alan

