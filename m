Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292373AbSBBT7n>; Sat, 2 Feb 2002 14:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292369AbSBBT7a>; Sat, 2 Feb 2002 14:59:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47122 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292370AbSBBT7T>; Sat, 2 Feb 2002 14:59:19 -0500
Subject: Re: [evms-devel] [linux-lvm] [ANNOUNCE] LVM reimplementation ready for beta testing
To: clausen@gnu.org (Andrew Clausen)
Date: Sat, 2 Feb 2002 19:42:31 +0000 (GMT)
Cc: corryk@us.ibm.com (Kevin Corry),
        thornber@fib011235813.fsnet.co.uk (Joe Thornber),
        linux-lvm@sistina.com, evms-devel@lists.sourceforge.net,
        Jim@mcdee.net (Jim McDonald), adilger@turbolabs.com (Andreas Dilger),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020203003937.B874@gnu.org> from "Andrew Clausen" at Feb 03, 2002 12:39:37 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16X63T-0000KH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > this graph (except the volume group). But in reality, we don't want someone 
> > coming along and mucking with md0 or with LV2 or with any of the disk 
> > partitions, because they are all in use by the two volumes at the top.
> 
> It's the user's fault if they choose to write on such a device.

You want access to the raw devices as well as the virtual volumes. You
try doing SMART diagnostics online on an md volume if you can't get
at /dev/hd* and /dev/sd*.

You don't want to mount both layers at once I suspect, but even that
may be questionable for a read only mirror.

Alan
