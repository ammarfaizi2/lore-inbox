Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266271AbSLNCzh>; Fri, 13 Dec 2002 21:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266409AbSLNCzh>; Fri, 13 Dec 2002 21:55:37 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:51152
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266271AbSLNCzg>; Fri, 13 Dec 2002 21:55:36 -0500
Subject: Re: DMA from SCSI controller to PCI frame buffer memory.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jason Howard <lists@spectsoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1039806910.21196.29.camel@bmagic.spectsoft.com>
References: <1039806910.21196.29.camel@bmagic.spectsoft.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Dec 2002 03:41:52 +0000
Message-Id: <1039837312.25121.115.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-13 at 19:15, Jason Howard wrote:
> Hello All,
> 
> I am wondering if the functionality exists in the Linux kernel to DMA 
> from a SCSI controller directly into frame buffer memory of a PCI video
> card?  Is there a standard method for this (similar to sendfile) or will
> it require some hacking?

In theory you can mmap the frame buffer memory, then do O_DIRECT I/O
into it. In practice it will buffer (I hope it still does). One of the
problems is that there are huge lists of PCI->AGP DMA errata in
chipsets.

