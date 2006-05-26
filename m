Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbWEZQHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWEZQHM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 12:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWEZQHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 12:07:11 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.26]:36393 "EHLO smtp5.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1750958AbWEZQHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 12:07:09 -0400
X-ME-UUID: 20060526160707813.C68961C00214@mwinf0512.wanadoo.fr
Date: Fri, 26 May 2006 18:01:56 +0200
To: Mark Lord <liml@rtr.ca>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Jeff Garzik <jgarzik@pobox.com>,
       Alexandre.Bounine@tundra.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>,
       Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
Subject: Re: [PATCH/2.6.17-rc4 10/10]  bugs fix for marvell SATA on powerp c pl atform
Message-ID: <20060526160156.GA11778@powerlinux.fr>
References: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net> <1147935734.17679.93.camel@localhost.localdomain> <446C9219.4080300@pobox.com> <446CDE26.8090504@rtr.ca> <20060526083931.GA23938@powerlinux.fr> <4476E964.90509@rtr.ca> <20060526114245.GA32330@powerlinux.fr> <44770065.8070907@rtr.ca> <20060526141535.GA7084@powerlinux.fr> <447722FF.9020202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447722FF.9020202@rtr.ca>
User-Agent: Mutt/1.5.9i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 11:47:11AM -0400, Mark Lord wrote:
> Sven Luther wrote:
> >On Fri, May 26, 2006 at 09:19:33AM -0400, Mark Lord wrote:
> >>Sven Luther wrote:
> >>>Ok. can i use this tree with a 2.6.16 base ?
> >>Not as-is.  Here (attached) is a patch for 2.6.16.17+ that updates
> >>the sata_mv driver to the latest source.  Completely untested,
> >>but it does compile.
> >>
> >>I will hopefully test it later today, but in the meanwhile, have a go at 
> >>it.
> >
> >And here is attached my dmesg output. The last bit of mv_host_intr was 
> >when i
> >tried to access the partition table of the disk with parted.
> 
> I don't see anything particularly bad in that dmesg output,
> apart from all of the debug output --> did you enable that,
> or was it "on" by default?

Ah, yes, i enabled it on Jeff's suggestion.

> It finds one SATA drive, with no *known* partition table format.

Well, it is a blank disk indeed, so this is no suprise.

> Can you access the disk?  Eg.  hexdump -C /dev/sda

Trying to partition the disk with parted yielded the last set of debug
messages, and a : 

Error: Unable to open /dev/sda - unrecognized disk label.

The same when trying to write a partition table to it, and naturally, there is
no partition afterward.

hexdump yielded only the debugmessages and nothing else.

> Meanwhile, I just booted 2.6.17-rc5-git1 (latest kernel.org) on my Mac G3
> box here, and sata_mv seems to be behaving for me (thus far).

Mmm, this is a G3, while i have a G4. The G4 does some I/O reordering, which
we don't have with a G3, so this may be the cause. 

Do you have a mac version of the board, with a forth/OF bios in it ? Or a
normal PC card, which is thus uninitialized ? 

Friendly,

Sven Luther

