Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267616AbSKSXxh>; Tue, 19 Nov 2002 18:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267614AbSKSXxg>; Tue, 19 Nov 2002 18:53:36 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:10624 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267616AbSKSXxf>; Tue, 19 Nov 2002 18:53:35 -0500
Subject: RE: Serverworks dma_intr: error=0x40 { UncorrectableError }
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Manish Lachwani <manish@Zambeel.com>
Cc: "'Steven Timm'" <timm@fnal.gov>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <233C89823A37714D95B1A891DE3BCE5202AB194C@xch-a.win.zambeel.com>
References: <233C89823A37714D95B1A891DE3BCE5202AB194C@xch-a.win.zambeel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Nov 2002 00:28:52 +0000
Message-Id: <1037752132.1353.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-19 at 21:59, Manish Lachwani wrote:
> ALso, we had been using TYAN S2518 with OSB4 in UDMA 2. However, it causes
> data corruption when there is IO with even one drive. We used two drives in
> master-master and master-slave mode and it did not solve the problem. EVen
> at UDMA 0, we experienced the same issue of data corruption. Once does not
> need to have 0x40 errors to see this corruption. If you want to see this
> corruption, use the dt utility and then run:

Known. The newer kernels will panic in this case to avoid corrupting,
and the 2.4.20-ac/2.5.4x kernels will not use UDMA for disks on OSB4.
The newer serverworks (CSB5/CSB6) doesn't have this problem btw

