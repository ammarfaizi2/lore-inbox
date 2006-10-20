Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946210AbWJTEfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946210AbWJTEfU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 00:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161439AbWJTEfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 00:35:20 -0400
Received: from www.swissdisk.com ([216.66.254.197]:40578 "EHLO
	swissweb.swissdisk.com") by vger.kernel.org with ESMTP
	id S1161021AbWJTEfS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 00:35:18 -0400
Subject: Re: revert mv643xx change from ubuntu tree
From: Ben Collins <ben.collins@ubuntu.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>
In-Reply-To: <20061019121836.GA26319@aepfle.de>
References: <20061019121836.GA26319@aepfle.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date: Fri, 20 Oct 2006 00:35:01 -0400
Message-Id: <1161318901.31915.21.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-19 at 14:18 +0200, Olaf Hering wrote:
> Somehow the Ubuntu guys managed to sneak this compile error into the
> tree:
> 
> commit ce9e3d9953c8cb67001719b5516da2928e956be4
> 
>       [mv643xx] Add pci device table for auto module loading.
> 
> drivers/net/mv643xx_eth.c:1560: error: array type has incomplete element type
> drivers/net/mv643xx_eth.c:1561: warning: implicit declaration of function ‘PCI_DEVICE’
> drivers/net/mv643xx_eth.c:1561: error: ‘PCI_VENDOR_ID_MARVELL’ undeclared here (not in a function)
> drivers/net/mv643xx_eth.c:1561: error: ‘PCI_DEVICE_ID_MARVELL_MV64360’ undeclared here (not in a function)

Correct, I missed the include for linux/pci.h.

This patch has been trailing our tree since 2.6.12. Could you help me to
understand what in this driver will cause it to be autoloaded by udev
when compiled as a module?
