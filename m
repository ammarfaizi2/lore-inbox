Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265482AbUGGU4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265482AbUGGU4i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 16:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265489AbUGGUzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 16:55:36 -0400
Received: from aun.it.uu.se ([130.238.12.36]:63154 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265474AbUGGUxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 16:53:19 -0400
Date: Wed, 7 Jul 2004 22:52:32 +0200 (MEST)
Message-Id: <200407072052.i67KqWTS019776@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, weisz@vcpc.univie.ac.at
Subject: Re: APIC error on CPU0:60(60)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Weisz writes:
 > >From time to time we get the error message:
 > 
 >      APIC error on CPU0:60(60)
 > 
 > from the kernel.
 > 
 > We are running Linux kernel version 2.6.6 patches with
 > Mike Peterson's perfctr.
 > 
 > What does this message tell?

40 is Received Illegal Vector
20 is Send Illegal Vector

60 means you're getting both errors at the same time.

Basically it means that the APIC bus messages are malformed.
The cause can be hardware or software, it's difficult to tell.

Try a different kernel, w/o ACPI (acpi=off), w/o ACPI PCI
routing (pci=noacpi), or w/o I/O-APIC (noapic).

/Mikael
