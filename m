Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261338AbSJYJlL>; Fri, 25 Oct 2002 05:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261341AbSJYJlL>; Fri, 25 Oct 2002 05:41:11 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:43205 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261338AbSJYJlJ>; Fri, 25 Oct 2002 05:41:09 -0400
Subject: Re: [PATCH] [RFC] Advanced TCA SCSI Disk Hotswap
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steven Dake <sdake@mvista.com>
Cc: Greg KH <greg@kroah.com>, Scott Murray <scottm@somanetworks.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DB886B9.3060304@mvista.com>
References: <Pine.LNX.4.33L2.0210241350230.20950-100000@dragon.pdx.osdl.net>
	<Pine.LNX.4.33.0210241839490.10937-100000@rancor.yyz.somanetworks.com>
	<20021024232258.GA26093@kroah.com>  <3DB886B9.3060304@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Oct 2002 11:04:29 +0100
Message-Id: <1035540269.13032.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 00:48, Steven Dake wrote:
> Surprise extraction is not a simple problem especially to ensure the 
> device drivers exit
> cleanly without dumping more data on the PCI bus to a PCI device that 
> may not
> exist.

Thats primarily about resource handling orders. Making sure we don't
release the claimed pci resources in the driver until the driver itself
is sure it has shut up.

I'm doing suprise removal ok with the thinkpad 600 (in 2.4 with some
limits due to the 2.4 pci layer). Network stuff seems to be fine. The
block layer has major issues.

