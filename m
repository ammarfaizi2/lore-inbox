Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265610AbTFND6X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 23:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265611AbTFND6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 23:58:23 -0400
Received: from 12-234-128-127.client.attbi.com ([12.234.128.127]:9424 "EHLO
	andrei.myip.org") by vger.kernel.org with ESMTP id S265610AbTFND6R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 23:58:17 -0400
Subject: generic method to assign IRQs
From: Florin Andrei <florin@andrei.myip.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1055563922.11874.29.camel@rivendell.home.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-1) 
Date: 13 Jun 2003 21:12:02 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any generic method to manually assign IRQs to devices? Not
something that applies to one kernel module or another, but something
that works in general.

It happens quite often, especially on multimedia workstations, when
multiple devices get assigned the same IRQ, the performance goes down
the toilet, and users experience strange things like "my video capture
application stutters when my system sends/receives traffic on the
network card."
In such cases, the usual recommendation is to "shuffle the PCI cards
around." Sometimes that works, sometimes it doesn't. It definitely
doesn't apply to laptops.
Another trick is to enable APIC in the kernel. While this is not a
direct solution, it helps sometimes by providing a larger IRQ space. In
some rare cases it makes the systems less stable.

However, quite often i've heard people saying "i wish i could just
manually assign IRQs to devices, just like i do on That Other Operating
System."

This issue may not matter much on "normal" systems, but it matters a
whole bunch on multimedia machines. Not being able to untangle like five
or six devices assigned to the same IRQ may render an otherwise powerful
system totally unusable for any decent media purpose (i'm talking here
about simple tasks such as watching movies, not necessarily of
professional stuff, which is even more demanding).

Any suggestions?

Thanks,

-- 
Florin Andrei

http://florin.myip.org/

