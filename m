Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263127AbTIVTng (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 15:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263196AbTIVTng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 15:43:36 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:7948 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S263127AbTIVTnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 15:43:35 -0400
Message-ID: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F6B3@mail-sc-6.nvidia.com>
From: Allen Martin <AMartin@nvidia.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       Per Andreas Buer <perbu@linpro.no>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: SiI3112: problemes with shared interrupt line?
Date: Mon, 22 Sep 2003 12:42:48 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just about every bug report I have about SI3112 now is on Nforce
> chipsets. At the moment however I don't know what the magic connection
> is.
> 

There are two issues I know about:

1) Earlier versions of the Asus BIOS would program incorrect timing in the
nForce internal P2P bridge, causing failures with SI3112 under high disk
activity.  This is fixed in rev 1005 of their BIOS or later.

2) PCI interrupts getting put into edge triggered mode when ACPI/APIC are
enabled.  Andrew de Quincey said this should be fixed in 2.4.22, but I
haven't tested it myself (I have ACPI disabled on all my test systems).  I
did verify his patch on 2.6 when he first posted it, and it works.

-Allen
