Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279814AbRKILR4>; Fri, 9 Nov 2001 06:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279824AbRKILRr>; Fri, 9 Nov 2001 06:17:47 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:26892 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S279813AbRKILRg>; Fri, 9 Nov 2001 06:17:36 -0500
Message-ID: <3BEBBB21.357149FC@idb.hist.no>
Date: Fri, 09 Nov 2001 12:16:49 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.15-pre1 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
In-Reply-To: <Pine.LNX.4.33.0111081802380.15975-100000@localhost.localdomain.suse.lists.linux.kernel>
		<Pine.LNX.4.33.0111081836080.15975-100000@localhost.localdomain.suse.lists.linux.kernel>
		<p731yj8kgvw.fsf@amdsim2.suse.de> <20011109141215.08d33c96.rusty@rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:

> Modules have lots of little disadvantages that add up.  The speed penalty
> on various platforms is one, the load/unload race complexity is another.
> 
Races can be fixed.  (Isn't that one of the things considered for 2.5?)

Speed penalties on various platforms is there to stay, so you simply
have to weigh that against having more swappable RAM.

I use the following rules of thumb:

1. Modules only for seldom-used devices.  A module for
   the mouse is no use if you do all your work in X.  
   There's simply no gain from a module that never unloads.
   A seldom used fs may be modular though.  I rarely
   use cd's, so isofs is a module on my machine.
2. No modules for high-speed stuff like harddisks and network,
   that's where you might feel the slowdown.  Low-speed stuff
   like floppy and cdrom drivers are modular though.

Helge Hafting
