Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278722AbRKXQhH>; Sat, 24 Nov 2001 11:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278742AbRKXQgz>; Sat, 24 Nov 2001 11:36:55 -0500
Received: from vega.ipal.net ([206.97.148.120]:41909 "HELO vega.ipal.net")
	by vger.kernel.org with SMTP id <S278722AbRKXQgn>;
	Sat, 24 Nov 2001 11:36:43 -0500
Date: Sat, 24 Nov 2001 10:36:42 -0600
From: Phil Howard <phil-linux-kernel@ipal.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <20011124103642.A32278@vega.ipal.net>
In-Reply-To: <tgpu68gw34.fsf@mercury.rus.uni-stuttgart.de> <Pine.LNX.4.33L.0111241138070.4079-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0111241138070.4079-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 11:40:11AM -0200, Rik van Riel wrote:

| On 24 Nov 2001, Florian Weimer wrote:
| 
| > In the German computer community, a statement from IBM[1] is
| > circulating which describes a rather peculiar behavior of certain IBM
| > IDE hard drivers (the DTLA series):
| 
| That seems more like a case of "hard drives being pointless
| for people wanting to store their data" ;)

Or at least "powering down IBM DTLA series hard drives is pointless
for people wanting to store their data".

Now I can see a problem if the drive can't flush a write-back cache
during the "power fade".  With some pretty big caches many drives
have these days (although I wonder just how useful that is with OS
caches being as good as they are), the time it takes to flush could
be long (a few seconds ... and lights are out by then).  I sure hope
all my drives do write-through caching or don't cache writes at all.

I would think that as fast as these drives spin these days, they
could finish a sector between the time the power fade is detected
and the time the voltage is too low to have the correct write
current and servo speed.  Obviously one problem with lighter weight
platters is the momentum advantage is reduced for keeping the speed
right as the power is declining (if the speed is an issue, which I
am not sure of at all).


| The disks which _do_ store your data right also tend to work
| great with journaling; in fact, they tend to work better with
| journaling if you make a habit of crashing your system by
| hacking the kernel...

OOC, do you think there is any real advantage to the 1m to 4m cache
that drives have these days, considering the effective caching in
the OS that all OSes these days have ... over adding that much
memory to your system RAM?  The only use for caching I can see in
a drive is if it has physical sector sizes greater than the logical
sector write granularity size which would require a read-mod-write
kind of operation internally.  But that's not really "cache" anyway.


| The article you point to seems more like a "if you value your
| data, don't use IBM DTLA" thingy.

For now I use Maxtor for new servers.  Fortunately the IBM ones I
have are on UPS and not doing heavy write applications.

-- 
-----------------------------------------------------------------
| Phil Howard - KA9WGN |   Dallas   | http://linuxhomepage.com/ |
| phil-nospam@ipal.net | Texas, USA | http://phil.ipal.org/     |
-----------------------------------------------------------------
