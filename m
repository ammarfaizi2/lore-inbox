Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267696AbTAaDMO>; Thu, 30 Jan 2003 22:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267697AbTAaDMN>; Thu, 30 Jan 2003 22:12:13 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:7558 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267696AbTAaDMN>;
	Thu, 30 Jan 2003 22:12:13 -0500
Date: Thu, 30 Jan 2003 22:24:01 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Jaroslav Kysela <perex@perex.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [alsa, pnp] more on opl3sa2 (fwd)
Message-ID: <20030130222401.GH2246@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
References: <20030129221234.GC2246@neo.rr.com> <Pine.LNX.4.44.0301300940090.1445-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301300940090.1445-100000@pnote.perex-int.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaroslav,

How does this sound...

What if we make pnp card services match against all pnp cards and allow more
than one card driver to use the same card.  This can be accomplished if we detach
the card portion from the driver model and use driver_attach.  If you feel it is
necessary, we could also add an optional card id to the pnp_device_id structure.
As for the pnpbios, I disagree with putting it under one card.  If the pnpbios
contains two opl3sa2 sound cards then only one will be matched and therefore it
is a bad idea to represent the pnpbios as a card.  When ACPI is introduced, both
pnpbios and ACPI will be cardless protocols.  Therefore I think it is best to 
use the pnp_driver structure instead of the pnpc_driver structure in the
opl3sa2 ALSA driver.

Any aditional comments?

Regards,
Adam
