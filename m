Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262219AbTCRIE3>; Tue, 18 Mar 2003 03:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbTCRIE3>; Tue, 18 Mar 2003 03:04:29 -0500
Received: from verein.lst.de ([212.34.181.86]:9733 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S262219AbTCRIE2>;
	Tue, 18 Mar 2003 03:04:28 -0500
Date: Tue, 18 Mar 2003 09:15:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: CaT <cat@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, hch@lst.de,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.65
Message-ID: <20030318091516.A3491@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, CaT <cat@zip.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0303171429040.2827-100000@penguin.transmeta.com> <20030318052257.GB635@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030318052257.GB635@zip.com.au>; from cat@zip.com.au on Tue, Mar 18, 2003 at 04:22:57PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 04:22:57PM +1100, CaT wrote:
> One question. Should PCMCIA_AHA152X only be compilable as a module? I
> found this in Kconfig:
> 
> config PCMCIA_AHA152X
>         tristate "Adaptec AHA152X PCMCIA support"
>         depends on m
>         help
>           Say Y here if you intend to attach this type of PCMCIA SCSI host
>           adapter to your computer.
> 	  ...
> 
> The help and the tristate seems to indicate that I should be able to
> compile it into the kernel, but menuconfig wont let me. This is
> presumably due to the dependancy but is it right?

I think all pcmcia drivers currently are compilable only as module.
This was because historically they need cardmgr to work properly, but
someone is working on fixing that IIRC.

