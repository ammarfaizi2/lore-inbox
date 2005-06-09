Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbVFIEHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbVFIEHd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 00:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVFIEHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 00:07:32 -0400
Received: from gate.crashing.org ([63.228.1.57]:50857 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262250AbVFIEHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 00:07:17 -0400
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       Linus Torvalds <torvalds@osdl.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, gregkh@suse.de
In-Reply-To: <20050609023639.A7067@jurassic.park.msu.ru>
References: <Pine.LNX.4.58.0506031706450.1876@ppc970.osdl.org>
	 <20050604013311.GA30151@erebor.esa.informatik.tu-darmstadt.de>
	 <Pine.LNX.4.58.0506031851220.1876@ppc970.osdl.org>
	 <20050604022600.GA8221@erebor.esa.informatik.tu-darmstadt.de>
	 <Pine.LNX.4.58.0506032149130.1876@ppc970.osdl.org>
	 <20050604155742.GA14384@erebor.esa.informatik.tu-darmstadt.de>
	 <20050605204645.A28422@jurassic.park.msu.ru>
	 <20050606002739.GA943@erebor.esa.informatik.tu-darmstadt.de>
	 <20050606184335.A30338@jurassic.park.msu.ru>
	 <20050608173409.GA32004@erebor.esa.informatik.tu-darmstadt.de>
	 <20050609023639.A7067@jurassic.park.msu.ru>
Content-Type: text/plain
Date: Thu, 09 Jun 2005 14:04:10 +1000
Message-Id: <1118289850.6850.164.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-09 at 02:36 +0400, Ivan Kokshaysky wrote:
> On Wed, Jun 08, 2005 at 07:34:09PM +0200, Andreas Koch wrote:
> > However, after pci_assign_unassigned_resources() has been called, the
> > MEM and PREFETCH regions of the bridge 0000:00:1e.0 (bridge 1) _remain_
> > invalid at 0x00000000.
> 
> I believe it was _IO_ and PREFETCH (unused windows of that bridge).
> Indeed, IO at 0 is fatal...

Hrm... IO at 0 for a P2P bridge is perfectly valid, at least on a number
of architectures... However, testing for region.end < region.start is, I
suppose correct ...

Ben.


