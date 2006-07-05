Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965058AbWGEVvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbWGEVvg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 17:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbWGEVvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 17:51:35 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:15022 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965045AbWGEVve
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 17:51:34 -0400
Subject: Re: + edac-new-opteron-athlon64-memory-controller-driver.patch
	added to -mm tree
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: Doug Thompson <norsk5@yahoo.com>, akpm@osdl.org,
       mm-commits@vger.kernel.org, norsk5@xmission.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060704113441.GA26023@muc.de>
References: <20060701150430.GA38488@muc.de>
	 <20060703172633.50366.qmail@web50109.mail.yahoo.com>
	 <20060703184836.GA46236@muc.de>
	 <1151962114.16528.18.camel@localhost.localdomain>
	 <20060704092358.GA13805@muc.de>
	 <1152007787.28597.20.camel@localhost.localdomain>
	 <20060704113441.GA26023@muc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 05 Jul 2006 23:08:21 +0100
Message-Id: <1152137302.6533.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-07-04 am 13:34 +0200, ysgrifennodd Andi Kleen:
> > > Giving a consistent sysfs interface is a bit harder, but I suppose one 
> > > could change the code to provide pseudo banks for enable/disable too.
> > > However that would be system specific again, so a default "all on/all off" 
> > > policy might be quite ok.
> > 
> > I think we need the basic consistent sysfs case. Whether that is
> 
> What should i do?

Well personally I would favour the MCE logging stuff staying in because
its clearly small, compact and enough for many users, and the EDAC stuff
hooking that feed somehow so that people who want the detail and the
common behaviour across platforms can load the extra module.

As to filtering and control of the banks - that can always be done by
filtering what is handed down from the MCE code if I understand it right
so can be left in the EDAC side.

But thats just my opinion. It is based on what I'm seeing in terms of
feedback from people using EDAC a lot (eg in clusters). 

Alan

