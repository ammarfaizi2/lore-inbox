Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261347AbSKBTrt>; Sat, 2 Nov 2002 14:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbSKBTrt>; Sat, 2 Nov 2002 14:47:49 -0500
Received: from pasky.ji.cz ([62.44.12.54]:9204 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S261347AbSKBTrr>;
	Sat, 2 Nov 2002 14:47:47 -0500
Date: Sat, 2 Nov 2002 20:57:31 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Andries.Brouwer@cwi.nl
Cc: marcelo@connectiva.com.br, hch@lst.de, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, viro@math.psu.edu
Subject: Re: [PATCH] [2.4.19] Extended /proc/partitions
Message-ID: <20021102195731.GA2535@pasky.ji.cz>
Mail-Followup-To: Andries.Brouwer@cwi.nl, marcelo@connectiva.com.br,
	hch@lst.de, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
	viro@math.psu.edu
References: <UTC200211021919.gA2JJMk20461.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200211021919.gA2JJMk20461.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sat, Nov 02, 2002 at 08:19:22PM CET, I got a letter,
where Andries.Brouwer@cwi.nl told me, that...
> (1) These ioctls are used by existing programs. So, for example,
> 	# hdparm -g /dev/hda5
> will give you the starting offset (in 512-byte sectors) of /dev/hda5.
> Even better may be a command like
> 	# blockdev --report
> 
> (2) Several programs, like mount, *fdisk, blockdev, read
> /proc/partitions. Changing the format will break all of these.
> So, it is best not to change anything, but if you do, only add
> fields at the end.
> 
..snip..
> 
> Given this uncertainty about what comes after the currently present
> fields, it is now impossible to add anything new, unless all programs
> using /proc/partitions also parse the header line.
> It is best to consider /proc/partitions frozen. Linux 2.5 has
> driverfs, and although "cat /proc/partitions" is much more convenient
> than searching around in driverfs (sysfs), no doubt blockdev will be
> changed so as to report on sysfs, when that exists and is mounted.

Ah.. I see, then please disregard the patches. Didn't realize that hdparm
already can do it nor that it's exported thru driverfs in 2.5, sorry.

-- 
 
				Petr "Pasky" Baudis
.
This host is a black hole at HTTP wavelengths. GETs go in, and nothing
comes out, not even Hawking radiation.
                -- Graaagh the Mighty on rec.games.roguelike.angband
.
Public PGP key && geekcode && homepage: http://pasky.ji.cz/~pasky/
