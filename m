Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbTIHJmb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 05:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbTIHJmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 05:42:31 -0400
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:33929 "EHLO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262234AbTIHJlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 05:41:22 -0400
Message-ID: <20030908094220.31791.qmail@bilbo.math.uni-mannheim.de>
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Forcing CONFIG_X86_IO_APIC=n
Date: Mon, 8 Sep 2003 11:39:23 +0200
User-Agent: KMail/1.5.3
References: <20030907090610.4a47ec2a.scott@thomasons.org>
In-Reply-To: <20030907090610.4a47ec2a.scott@thomasons.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Von Scott Thomason:

> I'd like to try forcing CONFIG_X86_IO_APIC=n while I test 2.6.0-test4,
> but apparently some part of the kernel build re-runs my .config thru
> something and keeps changing it back to 'y'. Is there any way to
> accomplish this?

eike@bilbo:/mnt/kernel/linux-2.6.0-test4> find . -name Kconfig | xargs grep -B 2 "depends .*X86_IO_APIC"
./drivers/pci/hotplug/Kconfig-config HOTPLUG_PCI_IBM
./drivers/pci/hotplug/Kconfig-  tristate "IBM PCI Hotplug driver"
./drivers/pci/hotplug/Kconfig:  depends on HOTPLUG_PCI && X86_IO_APIC && X86

Maybe you set HOTPLUG_PCI_IBM to yes?

Eike
