Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264746AbSKEJyw>; Tue, 5 Nov 2002 04:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264747AbSKEJyw>; Tue, 5 Nov 2002 04:54:52 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:42132 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264746AbSKEJyu>; Tue, 5 Nov 2002 04:54:50 -0500
Subject: Re: Troubles with Sony PCG-C1MHP (crusoe based and ALIM 1533
	drivers)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Manuel Serrano <Manuel.Serrano@sophia.inria.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cjtsai@ali.com.tw, Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <20021105090419.7c1282fa.Manuel.Serrano@sophia.inria.fr>
References: <20021104114912.7c1282fa.Manuel.Serrano@sophia.inria.fr>
	<1036414247.1113.3.camel@irongate.swansea.linux.org.uk> 
	<20021105090419.7c1282fa.Manuel.Serrano@sophia.inria.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Nov 2002 10:23:14 +0000
Message-Id: <1036491794.4827.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 08:20, Manuel Serrano wrote:
> I'm sorry to keep bothering all of you with this problem. I have tried
> a new version of the kernel (2.4.20-pre10-ac2) and I'm afraid that it does
> not fix the problem. I'm now able to compile and boot a kernel using the
> specific IDE driver but I'm still enable to enable the DMA on the disk.

This is all useful info


> ALI15X3: simplex device with no drives: DMA disabled
> ide0: ALI15X3 Bus-Master DMA disabled (BIOS)


You hit one of the other bugs the -ac code introduced - whoops. This one
is the main reason I've not yet pushed it to Marcelo. I still have to
fix the probing code so that we don't make a decision based upon what
drives are present before probing the drives

