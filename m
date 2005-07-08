Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262901AbVGHWSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbVGHWSb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 18:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbVGHWPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 18:15:18 -0400
Received: from mail0.lsil.com ([147.145.40.20]:61619 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262901AbVGHWNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 18:13:51 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57060CCFAB@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'Matt Domsch'" <Matt_Domsch@dell.com>, "'Christoph Hellwig'" <hch@lst.de>
Subject: [SYSFS QUESTION] How to add new sysfs attributes under /sys/modul
	e/<my module>
Date: Fri, 8 Jul 2005 18:13:38 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sysfs Gurus,

I want to export few driver specific sysfs attributes when my driver loads.
This driver is a pci hotplug driver. I want to export these sysfs attributes
as soon as my pci_module_init succeeds.

1. I see that there is /sys/modules directory lists all the modules. Is this
a right place to have such information? Is this only for the insmod'ed
modules?
After pci_module_init, I have struct pci_driver object that gives me
kobject.
(pci_driver.driver.kobj). But from this kobject, I couldn't find a way to
reach /sys/modules/<my driver kobject>

2. When I used sysfs_create_file() on pci_driver.driver.kobj, the new
attribute
shows up under /sys/pci/drivers/<my driver>/ directory. But how do I
associate
my own show and store to this object?

I overwrote pci_driver.driver.kobj.ktype->sysfs_ops pointer with my own
sysfs_ops
structure pointer. When I cat the new attribute, I get a call to my show
attribute.
However, nothing seems to happen. The struct attribute.name that is passed
to my
show routine is NULL.

What am I doing wrong? Moreover, is it okay to overwrite the default
sysfs_ops
like this? I appreciate any help.

Sincerely,
Sreenivas
