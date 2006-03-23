Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWCWQwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWCWQwT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 11:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWCWQwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 11:52:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8359 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751192AbWCWQwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 11:52:16 -0500
Subject: Re: 2.6.16-git6: build failure: ne2k-pci: footbridge_defconfig
From: Arjan van de Ven <arjan@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20060323164109.GD25849@flint.arm.linux.org.uk>
References: <20060323164109.GD25849@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 17:52:12 +0100
Message-Id: <1143132732.3147.33.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-23 at 16:41 +0000, Russell King wrote:
> Building the ARM footbridge_defconfig provokes this build error:
> 
>   CC      drivers/net/ne2k-pci.o
> drivers/net/ne2k-pci.c:123: error: pci_clone_list causes a section type conflict
> make[2]: *** [drivers/net/ne2k-pci.o] Error 1
> make[1]: *** [drivers/net] Error 2
> make: *** [drivers] Error 2
> make: Leaving directory `/var/tmp/kernel-orig'
> 
> static const struct {
>         char *name;
>         int flags;
> } pci_clone_list[] __devinitdata = {
> 
> const data can't be __devinitdata.


that's a gcc bug; probably arm specific even?

