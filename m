Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268386AbTAMXCM>; Mon, 13 Jan 2003 18:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268383AbTAMXCM>; Mon, 13 Jan 2003 18:02:12 -0500
Received: from [213.171.53.133] ([213.171.53.133]:50959 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S268371AbTAMXCL>;
	Mon, 13 Jan 2003 18:02:11 -0500
Date: Tue, 14 Jan 2003 02:10:41 +0300 (MSK)
From: "Ruslan U. Zakirov" <cubic@miee.ru>
To: Jeff Garzik <jgarzik@pobox.com>
cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org,
       perex@suse.cz, ambx1@neo.rr.co
Subject: Re: 2.5.57 missing isapnp_card_protocol
In-Reply-To: <20030113224028.GB13531@gtf.org>
Message-ID: <Pine.BSF.4.05.10301140159310.36033-100000@wildrose.miee.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003, Jeff Garzik wrote:

> On Mon, Jan 13, 2003 at 02:09:49PM -0800, Adam J. Richter wrote:
> > 	Linux-2.5.57 deletes the definition of isapnp_card_protocol
> > and then adds some references to it.  So, the kernel does not link
> > if you have enabled ISA PnP support.  I'm not sure whether
> > isapnp_card_protocol is supposed to be removed or not.
> 
> That's the fault of some random driver that hasn't been updated to the
> new isapnp API yet...

Hello.
It's not right.
It's wrong changes in drivers/pnp/isapnp/core.c and could be fixed with
changing of two lines:
drop 
	protocol_for_each_card(&isapnp_card_protocol,card)
and change
	protocol_for_each_card(&isapnp_card_protocol,card)
back to 
	protocol_for_each_card(&isapnp_protocol,card) 
This changes fix compilation problems, but may be it wrong do it in this
way.

Best regards.
	Ruslan.

