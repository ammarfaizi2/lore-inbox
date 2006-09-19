Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWISQgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWISQgp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 12:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbWISQgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 12:36:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55472 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030225AbWISQgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 12:36:44 -0400
Date: Tue, 19 Sep 2006 09:36:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc7-mm1
Message-Id: <20060919093641.734f8120.akpm@osdl.org>
In-Reply-To: <20060919142116.GA29190@kroah.com>
References: <20060919012848.4482666d.akpm@osdl.org>
	<20060919142116.GA29190@kroah.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2006 07:21:16 -0700
Greg KH <greg@kroah.com> wrote:

> Although the ia64 one should not be due to anything in the driver tree,
> I don't know what caused that, the pci tree is pretty tiny right now.

drivers/pci/probe.c: In function `pci_create_legacy_files':
drivers/pci/probe.c:45: warning: implicit declaration of function `device_create_bin_file'
drivers/pci/probe.c: In function `pci_remove_legacy_files':
drivers/pci/probe.c:61: warning: implicit declaration of function `device_remove_bin_file'
drivers/pci/probe.c: In function `pci_create_bus':
drivers/pci/probe.c:1033: warning: label `sys_create_link_err' defined but not used

The changes inside HAVE_PCI_LEGACY broke.

gregkh-pci-pci_bridge-device.patch
gregkh-pci-pci-sort-device-lists-breadth-first.patch and
gregkh-pci-pci-must_check-fixes.patch

touch that file.
