Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbTIVUgb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 16:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263155AbTIVUgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 16:36:31 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:5894 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S263150AbTIVUga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 16:36:30 -0400
Message-ID: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F6B6@mail-sc-6.nvidia.com>
From: Allen Martin <AMartin@nvidia.com>
To: "'Witold Krecicki'" <adasi@kernel.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: SiI3112: problemes with shared interrupt line?
Date: Mon, 22 Sep 2003 13:35:53 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I've tried disabeling APIC - it did not help.
> >
> > I'll try 2.6.something tomorrow.
> Try to disable both ACPI and APIC, it helped in my case.

You can look at /proc/interrupts and see if any PCI devices have interrupts
in edge triggered mode, if so your system will be unstable unless you
disable ACPI.  If not, disabling ACPI / APIC probably won't help.

-Allen
