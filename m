Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267633AbSLSKnu>; Thu, 19 Dec 2002 05:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267634AbSLSKnt>; Thu, 19 Dec 2002 05:43:49 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:41746
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267633AbSLSKns>; Thu, 19 Dec 2002 05:43:48 -0500
Date: Thu, 19 Dec 2002 02:33:40 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "D.A.M. Revok" <marvin@synapse.net>,
       Manish Lachwani <manish@Zambeel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133 
 Promise ctrlr, or...
In-Reply-To: <200212191024.gBJAOqs28377@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.10.10212190229580.8350-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2002, Denis Vlasenko wrote:

> On 19 December 2002 08:19, Andre Hedrick wrote:
> > Promise knows this point.
> > Thus they moved the setting to a push/pull in the vendor space in the
> > dma_base+1 and dma_base+3 respectively.
> > lspci -vvvxxx fails when the content is located in bar4 io space.
> 
> Neither I nor original bug reporter (I think) did understand
> a bit what you said. Can we plead for IDE -> English translation?
> ;)
> If lspci is of no help, what can we use instead?

They move the setting which were readable in the asic from PCI space in
the 20246/47/62/65/67 into a sense mode of the asic sniffing the contents
of the taskfile registers to internally do the same thing but hide it all.

The new 20268/69/7* report all zeros in the PCI space.

ioperm()

But be prepared to roast your data.

I do not have a good answer!

Andre Hedrick
LAD Storage Consulting Group

