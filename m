Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262715AbTEFMxn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 08:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbTEFMxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 08:53:43 -0400
Received: from ns.suse.de ([213.95.15.193]:15119 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262715AbTEFMxl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 08:53:41 -0400
Date: Tue, 6 May 2003 15:06:12 +0200
From: Karsten Keil <kkeil@suse.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, kai@tp1.ruhr-uni-bochum.de,
       linux-kernel@vger.kernel.org
Subject: Re: ISDN massive packet drops while DVD burn/verify
Message-ID: <20030506130612.GB6545@pingi3.kke.suse.de>
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, kai@tp1.ruhr-uni-bochum.de,
	linux-kernel@vger.kernel.org
References: <20030416151221.71d099ba.skraw@ithnet.com> <Pine.LNX.4.44.0304161056430.5477-100000@chaos.physics.uiowa.edu> <20030419193848.0811bd90.skraw@ithnet.com> <1050789691.3955.17.camel@dhcp22.swansea.linux.org.uk> <20030505164653.GA30015@pingi3.kke.suse.de> <20030505192652.7f17ea9e.skraw@ithnet.com> <1052218412.28797.18.camel@dhcp22.swansea.linux.org.uk> <20030506143902.2b3fcecd.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506143902.2b3fcecd.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Organization: SuSE Linux AG
X-Operating-System: Linux 2.4.20-4GB i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 02:39:02PM +0200, Stephan von Krawczynski wrote:
> On 06 May 2003 11:53:32 +0100
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > On Llu, 2003-05-05 at 18:26, Stephan von Krawczynski wrote:
> > > You mean UDMA 2 does not make it (which I had in the test case)?
> > 
> > But is the transfer being done in UDMA mode ?
> 
> 
> # hdparm -v /dev/hdc
> 
> /dev/hdc:
>  HDIO_GET_MULTCOUNT failed: Invalid argument
>  IO_support   =  0 (default 16-bit)
>  unmaskirq    =  0 (off)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  readonly     =  0 (off)
>  BLKRAGET failed: Invalid argument
>  HDIO_GETGEO failed: Invalid argument
>  
> 
> using_dma means it's using dma for transfer, right?
> 

It should, but so far I know it cannot do every thing with
dma.
My writer use:

pingi2:~ # hdparm -v /dev/hdc

/dev/hdc:
 HDIO_GET_MULTCOUNT failed: Input/output error
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 BLKRAGET failed: Input/output error
 HDIO_GETGEO failed: Invalid argument

And I see no problems.

At least you can try hdparm -u1 (use a RW media).

-- 
Karsten Keil
SuSE Labs
ISDN development
