Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbTIEBCO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 21:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbTIEBCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 21:02:14 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:31451 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261367AbTIEBCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 21:02:11 -0400
Subject: Re: Remote SCSI Emulation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Lang <david.lang@digitalinsight.com>
Cc: Nuno Silva <nuno.silva@vgertech.com>, Wes Felter <wesley@felter.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0309041656240.18624-100000@dlang.diginsite.com>
References: <Pine.LNX.4.44.0309041656240.18624-100000@dlang.diginsite.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062723666.23275.10.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Fri, 05 Sep 2003 02:01:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-09-05 at 00:59, David Lang wrote:>
> > Another, more generic, solution is "ip over scsi":
> >
> > http://www.google.com/search?q=%22ip+over+scsi%22
> 
> Actually, ip over scsi cannot accomplish the goal listed above.

No, it can instead replace much of it with a better infrastructure as
can ATA over ethernet. Or you can push the whole problem up to fs level
and you get stuff like LUSTRE

> what is beeing looked for here is the scsi equivalent of the USB 'gadget'
> driver, letting linux be at the slave end of things as well as the master.

Which is a strange place to put a Linux box but I guess you might want
to build a legacy SCSI raid box that way as opposed to iSCSI.

> does anyone have an idea why *BSD was able to do this, but all the linux
> projects seem to get stuck half-finished? is this just added complexity
> due to the large number of linux scsi drivers or is there something deeper
> in the system?

You need to add target support to some of the drivers and probably a
chunk of infrastructure as well. I suspect someone did the job for BSD
and since its pretty rarely needed and its normally in a closed box
where the core OS being Linux doesn't matter everyone else just used BSD
for that job. 


