Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267337AbSKPS5e>; Sat, 16 Nov 2002 13:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267338AbSKPS5e>; Sat, 16 Nov 2002 13:57:34 -0500
Received: from waste.org ([209.173.204.2]:4993 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S267337AbSKPS5d>;
	Sat, 16 Nov 2002 13:57:33 -0500
Date: Sat, 16 Nov 2002 13:04:29 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lan based kgdb
Message-ID: <20021116190429.GI19061@waste.org>
References: <20021116182454.GH19061@waste.org> <Pine.LNX.4.44.0211161025500.15838-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211161025500.15838-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2002 at 10:33:57AM -0800, Linus Torvalds wrote:
> 
> On Sat, 16 Nov 2002, Oliver Xymoron wrote:
> > 
> > LAN latencies should be low enough that waiting on an ACK for each
> > packet will do just fine for error correction. If someone wants to do
> > remote debugging, they can ssh into a debugging machine on the same LAN.
> 
> I agree in theory on a technical level, yet at the same time it's clearly
> advantageous _not_ to wait, since it would allow you to just universally
> enable the LAN as the console on all your machines when you maintain them,
> and then not have that LAN console be a maintenance problem.

Definitely agreed on the usefulness of LAN console. Being able to just
run netcat for all the boxes in your datacenter is a huge win. Cuts
your cable count by a third to a half and eliminates a bunch of term
servers and KVMs.

Other folks have pointed out that the GDB stub protocol includes
checksumming and retries up at the 'application' layer so we don't
actually have to worry about it.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
