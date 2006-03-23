Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWCWQlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWCWQlS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 11:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbWCWQlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 11:41:17 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51976 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932106AbWCWQlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 11:41:17 -0500
Date: Thu, 23 Mar 2006 16:41:09 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: 2.6.16-git6: build failure: ne2k-pci: footbridge_defconfig
Message-ID: <20060323164109.GD25849@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Jeff Garzik <jgarzik@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Building the ARM footbridge_defconfig provokes this build error:

  CC      drivers/net/ne2k-pci.o
drivers/net/ne2k-pci.c:123: error: pci_clone_list causes a section type conflict
make[2]: *** [drivers/net/ne2k-pci.o] Error 1
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2
make: Leaving directory `/var/tmp/kernel-orig'

static const struct {
        char *name;
        int flags;
} pci_clone_list[] __devinitdata = {

const data can't be __devinitdata.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
