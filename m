Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTGARku (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 13:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTGARku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 13:40:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25615 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263179AbTGARkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 13:40:49 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode
Date: 1 Jul 2003 10:54:31 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bdshsn$8n2$1@cesium.transmeta.com>
References: <1057077975.2135.54.camel@mulgrave> <20030701190938.2332f0a8.ak@suse.de> <1057080529.2003.62.camel@mulgrave>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1057080529.2003.62.camel@mulgrave>
By author:    James Bottomley <James.Bottomley@steeleye.com>
In newsgroup: linux.dev.kernel
> 
> The name was simply to be consistent with BIO_VMERGE_BOUNDARY which is
> another asm/io.h setting for this.
> 
> Could you elaborate more on the amd64 IOMMU window.  Is this a window
> where IOMMU mapping always takes place?
> 

It's a window (in the form of a BAR - base and mask) within which
IOMMU mapping always takes place.  Outside the window everything is
bypass.

This applies to all x86-64 machines and some i386 machines, in
particular those i386 chipsets with "full GART" support as opposed to
"AGP only GART" (my terminology.)

Andi likes to say this isn't a real IOMMU (mostly because it doesn't
solve the legacy region problem), but I disagree with that view.  It
still would be nicer if it covered more address space, though.

I don't know if it would be worthwhile to support "full GART" on the
i386 systems which support it.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
