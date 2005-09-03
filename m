Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbVICK2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbVICK2D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 06:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbVICK2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 06:28:02 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61960 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750827AbVICK2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 06:28:00 -0400
Date: Sat, 3 Sep 2005 11:27:56 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: 2.6.13-git3: build failure: sysctl_optmem_max
Message-ID: <20050903112756.D29708@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	netdev@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to build a kernel with CONFIG_SYSCTL disabled, the following
error occurs:

  CC      net/ipv4/ip_sockglue.o
net/ipv4/ip_sockglue.c: In function `ip_setsockopt':
net/ipv4/ip_sockglue.c:622: error: `sysctl_optmem_max' undeclared (first use in
net/ipv4/ip_sockglue.c:622: error: (Each undeclared identifier is reported only
net/ipv4/ip_sockglue.c:622: error: for each function it appears in.)

It seems that sysctl_optmem_max is only available if CONFIG_SYSCTL is set.
However, ip_setsockopt makes unconditional usage of this variable.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
