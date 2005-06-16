Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbVFPVGC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVFPVGC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 17:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbVFPVGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 17:06:02 -0400
Received: from 64-60-250-34.cust.telepacific.net ([64.60.250.34]:56762 "EHLO
	panta-1.pantasys.com") by vger.kernel.org with ESMTP
	id S261830AbVFPVFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 17:05:55 -0400
Message-ID: <42B1E9B2.30504@pantasys.com>
Date: Thu, 16 Jun 2005 14:05:54 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sean Bruno <sean.bruno@dsl-only.net>
CC: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
References: <20050605204645.A28422@jurassic.park.msu.ru>	 <Pine.LNX.4.58.0506091617130.2286@ppc970.osdl.org>	 <20050610184815.A13999@jurassic.park.msu.ru>	 <200506102247.30842.koch@esa.informatik.tu-darmstadt.de>	 <1118762382.9161.3.camel@home-lap>	 <20050616142039.GF21542@erebor.esa.informatik.tu-darmstadt.de>	 <42B1B4D3.3060600@pantasys.com> <1118955201.10529.10.camel@home-lap>
In-Reply-To: <1118955201.10529.10.camel@home-lap>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jun 2005 21:03:24.0968 (UTC) FILETIME=[D5FD2A80:01C572B6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Bruno wrote:
> Just for the record Peter, what motherboard r u using?  

This is a custom motherboard that we've developed in house :-(

It is based on the nforce4 chipset.

Looking at what I see in our lspci output we get strange values for the 
bars of the ATI device and the second Nvidia GPU, ie large negative 
values. The addresses for these devices also look strange and overlap.

I tried applying the patches from this thread. They change the behaviour 
for the configuration of the BARs, but not actually the PCI addresses 
for these devices...

I have a bunch more information on this if anyone is willing to take a look.

peter
