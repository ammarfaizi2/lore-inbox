Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316538AbSIDXju>; Wed, 4 Sep 2002 19:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316541AbSIDXju>; Wed, 4 Sep 2002 19:39:50 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:17910
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316538AbSIDXjt>; Wed, 4 Sep 2002 19:39:49 -0400
Subject: RE: Problem on a kernel driver(SuSE, SMP)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Libershteyn, Vladimir" <vladimir.libershteyn@hp.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <8C18139EDEBC274AAD8F2671105F0E8E012704D7@cacexc02.americas.cpqcorp.net>
References: <8C18139EDEBC274AAD8F2671105F0E8E012704D7@cacexc02.americas.cpqcorp.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 05 Sep 2002 00:44:33 +0100
Message-Id: <1031183073.2796.149.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-04 at 18:56, Libershteyn, Vladimir wrote:

> 	//
> 	// sleep until data is ready
> 	//
> 	down_interruptible(&a->sem[enumerator]);

Suppose its interrupted. You dont check that and handle it..


> 	board_address = ((unsigned long *)((unsigned char *)a->vaddr + OutputQueueFilled));
> 	length = *board_address;

You can't poke around in memory directly either. Yes it works on x86 but
unless you use ioremap combined with readl and friends it wont work they
way you expect on ia64, x86-64, ...


