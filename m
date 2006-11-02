Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751859AbWKBQOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbWKBQOA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 11:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751957AbWKBQOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 11:14:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36276 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751859AbWKBQN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 11:13:59 -0500
Subject: Re: [airo.c bug] Couldn't allocate RX FID / Max tries exceeded
	when issueing command
From: Dan Williams <dcbw@redhat.com>
To: Ivan Matveich <ivan.matveich@gmail.com>
Cc: linux-kernel@vger.kernel.org, linville@tuxdriver.com,
       netdev@vger.kernel.org, breed@users.sourceforge.net,
       achirica@users.sourceforge.net, jt@hpl.hp.com, fabrice@bellet.info
In-Reply-To: <b5def3a40611011914v59ecd4c3xb6965591524aa11@mail.gmail.com>
References: <b5def3a40611011914v59ecd4c3xb6965591524aa11@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 11:12:51 -0500
Message-Id: <1162483971.2646.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 22:14 -0500, Ivan Matveich wrote:
> hardware: ibm thinkpad t30
> kernel: 2.6.18
> problem:
> 
> airo(): Probing for PCI adapters
> ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
> ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [LNKC] -> GSI 11 (level,
> low) -> IRQ 11
> airo(eth1): Found an MPI350 card
> airo(eth1): Max tries exceeded when issueing command
> airo(eth1): Couldn't allocate RX FID
> airo(eth1): Could not map memory
> airo(): Finished probing for PCI adapters

It appears that the driver cannot talk to your card; see the "max tries
exceeded when issueing command".  Did this card work previously with a
kernel?  Can narrow down which kernels have problems and which don't?

> Any ideas?
> 
> 1) Firmware upgrade/downgrade? (How?)

It's a bit hard to figure out what firmware you have because the driver
can't talk to the card; can you boot under Windows and determine that
using the Cisco wireless utility?  You also need to flash the card under
Windows, not Linux, ideally to a version of firmware greater than
5.60.08.

> 2) Command sequence to better reset the card? Documentation?

reloading the driver (rmmod airo; modprobe airo) should reset the card.

Dan


