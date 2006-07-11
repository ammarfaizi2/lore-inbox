Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWGKOml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWGKOml (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWGKOml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:42:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7631 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750884AbWGKOmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:42:40 -0400
Subject: Re: [patch] do not allow IPW_2100=Y or IPW_2200=Y
From: Arjan van de Ven <arjan@infradead.org>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: David Miller <davem@davemloft.net>, auke-jan.h.kok@intel.com,
       jgarzik@pobox.com, pavel@ucw.cz, yi.zhu@intel.com,
       jketreno@linux.intel.com, netdev@vger.kernel.org,
       linville@tuxdriver.com, linux-kernel@vger.kernel.org,
       mark.fasheh@oracle.com
In-Reply-To: <20060710205620.GO11640@ca-server1.us.oracle.com>
References: <20060710152032.GA8540@elf.ucw.cz> <44B2940A.2080102@pobox.com>
	 <44B29C8A.8090405@intel.com> <20060710.114717.44959528.davem@davemloft.net>
	 <1152557518.4874.79.camel@laptopd505.fenrus.org>
	 <20060710205620.GO11640@ca-server1.us.oracle.com>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 16:42:13 +0200
Message-Id: <1152628933.3128.70.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 13:56 -0700, Joel Becker wrote:
> On Mon, Jul 10, 2006 at 08:51:58PM +0200, Arjan van de Ven wrote:
> > > Besides, the initramfs runs long after the driver init routine
> > > runs which is when the firmware needs to be available.
> > 
> > .. unless you use sysfs to do a fake hotunplug + replug the device, at
> > which point the driver init routine runs again.
> 
> 	Can we document how to do that?  I've wanted to synthesize such
> things before, and I couldn't quite reason how.

just load fakephp

then do 
echo -n 0 > /sys/bus/pci/slots/0000:04:02.1/power
this hotunplugs it (fake)

then just do

echo -n 1 > /sys/bus/pci/slots/0000:04:02.0/power
(or any other device on the 04 bus) and the kernel finds the 04:02.1
device again...


