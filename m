Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265634AbRF1L2l>; Thu, 28 Jun 2001 07:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265635AbRF1L2c>; Thu, 28 Jun 2001 07:28:32 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:56325 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S265634AbRF1L2M>; Thu, 28 Jun 2001 07:28:12 -0400
Message-ID: <3B3B14AB.DF020611@idb.hist.no>
Date: Thu, 28 Jun 2001 13:27:39 +0200
From: Helge Hafting <helge.hafting@idb.hist.no>
X-Mailer: Mozilla 4.06 [en] (WinNT; I)
MIME-Version: 1.0
To: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: VM Requirement Document - v0.0
In-Reply-To: <3B399EF8.9BA76FA2@TeraPort.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Knoblauch wrote:

> 
>  maybe more specific: If the hit-rate is low and the cache is already
> 70+% of the systems memory, the chances maybe slim that more cache is
> going to improve the hit-rate.
> 
Oh, but this is posible.  You can get into situations where
the (file cache) working set needs 80% or so of memory
to get a near-perfect hitrate, and where
using 70% of memory will trash madly due to the file access
pattern.  And this won't be a problem either, if
the working set of "other" (non-file) 
stuff is below 20% of memory.  The total size of
non-file stuff may be above 20% though, so something goes
into swap.

I definitely want the machine to work under such circumstances,
so an arbitrary limit of 70% won't work.

Preventing swap-trashing at all cost doesn't help if the
machine loose to io-trashing instead.  Performance will be
just as much down, although perhaps more satisfying because
people aren't that surprised if explicit file operations
take a long time.  They hate it when moving the mouse
or something cause a disk access even if their
apps runs faster. :-(

Helge Hafting
