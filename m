Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265311AbTFFFUa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 01:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265314AbTFFFUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 01:20:30 -0400
Received: from pan.togami.com ([66.139.75.105]:19357 "EHLO pan.mplug.org")
	by vger.kernel.org with ESMTP id S265311AbTFFFU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 01:20:29 -0400
Subject: Re: 2.4.21-rc7 AMD64 dpt_i2o fails compile
From: Warren Togami <warren@togami.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1054842344.15457.43.camel@dhcp22.swansea.linux.org.uk>
References: <1054789161.3699.67.camel@laptop.suse.lists.linux.kernel>
	 <20030605010841.A29837@devserv.devel.redhat.com.suse.lists.linux.kernel>
	 <1054799692.3699.77.camel@laptop.suse.lists.linux.kernel>
	 <1054808477.15276.0.camel@dhcp22.swansea.linux.org.uk.suse.lists.linux.kernel>
	 <p73wug067qb.fsf@oldwotan.suse.de>
	 <1054842344.15457.43.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Message-Id: <1054877581.3699.113.camel@laptop>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (1.3.92-1) (Preview Release)
Date: 05 Jun 2003 19:33:02 -1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-05 at 09:45, Alan Cox wrote:
> On Iau, 2003-06-05 at 13:15, Andi Kleen wrote:
> > Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > 
> > > Fixing up dpt_i2o for the new DMA stuff is a major job. Fixing it
> for
> > > 64bit cleanness even more so.
> > 
> > If the hardware/firmware supports 64bit pointers then at least AMD64
> > can work without the PCI DMA API. 
> 
> 32bit all around as far I as I can tell

http://www.adaptec.com/worldwide/support/suppdetail.html?cat=%2fProduct%2fASR-2110S&prodkey=ASR-2110S
http://www.adaptec.com/worldwide/support/techspecs.html?prodkey=ASR-2110S&cat=%2fProduct%2fASR-2110S
Adaptec SCSI RAID 2110S claims to be a "64-bit/66MHz PCI-to-SCSI RAID
card".  The physical card is longer than normal 32-bit PCI cards with
more pins that fit into a "64-bit PCI slot".  Are Adaptec's claims of
64-bit hardware false?

32-bit Red Hat 9 with dpt_i2o is working great with Opteron and this
card, so I have a safe option to fallback on if we can't fix the 64-bit
operation.

Warren Togami
warren@togami.com

