Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262326AbSL2X4m>; Sun, 29 Dec 2002 18:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262380AbSL2X4m>; Sun, 29 Dec 2002 18:56:42 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:7296
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262326AbSL2X4l>; Sun, 29 Dec 2002 18:56:41 -0500
Subject: Re:  [RFT][PATCH] generic device DMA implementation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: manfred@colorfulllife.com, dvaid-b@pacbell.net,
       James.Bottomley@steeleye.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200212280339.TAA25950@adam.yggdrasil.com>
References: <200212280339.TAA25950@adam.yggdrasil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Dec 2002 00:45:54 +0000
Message-Id: <1041209155.1215.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-12-28 at 03:39, Adam J. Richter wrote:
> 	I know Documentation/DMA-mapping.txt says that, and I
> understand that wmb() is necessary with consistent memory, but I
> wonder if rmb() really is, at least if you've declared the data
> structures in question as volatile to prevent reordering of reads by
> the compiler.

Compiler ordering != Processor to memory ordering != PCI device view
ordering

volatile may not be enough.

Alan

