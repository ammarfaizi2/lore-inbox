Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTJIGYZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 02:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbTJIGYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 02:24:25 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:29083 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S261893AbTJIGYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 02:24:24 -0400
Date: Thu, 9 Oct 2003 08:24:25 +0200
From: Ookhoi <ookhoi@humilis.net>
To: Allen Martin <AMartin@nvidia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: disable ACPI as a solution for "NETDEV WATCHDOG: eth0: transm it timed out"?
Message-ID: <20031009062425.GA2692@favonius>
Reply-To: ookhoi@humilis.net
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F71F@mail-sc-6.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F71F@mail-sc-6.nvidia.com>
X-Uptime: 07:38:00 up 122 days,  7:54, 34 users,  load average: 1.06, 1.04, 1.01
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allen Martin wrote (ao):
> > /proc/interrupts
> >            CPU0
> >   0: 1918692128    IO-APIC-edge  timer
> >   1:    3397768    IO-APIC-edge  i8042
> >   2:          0          XT-PIC  cascade
> >   3: 1969607482    IO-APIC-edge  NVidia NForce2
> >   9:          0   IO-APIC-level  acpi
> >  11:  127934187    IO-APIC-edge  eth0
> >  12:   95839554    IO-APIC-edge  i8042
> >  14:   27125149    IO-APIC-edge  ide0
> > NMI:          0
> > LOC: 1854644890
> > ERR:          0
> > MIS:          0
> 
> There's your problem, eth0 should have a level triggered interrupt.
> Disabling ACPI or APIC will help.

Thanks a lot for your answer. I'll try to disable ACPI then. Is this a
bug (bios/kernel) or expected?
