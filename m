Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVFQQeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVFQQeS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 12:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVFQQeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 12:34:18 -0400
Received: from 64-60-250-34.cust.telepacific.net ([64.60.250.34]:6374 "EHLO
	panta-1.pantasys.com") by vger.kernel.org with ESMTP
	id S262013AbVFQQeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 12:34:12 -0400
Date: Fri, 17 Jun 2005 09:34:10 -0700
From: Peter Buckingham <peter@pantasys.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: sean.bruno@dsl-only.net, koch@esa.informatik.tu-darmstadt.de,
       torvalds@osdl.org, benh@kernel.crashing.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Message-Id: <20050617093410.24a58d56.peter@pantasys.com>
In-Reply-To: <20050617135400.A32290@jurassic.park.msu.ru>
References: <20050605204645.A28422@jurassic.park.msu.ru>
	<Pine.LNX.4.58.0506091617130.2286@ppc970.osdl.org>
	<20050610184815.A13999@jurassic.park.msu.ru>
	<200506102247.30842.koch@esa.informatik.tu-darmstadt.de>
	<1118762382.9161.3.camel@home-lap>
	<20050616142039.GF21542@erebor.esa.informatik.tu-darmstadt.de>
	<42B1B4D3.3060600@pantasys.com>
	<1118955201.10529.10.camel@home-lap>
	<42B1E9B2.30504@pantasys.com>
	<20050617135400.A32290@jurassic.park.msu.ru>
Organization: PANTA Systems, inc
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jun 2005 16:31:38.0812 (UTC) FILETIME=[092CF7C0:01C5735A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jun 2005 13:54:00 +0400
Ivan Kokshaysky <ink@jurassic.park.msu.ru> wrote:

> On Thu, Jun 16, 2005 at 02:05:54PM -0700, Peter Buckingham wrote:
> > Looking at what I see in our lspci output we get strange values for the 
> > bars of the ATI device and the second Nvidia GPU, ie large negative 
> > values. The addresses for these devices also look strange and overlap.
> 
> What's wrong with these addresses? They are all unique, AFAIKS.

Sorry, I guess i didn't send that info on. When I have the resources printed out
from dmesg i get:

PCI: Resource 00009000-0000901f (f=101, d=0, p=0)
PCI: Resource 00004c00-00004c3f (f=101, d=0, p=0)
PCI: Resource 00004c40-00004c7f (f=101, d=0, p=0)
PCI: Resource 768ff000-768fffff (f=200, d=0, p=0)
PCI: Resource 00006000-0000600f (f=101, d=0, p=0)
PCI: Resource 767e0000-767fffff (f=200, d=0, p=0)
PCI: Resource 0000fc00-0000fc3f (f=101, d=0, p=0)
PCI: Resource 74600000-746fffff (f=204, d=0, p=0)
PCI: Resource 97000000-977fffff (f=120c, d=0, p=0)
PCI: Resource 80000000-8fffffff (f=120c, d=0, p=0)
PCI: Resource bfefe000-bfefefff (f=200, d=0, p=0)
PCI: Resource bfeff000-bfefffff (f=200, d=0, p=0)
PCI: Resource be000000-beffffff (f=200, d=0, p=0)
PCI: Resource c0000000-cfffffff (f=1208, d=0, p=0)
PCI: Resource bd000000-bdffffff (f=200, d=0, p=0)
PCI: Resource 9bbff000-9bbfffff (f=200, d=0, p=0)
PCI: Resource ff000000-ffffffff (f=200, d=1, p=1)
PCI: Resource ffffff00-ffffffff (f=101, d=1, p=1)
in pcibios_allocate_resources
PCI: Cannot allocate resource region 1 of device 0000:05:06.0
PCI: Resource fffff000-ffffffff (f=200, d=1, p=1)
PCI: Resource ff000000-ffffffff (f=200, d=1, p=1)
in pcibios_allocate_resources
PCI: Cannot allocate resource region 0 of device 0000:41:00.0
PCI: Resource f0000000-ffffffff (f=1208, d=1, p=1)
in pcibios_allocate_resources
PCI: Cannot allocate resource region 1 of device 0000:41:00.0
PCI: Resource ff000000-ffffffff (f=200, d=1, p=1)
in pcibios_allocate_resources
PCI: Cannot allocate resource region 2 of device 0000:41:00.0
PCI: Failed to allocate mem resource #0:1000000@280000000 for 0000:41:00.0
PCI: Failed to allocate mem resource #1:10000000@280000000 for 0000:41:00.0
PCI: Failed to allocate mem resource #2:1000000@280000000 for 0000:41:00.0

I can send on the full dmesg if you think it'd be useful.

peter
