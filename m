Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271388AbTG2Kjl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 06:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271390AbTG2Kjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 06:39:41 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:29372 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S271388AbTG2Kjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 06:39:39 -0400
Date: Tue, 29 Jul 2003 12:39:36 +0200 (MEST)
Message-Id: <200307291039.h6TAda0x026973@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: cowboy@vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: ACPI failure (2.6.0-test<x> and 2.4.22-pre<x>)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003 14:09:40 -0400 (EDT), Richard A Nelson wrote:
>IBM T30 Laptop:
>IBM machine detected. Enabling interrupts during APM calls.
>IBM machine detected. Disabling SMBus accesses.  <- 2.6 only
>No local APIC present or hardware disabled       <- 2.4 only
>Local APIC disabled by BIOS -- reenabling.       <- 2.6 only
>Found and enabled local APIC!                    <- 2.6 only

This is the 2.5.74 patch for P4 kicking in. Without it
you wouldn't have access to the local APIC.

>On either 2.6, or 2.4, booting with ACPI enabled gets as far as
>parsing the ACPI EC table - at which point it oops with bad pointer
>and halts the system.  Sorry at this point I don't have the register
>contents; it took a while to narrow it this far - and have the
>screen in such a state that I can see any relevant information other
>than the the trying to kill init message :)

Since 2.4 also oopses it can't be the local APIC. I'm saying
this because ACPI + local APIC doesn't work with some BIOSen.
