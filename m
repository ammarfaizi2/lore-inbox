Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbTJHRYN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 13:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbTJHRYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 13:24:12 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:25357 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S261705AbTJHRYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 13:24:09 -0400
Message-ID: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F71F@mail-sc-6.nvidia.com>
From: Allen Martin <AMartin@nvidia.com>
To: "'ookhoi@humilis.net'" <ookhoi@humilis.net>, linux-kernel@vger.kernel.org
Subject: RE: disable ACPI as a solution for "NETDEV WATCHDOG: eth0: transm
	it timed out"?
Date: Wed, 8 Oct 2003 10:23:48 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /proc/interrupts
>            CPU0
>   0: 1918692128    IO-APIC-edge  timer
>   1:    3397768    IO-APIC-edge  i8042
>   2:          0          XT-PIC  cascade
>   3: 1969607482    IO-APIC-edge  NVidia NForce2
>   9:          0   IO-APIC-level  acpi
>  11:  127934187    IO-APIC-edge  eth0
>  12:   95839554    IO-APIC-edge  i8042
>  14:   27125149    IO-APIC-edge  ide0
> NMI:          0
> LOC: 1854644890
> ERR:          0
> MIS:          0

There's your problem, eth0 should have a level triggered interrupt.
Disabling ACPI or APIC will help.

-Allen
