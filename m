Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWBJPoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWBJPoL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 10:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWBJPoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 10:44:10 -0500
Received: from [81.2.110.250] ([81.2.110.250]:10671 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932146AbWBJPoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 10:44:09 -0500
Subject: Re: libATA  PATA status report, new patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Meelis Roos <mroos@linux.ee>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060210120157.GB28676@harddisk-recovery.com>
References: <20060207084347.54CD01430C@rhn.tartu-labor>
	 <1139310335.18391.2.camel@localhost.localdomain>
	 <Pine.SOC.4.61.0602071305310.10491@math.ut.ee>
	 <1139312330.18391.14.camel@localhost.localdomain>
	 <1139324653.18391.41.camel@localhost.localdomain>
	 <Pine.SOC.4.61.0602082024010.21660@math.ut.ee>
	 <1139499102.1255.45.camel@localhost.localdomain>
	 <Pine.SOC.4.61.0602092307460.16686@math.ut.ee>
	 <20060210120157.GB28676@harddisk-recovery.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Feb 2006 15:46:37 +0000
Message-Id: <1139586397.12521.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-02-10 at 13:01 +0100, Erik Mouw wrote:
> Alan, can this related to LBA48 compatibility? I remember having
> problems with this when Andre Hedrick added LBA48 support around
> linux-2.4.19. The drive (Maxtor 4D040H2) advertised it supported LBA48,
> but the chipset (Ali 1543 rev C3, IIRC) didn't.

I don't think so. There is code to handle it. More likely the tuning
code is wrong and loaded incorrect values. We identify at PIO0 then
select modes.

Best way to test:

Boot with mwdma/udma set to zero in "info" block

then

Boot with only pio 0 claimed as supported and the mode setting logic 
commented out.


That gives a good idea what broke.

