Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbTFFRdU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 13:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbTFFRdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 13:33:20 -0400
Received: from CPE0080c8c9b431-CM014280010574.cpe.net.cable.rogers.com ([24.43.38.154]:17672
	"EHLO stargate.coplanar.net") by vger.kernel.org with ESMTP
	id S262028AbTFFRdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 13:33:19 -0400
Subject: Re: PERC4-DI?
From: Jer Jackson <jerj@coplanar.net>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030606163717.GK8594@rdlg.net>
References: <20030606163717.GK8594@rdlg.net>
Content-Type: text/plain
Organization: 
Message-Id: <1054921604.27578.11.camel@cherry2000.skynet.coplanar.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 Jun 2003 13:46:45 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Be very careful about the Dell PERC controllers.  The 4-DI is *probably*
a rebranded LSI megaraid, with Dell's firmware.  You *definitely* want
to subscribe to the linux-megaraid-devel@dell.com list.  You well almost
certainly have to recompile your kernel with an up to the minute version
of the megaraid driver.  Problems with the stock driver include server
performance problems, crashes, inability to use clustering.  Many users
complain about the megamon utility, and have reverse engineered the
firmware api and written their own utility to get around the problems. 
The source isn't available AFAIK.  I don't think it will integrate with
linux-ha heartbeat for clustering very well.  Some people have tried
flashing the LSI firmware to fix things.

I am afraid to use it in a database cluster without a *log* of time to
debug.  The EVMS clustering support is getting stable, I am currently in
the testing phase for a postgresql cluster I am building with software
raid/Adaptec SCSI controllers, and shared disk array.

Regards,

Jeremy Jackson

On Fri, 2003-06-06 at 12:37, Robert L. Harris wrote:
> My company is looking at buying some machines with "PERC4-DI" SCSI RAID
> controllers.  Poking around the .config file I'm not finding anything
> related to this.  Anyone know off the top of their heads what driver
> would be used for this controller, any known catastrophic bugs, etc?

-- 
Jer Jackson <jerj@coplanar.net>

