Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264924AbTFQU33 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 16:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264938AbTFQU33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 16:29:29 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:52693 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264924AbTFQU3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 16:29:23 -0400
Date: Tue, 17 Jun 2003 22:43:08 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux NICS <linux.nics@intel.com>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: Linux 2.5.72: ixgb_ethtool: strange SUPPORTED_10000baseT_Full
Message-ID: <20030617204307.GD29247@fs.tum.de>
References: <20030617203407.GC29247@fs.tum.de> <3EEF7BB3.9050700@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EEF7BB3.9050700@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 04:36:03PM -0400, Jeff Garzik wrote:
> Adrian Bunk wrote:
> >The correct solution seems to be to remove the #define from 
> >ixgb_ethtool.c ?
> 
> 
> correct.
> 
> wanna send a patch?  ;-)

Yup.  :-)

Compilation tested with 2.5.72.

--- linux-2.5.72/drivers/net/ixgb/ixgb_ethtool.c.old	2003-06-17 22:40:40.000000000 +0200
+++ linux-2.5.72/drivers/net/ixgb/ixgb_ethtool.c	2003-06-17 22:40:55.000000000 +0200
@@ -50,7 +50,6 @@
 	return (IXGB_EEPROM_SIZE << 1);
 }
 
-#define SUPPORTED_10000baseT_Full (1 << 11)
 #define SPEED_10000 10000
 
 static void



> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

