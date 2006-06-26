Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWFZL7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWFZL7w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 07:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbWFZL7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 07:59:52 -0400
Received: from lug.demon.co.uk ([83.104.159.110]:26856 "EHLO lug.demon.co.uk")
	by vger.kernel.org with ESMTP id S1750700AbWFZL7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 07:59:51 -0400
From: David Johnson <dj@david-web.co.uk>
Reply-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Drivers statically linked in the wrong order
Date: Mon, 26 Jun 2006 12:59:25 +0100
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606261259.25959.dj@david-web.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently working on a few kernel drivers (not yet merged into the 
kernel). The main driver (for talking to some hardware over an I2C bus) 
relies on another (for the I2C bus itself).

When compiled as modules, loading the main driver with modprobe loads the I2C 
bus driver automatically. But when statically linked into the kernel the main 
driver is loaded before the I2C bus driver, which causes it to barf.

How can I get the I2C bus driver to be linked before the main driver? I've 
tried re-ordering things in Makefiles, but nothing I've tried seems to make 
any difference.

The I2C bus driver is:
drivers/i2c/busses/i2c-envctrl.c

While the main driver is:
arch/sparc64/kernel/env_envctrl.c

Any help would be greatly appreciated!

Thanks,
David.
