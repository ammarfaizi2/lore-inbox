Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292238AbSCIBKP>; Fri, 8 Mar 2002 20:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292284AbSCIBKF>; Fri, 8 Mar 2002 20:10:05 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22276 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292238AbSCIBKB>; Fri, 8 Mar 2002 20:10:01 -0500
Subject: Re: PnP BIOS driver status
To: bgerst@didntduck.org (Brian Gerst)
Date: Sat, 9 Mar 2002 01:25:10 +0000 (GMT)
Cc: jdthood@mail.com (Thomas Hood), linux-kernel@vger.kernel.org
In-Reply-To: <3C895E90.696E92A2@didntduck.org> from "Brian Gerst" at Mar 08, 2002 08:00:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16jVbi-0008Gb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The current driver is not SMP-safe.  It is modifying the GDT descriptors
> outside of the pnp_bios_lock.  Also, you can remove the __cli(), as
> spin_lock_irq() already turns off interrupts.

The GDT descriptors are private to the PNP BIOS and constant values once
set up. No PnPBIOS call is made before the configuration is done.

Seems ok to me - or am I missing something ?
