Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278658AbRJSU5s>; Fri, 19 Oct 2001 16:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278660AbRJSU5i>; Fri, 19 Oct 2001 16:57:38 -0400
Received: from a1as17-p73.stg.tli.de ([195.252.193.73]:49638 "EHLO
	dea.linux-mips.net") by vger.kernel.org with ESMTP
	id <S278658AbRJSU5a>; Fri, 19 Oct 2001 16:57:30 -0400
Date: Fri, 19 Oct 2001 22:57:45 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: pci_alloc_consistent question
Message-ID: <20011019225745.B28818@dea.linux-mips.net>
In-Reply-To: <01A7DAF31F93D511AEE300D0B706ED9208E4A1@axcs13.cos.agilent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01A7DAF31F93D511AEE300D0B706ED9208E4A1@axcs13.cos.agilent.com>; from hiren_mehta@agilent.com on Fri, Oct 19, 2001 at 12:32:19PM -0600
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2001 at 12:32:19PM -0600, MEHTA,HIREN (A-SanJose,ex1) wrote:

> Is there any limitation on the amount of contiguous dmaable memory that
> can be allocated using a single call to pci_alloc_consistent() ?

Entirely platform dependant.  On some systems the total available DMA memory
for DMA may be as limited as 1mb, others have limits like 16mb yet other can
support the entire 32-bit address space for DMA.  So in case of doubt be
conservative.

  Ralf
