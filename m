Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264608AbUBEKvU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 05:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUBEKvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 05:51:20 -0500
Received: from mail.bbb2.mdc-berlin.de ([141.80.34.25]:49169 "EHLO
	mail.bbb2.mdc-berlin.de") by vger.kernel.org with ESMTP
	id S264608AbUBEKvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 05:51:14 -0500
Subject: Re: imm.ko and linux-2.6.1 or linux-2.6.2
From: Juergen Rose <rose@rz.uni-potsdam.de>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040204222223.GC21151@parcelfarce.linux.theplanet.co.uk>
References: <1075929081.30698.76.camel@moen.bioinf.mdc-berlin.de>
	 <20040204222223.GC21151@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Organization: Max-Delbrueck-Zentrum
Message-Id: <1075978271.13994.20.camel@moen.bioinf.mdc-berlin.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 05 Feb 2004 11:51:11 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viro,

On Wed, 2004-02-04 at 23:22, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Wed, Feb 04, 2004 at 10:11:21PM +0100, Juergen Rose wrote:
> > Hi,
> > 
> > I am very satisfied with the imm driver, when I am using it with
> > linux-2.4.*, everything is working fine. But using imm.ko together with
> > linux-2.6.1 or linux-2.6.2 I get:
> >  
> > imm: Version 2.05 (for Linux 2.4.0)
> > imm: parport reports no devices.
> > FATAL: Error inserting imm
> > (/lib/modules/2.6.2/kernel/drivers/scsi/imm.ko): No such device
> > 
> > if I perform 'modprobe imm'. I can't reach the email address in imm.c
> > (<campbell@torque.net>... User unknown).  Do you have any hint for me?
> 
> Have you tried -mm?  There are both generic parport patches and patches
> specifically for imm.c; it looks like generic parport problem, though.
> 
> BTW, have the parport code found any ports in the first place?  Boot
> log would be useful...

I am loading parport as a module. If I scan dmesg or /var/log/syslog for
parport I find only
vilm:/usr/src/linux(30)# grep parp /var/log/syslog
Feb  4 13:06:55 vilm kernel: imm: parport reports no devices.
Feb  4 16:53:20 vilm kernel: imm: parport reports no devices.
...
vilm:/usr/src/linux(32)#dmesg | grep parp
imm: parport reports no devices.

I tried to install linux-2.6.2-mm1, but 'make menuconfig' gives only:

vilm:/usr/src/linux(35)#make menuconfig
make[1]: `scripts/fixdep' is up to date.
scripts/kconfig/mconf arch/i386/Kconfig
drivers/pnp/Kconfig:34: can't open file "drivers/pnp/isapnp/Kconfig"
make[1]: *** [menuconfig] Error 1

Any further hint?

	Regards Juergen


-- 
Juergen Rose <rose@rz.uni-potsdam.de>
Max-Delbrueck-Zentrum

