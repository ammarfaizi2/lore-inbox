Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbVFQQvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVFQQvp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 12:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVFQQvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 12:51:45 -0400
Received: from iron.pdx.net ([207.149.241.18]:45997 "EHLO iron.pdx.net")
	by vger.kernel.org with ESMTP id S262020AbVFQQvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 12:51:42 -0400
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
From: Sean Bruno <sean.bruno@dsl-only.net>
To: Peter Buckingham <peter@pantasys.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       koch@esa.informatik.tu-darmstadt.de, torvalds@osdl.org,
       benh@kernel.crashing.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, gregkh@suse.de
In-Reply-To: <20050617093410.24a58d56.peter@pantasys.com>
References: <20050605204645.A28422@jurassic.park.msu.ru>
	 <Pine.LNX.4.58.0506091617130.2286@ppc970.osdl.org>
	 <20050610184815.A13999@jurassic.park.msu.ru>
	 <200506102247.30842.koch@esa.informatik.tu-darmstadt.de>
	 <1118762382.9161.3.camel@home-lap>
	 <20050616142039.GF21542@erebor.esa.informatik.tu-darmstadt.de>
	 <42B1B4D3.3060600@pantasys.com> <1118955201.10529.10.camel@home-lap>
	 <42B1E9B2.30504@pantasys.com> <20050617135400.A32290@jurassic.park.msu.ru>
	 <20050617093410.24a58d56.peter@pantasys.com>
Content-Type: text/plain
Date: Fri, 17 Jun 2005 09:51:37 -0700
Message-Id: <1119027098.10529.20.camel@home-lap>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-17 at 09:34 -0700, Peter Buckingham wrote:
> Sorry, I guess i didn't send that info on. When I have the resources printed out
> from dmesg i get:
> 
> PCI: Cannot allocate resource region 2 of device 0000:41:00.0
> PCI: Failed to allocate mem resource #0:1000000@280000000 for 0000:41:00.0
> PCI: Failed to allocate mem resource #1:10000000@280000000 for 0000:41:00.0
> PCI: Failed to allocate mem resource #2:1000000@280000000 for 0000:41:00.0
> 
> I can send on the full dmesg if you think it'd be useful.
> 
> peter

Ivan:

I tried the patch that seems to work for Andreas.  It does not appear to
change the behavior of my machine in the slightest.  


And on my ASUS board(2.6.12-rc6 w/git8 and ur patch), I get the
following:

PCI: Cannot allocate resource region 0 of device 0000:02:00.0
PCI: Cannot allocate resource region 3 of device 0000:04:00.0
PCI: Failed to allocate mem resource #3:1000000@fe000000 for
PCI: Bridge: 0000:00:0e.0

Where 02:00.0 is the USB controller, 04:00.0 is the sound card and
00:0e.0 is the bridge for the Broadcom ethernet adapter.

I posted the entire lspci, dmesg and a barf from the tg3 module in the
following post:
http://lkml.org/lkml/2005/6/10/211

I have contacted ASUS for more assistance, but like their web site, it
is intermittent at best.  

What can be done at this point?

Sean


