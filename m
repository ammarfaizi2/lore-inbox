Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268429AbTAMXhX>; Mon, 13 Jan 2003 18:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268430AbTAMXhX>; Mon, 13 Jan 2003 18:37:23 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:19073 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S268429AbTAMXhW>;
	Mon, 13 Jan 2003 18:37:22 -0500
Date: Mon, 13 Jan 2003 18:48:48 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: "Ruslan U. Zakirov" <cubic@miee.ru>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org,
       perex@suse.cz
Subject: Re: 2.5.57 missing isapnp_card_protocol
Message-ID: <20030113184848.GC605@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	"Ruslan U. Zakirov" <cubic@miee.ru>,
	"Adam J. Richter" <adam@yggdrasil.com>,
	linux-kernel@vger.kernel.org, perex@suse.cz
References: <20030113224028.GB13531@gtf.org> <Pine.BSF.4.05.10301140159310.36033-100000@wildrose.miee.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.05.10301140159310.36033-100000@wildrose.miee.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 02:10:41AM +0300, Ruslan U. Zakirov wrote:
> On Mon, 13 Jan 2003, Jeff Garzik wrote:
> 
> > On Mon, Jan 13, 2003 at 02:09:49PM -0800, Adam J. Richter wrote:
> > > 	Linux-2.5.57 deletes the definition of isapnp_card_protocol
> > > and then adds some references to it.  So, the kernel does not link
> > > if you have enabled ISA PnP support.  I'm not sure whether
> > > isapnp_card_protocol is supposed to be removed or not.
> > 
> > That's the fault of some random driver that hasn't been updated to the
> > new isapnp API yet...
> 
> Hello.
> It's not right.
> It's wrong changes in drivers/pnp/isapnp/core.c and could be fixed with
> changing of two lines:
> drop 
> 	protocol_for_each_card(&isapnp_card_protocol,card)
> and change
> 	protocol_for_each_card(&isapnp_card_protocol,card)
> back to 
> 	protocol_for_each_card(&isapnp_protocol,card) 
> This changes fix compilation problems, but may be it wrong do it in this
> way.
> 
> Best regards.
> 	Ruslan.
> 

Hi Ruslan,

This is indeed a correct fix for this problem.  This bug was not introduced
by me but I appreciate your input.

Thanks,
Adam
