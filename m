Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264623AbUE2M5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264623AbUE2M5X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 08:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264648AbUE2M5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 08:57:23 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:38859 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264623AbUE2M5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 08:57:22 -0400
Date: Sat, 29 May 2004 14:57:16 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Artemio <theman@artemio.net>, bcollins@debian.org,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] let IEEE1394 select NET
Message-ID: <20040529125716.GN16099@fs.tum.de>
References: <200405291424.43982.theman@artemio.net> <20040529121408.GM16099@fs.tum.de> <20040529132356.A3014@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040529132356.A3014@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 01:23:56PM +0100, Russell King wrote:
> On Sat, May 29, 2004 at 02:14:08PM +0200, Adrian Bunk wrote:
> > The following patch lets FireWire support automatically select 
> > Networking support:
> 
> And so we get another fscking symbol which has a non-obvious way to
> turn it off.

Alternatively, the following patch would also solve this issue:

--- linux-2.6.7-rc1-mm1-full/drivers/ieee1394/Kconfig.old	2004-05-29 14:07:55.000000000 +0200
+++ linux-2.6.7-rc1-mm1-full/drivers/ieee1394/Kconfig	2004-05-29 14:56:02.000000000 +0200
@@ -4,6 +4,7 @@
 
 config IEEE1394
 	tristate "IEEE 1394 (FireWire) support"
+	depends on NET
 	help
 	  IEEE 1394 describes a high performance serial bus, which is also
 	  known as FireWire(tm) or i.Link(tm) and is used for connecting all


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

