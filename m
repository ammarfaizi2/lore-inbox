Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265988AbUBPXCJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 18:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266016AbUBPXBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 18:01:06 -0500
Received: from aun.it.uu.se ([130.238.12.36]:5082 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266011AbUBPW7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 17:59:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16433.19261.280849.983457@alkaid.it.uu.se>
Date: Mon, 16 Feb 2004 23:59:09 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Tetsuji Rai <tetsuji_rai@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cannot enable APIC with 2.6.2
In-Reply-To: <403101BA.1060202@yahoo.com>
References: <403101BA.1060202@yahoo.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuji Rai writes:
 > I enabled APIC in config file of kernel 2.6.2, however APIC is not enabled
 > on boot.   I'm sure APIC is enabled on my machine by BIOS, because I
 > confirmed it with WIndows XP.  What's wrong with my settings?   Or it's a
 > bug of kernel?.....I suspect my config should be wrong.....

"APIC" here means I/O-APIC. The local APIC is Ok according to the dmesg log.

 > # CONFIG_SMP is not set
 > # CONFIG_PREEMPT is not set
 > CONFIG_X86_UP_APIC=y
 > CONFIG_X86_UP_IOAPIC=y
 > CONFIG_X86_LOCAL_APIC=y

This part is fine.

 > CONFIG_MTRR=y

But here the .config ends, so we can't tell if ACPI is enabled or not.

 > -----dmesg-----

The kernel found no MP tables. The only chance left to enable the
I/O-APIC is for you to configure ACPI and pray it works on your machine.

(BTW, you're overclocking your P4 by about 8%.)
