Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268902AbUJKMqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268902AbUJKMqg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 08:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268899AbUJKMp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 08:45:26 -0400
Received: from linaeum.absolutedigital.net ([63.87.232.45]:64935 "EHLO
	linaeum.absolutedigital.net") by vger.kernel.org with ESMTP
	id S268902AbUJKMm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 08:42:57 -0400
Date: Mon, 11 Oct 2004 08:42:52 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: David Gibson <hermes@gibson.dropbear.id.au>
cc: Ricky lloyd <ricky.lloyd@gmail.com>, Jan Dittmer <j.dittmer@portrix.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       NetDev Mailing List <netdev@oss.sgi.com>, proski@gnu.org
Subject: Re: [PATCH] Fix readw/writew warnings in drivers/net/wireless/hermes.h
In-Reply-To: <20041011123137.GB28100@zax>
Message-ID: <Pine.LNX.4.61.0410110835330.8480@linaeum.absolutedigital.net>
References: <Pine.LNX.4.61.0410110702590.7899@linaeum.absolutedigital.net>
 <416A7484.1030703@portrix.net> <1a50bd3704101105046e66538c@mail.gmail.com>
 <20041011123137.GB28100@zax>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2004, David Gibson wrote:

> On Mon, Oct 11, 2004 at 05:34:20PM +0530, Ricky lloyd wrote:
> > > Isn't the correct fix to declare iobase as (void __iomem *) ?
> > > 
> > 
> > Earlier today i had posted a patch which mainly fixes this same
> > problem with lotsa scsi
> > drivers and tulip drivers. I wondered the same "shouldnt all the addrs
> > be declared as
> > void __iomem* ??". 
> 
> The trouble with that is that for some versions of the orinoco card,
> the iobase refers to a legacy ISA IO address, not a memory-mapped IO
> address (that's the inw()/outw() path in the macro).  That needs an
> integer, rather than a pointer.
> 
> It's not clear to me which way around the cast is less ugly.

I guess the cast is kludgy. I just wanted to shut the warnings up, it 
prints 68 of 'em I believe.

-- Cal

