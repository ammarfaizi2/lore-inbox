Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267628AbSLSK17>; Thu, 19 Dec 2002 05:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267629AbSLSK16>; Thu, 19 Dec 2002 05:27:58 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:39698
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267628AbSLSK15>; Thu, 19 Dec 2002 05:27:57 -0500
Date: Thu, 19 Dec 2002 02:19:47 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "D.A.M. Revok" <marvin@synapse.net>,
       Manish Lachwani <manish@Zambeel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133 
 Promise ctrlr, or...
In-Reply-To: <200212190951.gBJ9pCs28149@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.10.10212190217240.8350-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2002, Denis Vlasenko wrote:

> On 18 December 2002 20:38, Alan Cox wrote:
> > On Wed, 2002-12-18 at 21:35, D.A.M. Revok wrote:
> > > So.  I /think/ that somehow the Promise controller isn't being
> > > initialized properly by the Linux kernel, UNLESS the mobo's BIOS
> > > inits it first?
> >
> > In some situations yes. The BIOS does stuff including fixups we mere
> > mortals arent permitted to know about.
> 
> OTOH mere mortals are allowed to make full dump of PCI config ;)
> 
> "D.A.M. Revok" <marvin@synapse.net>, can you send lspci -vvvxxx
> outputs when you boot with BIOS enabled and BIOS disabled?

Promise knows this point.
Thus they moved the setting to a push/pull in the vendor space in the
dma_base+1 and dma_base+3 respectively.

lspci -vvvxxx fails when the content is located in bar4 io space.



Andre Hedrick
LAD Storage Consulting Group

