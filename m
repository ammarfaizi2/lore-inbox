Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263906AbRFHHhN>; Fri, 8 Jun 2001 03:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263881AbRFHHhE>; Fri, 8 Jun 2001 03:37:04 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:57616 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263816AbRFHHg4>;
	Fri, 8 Jun 2001 03:36:56 -0400
Date: Fri, 8 Jun 2001 00:35:21 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Hotplug PCI driver for 2.4.6-pre1
Message-ID: <20010608003521.B12982@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've cut another patch for the Compaq Hotplug PCI driver ported to
2.4.6-pre1.  It should also apply cleanly and run on 2.4.5, but I
haven't tested it there.  It is available at:
	http://www.kroah.com/linux/hotplug/

Here is a list of the things that have been changed since the last patch
I sent out:
	- forward ported to 2.4.6-pre1
	- reformatted the code to match kernel guidelines
	- removed most typedefs to match kernel programming style
	- removed lots of unused #defines
	- cleaned up almost all complier warnings (including those when
	  debugging is enabled.)
	- forced debugging to be enabled (this is easily switched off in
	  the cpqphpd_linux.h file if you don't like to see all of it.)
	- removed lots of global symbols, moving those that are
	  necessary to a clean namespace (hpcd_*).
	- cleaned up the probing for the hotplug device logic to make
	  other future devices easier to add.
	- other stylistic things.

I've tested this patch on both Compaq and Intel hotplug controllers
(much thanks to Compaq for providing a machine to test this out on)
using the Compaq gui tool.

Things left to do:
	- add kernel-doc style comments
	- remove more global symbols
	- incorporate native list types
	- look into removing some of the native PCI bus probing logic to
	  use the kernel provided functions where possible.
	- add support for other archs (ia64)

If anyone has any problems or questions about this version, please let
me know.

thanks,

greg k-h
