Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263228AbTANPV2>; Tue, 14 Jan 2003 10:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263544AbTANPV2>; Tue, 14 Jan 2003 10:21:28 -0500
Received: from host194.steeleye.com ([66.206.164.34]:57863 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S263228AbTANPV1>; Tue, 14 Jan 2003 10:21:27 -0500
Message-Id: <200301141530.h0EFUGH02371@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "David S. Miller" <davem@redhat.com>
cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Subject: Re: [BK-2.5] Update the generic DMA API to take GFP_ flags on
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Jan 2003 10:30:15 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What about platforms that can only use GFP_ATOMIC due to
> implementation side issues?  Is that "OK"?

Yes.

A GFP_KERNEL request is safely implemented as GFP_ATOMIC as long as the caller 
checks return for NULL.  for dma_alloc_coherent return checking is a 
requirement because the system may return NULL anyway if it is out of mappings 
even with a GFP_KERNEL flag.

James


