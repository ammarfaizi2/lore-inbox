Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271465AbTGQOg7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 10:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271467AbTGQOg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 10:36:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:40882 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271466AbTGQOg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 10:36:57 -0400
Date: Thu, 17 Jul 2003 07:55:39 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI vendor and device strings in sysfs
In-Reply-To: <20030717101123.GA6069@in.ibm.com>
Message-ID: <Pine.LNX.4.44.0307170753240.1213-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Here is a patch against 2.6.0-test1 to display PCI vendor and
> device strings in sysfs.
> 
> At present, the PCI "name" attribute has a length restriction
> (DEVICE_NAME_SIZE) within which it tries to accomodate the vendor
> and device strings, leading to, in most cases, truncation of one
> or both strings.
> 
> This patch alleviates the issue by creating the vendor_name and
> device_name attributes for PCI devices.

We don't necessarily need to keep the ASCII strings around at all, and in 
the case in which CONFIG_PCI_NAMES=n, they are completely irrelevant. They 
are pretty, but we could just export the vendor/device IDs and have a 
userspace tool (e.g. sysutils from IBM) look up the name in a userspace 
database. 


	-pat

