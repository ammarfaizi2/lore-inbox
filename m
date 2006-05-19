Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWESFYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWESFYj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 01:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWESFYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 01:24:39 -0400
Received: from gate.crashing.org ([63.228.1.57]:28563 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932225AbWESFYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 01:24:38 -0400
Subject: pci-OF-bus-map deprecation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 19 May 2006 15:24:28 +1000
Message-Id: <1148016268.13249.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For 32 bits machines with Open Firmware, we used to create a
pci-OF-bus-map property in the device-tree that provided a mapping
between linux and Open Firmware PCI bus numbers (since on some platforms
like PowerMac, we still renumber PCI busses).

This property is no longer necessary as

 - Nowadays, we have sysfs and the PCI devices in there do have a full
Open Firmware device path exposed as a "devspec" file in their sysfs
directories
 - I don't think anybody ever used that property in userland :)

This mail is mostly to make sure of the later. I intend to get rid of it
in 2.6.18 (that's early, but as I said, I think nobody uses it anyway. I
intended to use it in some X stuff I never ended up actually
implementing...)

It only concerns 32 bits ppc machines with OF, and only the ones that
renumber busses, which means basically only PowerMacs.

Ben.


