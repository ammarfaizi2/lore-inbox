Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbUCWVaS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 16:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUCWVaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 16:30:18 -0500
Received: from news.cistron.nl ([62.216.30.38]:23224 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S262831AbUCWVaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 16:30:14 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: arch/i386/Kconfig: CONFIG_IRQBALANCE Description
Date: Tue, 23 Mar 2004 21:30:13 +0000 (UTC)
Organization: Cistron Group
Message-ID: <c3qa94$qhi$1@news.cistron.nl>
References: <1079996577.6595.19.camel@bach> <16480.28882.388997.71072@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1080077413 27186 62.216.29.200 (23 Mar 2004 21:30:13 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <16480.28882.388997.71072@gargle.gargle.HOWL>,
John Stoffel <stoffel@lucent.com> wrote:
>
>And hey, under 2.6.5-rc2-mm1, it doens't seem to do anything:
>
>  > zcat /proc/config.gz | grep IRQ
>  CONFIG_IRQBALANCE=y
>  CONFIG_IDEPCI_SHARE_IRQ=y
>
>  > cat /proc/interrupts 
>	     CPU0       CPU1       
>    0:   46272316        487    IO-APIC-edge  timer
>    1:        376          0    IO-APIC-edge  i8042
>   16:      46770          3   IO-APIC-level  ide2, ide3, ehci_hcd
>   17:     307832          1   IO-APIC-level  eth0
>   18:     118258          1   IO-APIC-level  aic7xxx, aic7xxx, ohci_hcd
>  LOC:   46279245   46279281 

Is that real SMP, or hyperthreading? If it's hyperthreading, then
it makes sense that the IRQs are not balanced.

In fact I have a server on which the IRQ balancing code does
balance over the 2 virtual CPUs by accident (still have to debug
what goes wrong and file a proper bug report) and as a result
performance sucked until I turned it off.

Mike.
-- 
Netu, v qba'g yvxr gur cynvagrkg :)

