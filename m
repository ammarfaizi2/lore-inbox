Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWH1IPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWH1IPJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 04:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWH1IPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 04:15:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17116 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751421AbWH1IPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 04:15:08 -0400
Subject: Re: [2.6.17.11] strange pcie errors/warnings on Abit KN9-SLI
	mainboard
From: Arjan van de Ven <arjan@infradead.org>
To: Jan De Luyck <ml_linuxkernel_20060528@kcore.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200608280755.56015.ml_linuxkernel_20060528@kcore.org>
References: <200608280755.56015.ml_linuxkernel_20060528@kcore.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 28 Aug 2006 10:14:57 +0200
Message-Id: <1156752897.3034.163.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-28 at 07:55 +0200, Jan De Luyck wrote:
> Hello,
> 
> (running 2.6.17.11 vanilla on Debian SID)
> 
> I recently acquired a new pc, with an ABIT KN9-SLI mainboard, using an AMD64x2 
> AM2 processor.
> 
> System boots fine, but I have some messages/errors in the dmesg that I'm worried 
> about. Googling around for them didn't really show up much.
> 
> First:
> 
> Aug 27 15:35:04 whocares kernel: PCI-DMA: Disabling IOMMU.
> 
> IOMMU is (as far as I can see) enabled:
> whocares:/var/log# cat /usr/src/build/linux-2.6/.config | grep IOMMU
> CONFIG_GART_IOMMU=y
> 
> I can't really determine if this is normal. According to the code it seems that 
> this is disabled by default when you don't have AGP? (I'm not a kernel-coder, so 
> I may be very wrong on this)

Hi,

unless you have >= 4Gb of ram you don't need an IOMMU (in fact using it
would only cause extra overhead)... so the kernel will not use it in
that case.

Greetings,
   Arjan van de Ven

