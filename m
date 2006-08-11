Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWHKXFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWHKXFa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 19:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWHKXFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 19:05:30 -0400
Received: from falcon30.maxeymade.com ([24.173.215.190]:17072 "EHLO
	bebe.enoyolf.org") by vger.kernel.org with ESMTP id S1751248AbWHKXF3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 19:05:29 -0400
X-Mailer: exmh enoyolf.org version 2.7.2.1 01/17/2005 with nmh-1.2
In-reply-to: <1155336653.3552.54.camel@mulgrave.il.steeleye.com>
References: <1155334308.7574.50.camel@localhost.localdomain> <1155335237.3552.48.camel@mulgrave.il.steeleye.com> <1155335506.7574.54.camel@localhost.localdomain> <1155336653.3552.54.camel@mulgrave.il.steeleye.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux scsi <linux-scsi@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>,
       Mike Anderson <andmike@us.ibm.com>
Subject: Re: aic7xxx broken in 2.6.18-rc3-mm2
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 11 Aug 2006 18:05:13 -0500
Message-ID: <20060811230513.177186@bebe.enoyolf.org>
From: Doug Maxey <dwm@enoyolf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Aug 2006 17:50:53 CDT, James Bottomley wrote:
> > 0000:02:01.0 0100: 9005:00cf (rev 01)
> > 0000:02:01.1 0100: 9005:00cf (rev 01)
> 
> OK strike that.  The aic94xx cards all have IDs like 9005:04XX
> 
> There does seem to be a cockup in the initialisation tables, but I can't
> see how it could affect what you're seeing. (PCI_DEVICE() uses the .name
> = value initialisation method and the fields following are unnamed).  Do
> you build both of these into the kernel, and if so does it work when
> they're both modular?
> 
> James

Brian King had a similar issue come up between the ipr card and the 
DAC960.  In that case, the subsys id's were wild carded, which prevented 
the correct driver being loaded for ipr.

++doug

