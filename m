Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVEQNgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVEQNgQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 09:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVEQNgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 09:36:15 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:31173 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261155AbVEQNgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 09:36:06 -0400
Date: Tue, 17 May 2005 09:36:06 -0400
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sync option destroys flash!
Message-ID: <20050517133606.GD23621@csclub.uwaterloo.ca>
References: <20050514024346.18045.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050514024346.18045.qmail@science.horizon.com>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2005 at 02:43:46AM -0000, linux@horizon.com wrote:
> Alan the Hirsute spake unto the masses:
> > All non-shite quality flash keys have an on media log structured file
> > system and will take 100,000+ writes per sector or so. They decent ones
> > also map out bad blocks and have spares. The "wear out the same sector"
> > stuff is a myth except on ultra-crap devices.
> 
> I would have though so, but I can say from personal experience that
> SanDisk brand CF cards respond to losing power during a write by producing
> a bad sector.  I had assumed that a sensible implementation would take
> advantage of the out-of-place writing by doing a two-phase commit at
> write time, so writes would be atomic.

It can also respond to loosing power during write by getting it's state
so mixed up the whole card is dead (it identifies but all sectors fail
to read).  The binary industrial grade CF cards (no longer in
production) had capacitors to be able to finish writing the block they
were doing to prevent problems.  Supposedly their new firmware now will
have a rollback system so that any partial write is just added back to
the free pool.  I had thought this was always how they did it, but no
apparently that is also something new.

> Does anyone know of a CF manufacturer that *does* guarantee atomic writes?
> Obviously, if power is lost during a write, it's not clear whether
> I'll get the old or the new contents, but I want one or ther other and
> not -EIO.

We were told by SanDisk when we asked about a dead card (it had power
loss during a write) and was told that is normal for the regular
multicell flash cards.  They told us the firmware in the generation of
cards they are currently launching does not have a problem with that
anymore since it essentially journals the writes and can roll back a
partial block write.  I imagine they have patents on that too along with
lots of other flash technology.  Unfortunately their next generation
cards aren't -40 to +85C operation so although everything else was
perfect about them, they are of no use to us.

> Given that SanDisk first developed the CompactFlash card, you'd think they'd
> be a fairly reputable brand...

Well they seem to finally be getting those features working as people
have expected them to work.

Len Sorensen
