Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbTFKORI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 10:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTFKORH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 10:17:07 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:31480 "EHLO gaston")
	by vger.kernel.org with ESMTP id S262000AbTFKORF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 10:17:05 -0400
Subject: pci_domain_nr vs. /sys/devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Matthew Wilcox <willy@debian.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055341842.754.3.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Jun 2003 16:30:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new pci_domain_nr() is good for adding the PCI domain number to
the /sys/devices/pciN/* names, but I think that's not the proper
representation. It should really be

  /sys/devices/pci-domainN/pciN/*

So we can pave the way for when we'll stop play bus number tricks and
actually have overlapping PCI bus numbers between domains. (I don't plan
to do that immediately because that would break userland & /proc/bus/pci
backward compatiblity)

What do you think ?

Ben.

