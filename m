Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281586AbRKMKeH>; Tue, 13 Nov 2001 05:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281587AbRKMKd5>; Tue, 13 Nov 2001 05:33:57 -0500
Received: from sunfish.linuxis.net ([64.71.162.66]:18338 "HELO
	sunfish.linuxis.net") by vger.kernel.org with SMTP
	id <S281586AbRKMKdr>; Tue, 13 Nov 2001 05:33:47 -0500
From: "Adam McKenna" <adam-dated-1006079431.a988a6@flounder.net>
Date: Tue, 13 Nov 2001 02:30:29 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DMA problem (?) w/ 2.4.6-xfs and ServerWorks OSB4 Chipset
Message-ID: <20011113023029.A15075@flounder.net>
In-Reply-To: <20011112234604.C29675@flounder.net> <E163aDx-0000aQ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E163aDx-0000aQ-00@the-village.bc.nu>
User-Agent: Mutt/1.3.21i
Mail-Copies-To: never
X-Delivery-Agent: TMDA v0.32/Python 2.1.1 (sunos5)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2001 at 09:51:21AM +0000, Alan Cox wrote:
> > I ask because I'm still having major problems with the OSB4 chipset on
> > 2.4.14.  I've had to disable DMA completely on my boxes to avoid IDE errors
> > and fs corruption.  Does anyone know of a patch that addresses the issues
> > with this chipset?
> 
> No. I spent some time digging into this problem with both Serverworks and
> Red Hat customers. With certain disks, certain OSB4 revisions and UDMA 
> the controller occasionally gets "stuck", the next DMA it issues starts
> by reissuing the last 4 bytes of the previous request and the entire thing
> goes totally to crap.
> 
> The -ac tree will detect this case and panic and hang the machine solid to
> avoid actual disk corruption. The real fix appears to be "dont do UDMA on
> the OSB4". The CSB5 seems fine.

I am having problems with both UDMA and Multiword DMA.  The problem doesn't
go away unless I disable CONFIG_IDEDMA_PCI_AUTO.

I don't know if there is actual FS corruption with MWord DMA, but there is
definitely a "hang" for a few seconds accompanied by a DMA error.

--Adam

-- 
Adam McKenna <adam@flounder.net>   | GPG: 17A4 11F7 5E7E C2E7 08AA
http://flounder.net/publickey.html |      38B0 05D0 8BF7 2C6D 110A
