Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274628AbRIYLBU>; Tue, 25 Sep 2001 07:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274630AbRIYLBK>; Tue, 25 Sep 2001 07:01:10 -0400
Received: from hastur.andastra.de ([212.172.44.2]:42511 "HELO mail.andastra.de")
	by vger.kernel.org with SMTP id <S274628AbRIYLBD>;
	Tue, 25 Sep 2001 07:01:03 -0400
Date: Tue, 25 Sep 2001 13:01:46 +0200 (CEST)
From: <ben-lists@andastra.de>
To: <linux-kernel@vger.kernel.org>, <reiserfs-list@namesys.com>
Subject: Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
In-Reply-To: <20010925124440.B1390@emma1.emma.line.org>
Message-ID: <Pine.LNX.4.30L2.0109251251300.8383-100000@intra.andastra.priv>
X-Cthulu: HASTUR
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001, Matthias Andree wrote:
> > before doing the write. With the write cache enabled, several requests can
> > be placed into the drive buffer and written in the single revolution of
> > the drive.
>
> Might be an explanation. How big are the chunks of data that the
> kernel sends to the disk?

I would think that if you send enought data, the drive's cache would be
full and speed would drop to that of the data going to the disk itself. So
the drive must be able to write to the disk at the speed that the os sends
the data, even with write cache on. So maybe the speed difference is
caused by the protocol:  the system has to wait for the write to be ack'd
by the drive longer ( -> throughput goes down) when the write cache is
off.

/Benno

-- 
Sebastian Benoit <ben-lists@andastra.de>

