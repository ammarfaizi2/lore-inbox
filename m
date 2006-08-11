Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWHKWu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWHKWu6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 18:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWHKWu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 18:50:57 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:20957 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751088AbWHKWu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 18:50:57 -0400
Subject: Re: aic7xxx broken in 2.6.18-rc3-mm2
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux scsi <linux-scsi@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>,
       Mike Anderson <andmike@us.ibm.com>
In-Reply-To: <1155335506.7574.54.camel@localhost.localdomain>
References: <1155334308.7574.50.camel@localhost.localdomain>
	 <1155335237.3552.48.camel@mulgrave.il.steeleye.com>
	 <1155335506.7574.54.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 17:50:53 -0500
Message-Id: <1155336653.3552.54.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 0000:02:01.0 0100: 9005:00cf (rev 01)
> 0000:02:01.1 0100: 9005:00cf (rev 01)

OK strike that.  The aic94xx cards all have IDs like 9005:04XX

There does seem to be a cockup in the initialisation tables, but I can't
see how it could affect what you're seeing. (PCI_DEVICE() uses the .name
= value initialisation method and the fields following are unnamed).  Do
you build both of these into the kernel, and if so does it work when
they're both modular?

James




