Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbTIXUdX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 16:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbTIXUdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 16:33:22 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:32655 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S261468AbTIXUdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 16:33:21 -0400
Date: Wed, 24 Sep 2003 16:25:47 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Fixes for 2.6.0-test5
Message-ID: <20030924162547.GA25424@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <20030921200935.GB24897@neo.rr.com> <20030921201133.GE24897@neo.rr.com> <1064230334.8592.7.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064230334.8592.7.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 12:32:15PM +0100, Alan Cox wrote:
> On Sul, 2003-09-21 at 21:11, Adam Belay wrote:
> > # --------------------------------------------
> > # 03/09/21	ambx1@neo.rr.com	1.1357
> > # [PNP] remove DMA 0 restrictions
> > #
> > # The original argument for blocking DMA 0 was to avoid conflicts with
> > # "memory refresh"  but such configurations are only found on very old
> > # 8-bit systems that are likely not supported by the linux kernel.
>
> DMA0 is used by lots of 386/486 era systems for memory refresh. It is
> also "borrowed" by some other systems that know it isnt available to the
> OS. There are a couple of heuristics I've seen suggested by vendors of
> things like sound cards
>
> 1.	Check the PnPBIOS information (never looked into this myself)

Assuming the PnPBIOS provides this information through device nodes, the
current pnp code will ensure that dma 0 is not used.

> 2.	Assume DMA 0 is free if the machine has a PCI bus detected
> 3.	Read the DMA 0 counter a few times. If it is continually 	changing
> don't use DMA 0
>
> #2 is certainly a good idea IMHO, I don't know how well the others work.

Thanks, I'll look into these further.

Regards,
Adam
