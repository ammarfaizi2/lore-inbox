Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316051AbSGSHMV>; Fri, 19 Jul 2002 03:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSGSHMV>; Fri, 19 Jul 2002 03:12:21 -0400
Received: from [65.164.36.169] ([65.164.36.169]:3968 "EHLO wolf.mikes.home")
	by vger.kernel.org with ESMTP id <S316051AbSGSHMU>;
	Fri, 19 Jul 2002 03:12:20 -0400
Date: Fri, 19 Jul 2002 00:18:57 -0700 (PDT)
From: "Michael G. Janicki" <mikejani@colfax.com>
To: Doug Ledford <dledford@redhat.com>
cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Dale Amon <amon@vnl.com>,
       linux-kernel@vger.kernel.org, Frank Davis <fdavis@si.rr.com>
Subject: Re: 2.5.26 : drivers/scsi/BusLogic.c
In-Reply-To: <20020718211936.C28235@redhat.com>
Message-ID: <Pine.LNX.4.20.0207190011410.439-100000@wolf.mikes.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2002, Doug Ledford wrote:

> There was a bug in the patch I sent through last.  This patch should be 
> applied on top of the last one to solve a memory leak on unloading of the 
> module.

  All I had available was a 2.4.19-rc2, but your patch applies,
with offsets, against it.  2 non-critical failed hunks were simple
enough by hand.

  Builds, boots, runs -- has survived 2 bonnie++ runs and normal
user load for the last few hours with no problems.  I've been
avoiding use of 2.5 on this box, but if you need to see this against
2.5.26, let me know and I can convert this box this weekend.

  System is SMP, dual PCI BusLogic BT-958's, 2.4.19-rc2 with
O(1) scheduler patch and your BusLogic DMA patch.  BusLogic
is non-module, the boot disk hangs off the first adapter.  Let
me know if you need specific testing.

	Mike

-- 
Michael Janicki
Key: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0x9D6FAE1A
Fingerprint: A153 DFC7 8B49 7E97 67B2  3DCE DA3F 3CC5 9D6F AE1A


