Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312381AbSCYJ73>; Mon, 25 Mar 2002 04:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312382AbSCYJ7T>; Mon, 25 Mar 2002 04:59:19 -0500
Received: from CPE-203-51-26-136.nsw.bigpond.net.au ([203.51.26.136]:31483
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S312381AbSCYJ7J>; Mon, 25 Mar 2002 04:59:09 -0500
Message-ID: <3C9EF4D9.CB21F3B1@eyal.emu.id.au>
Date: Mon, 25 Mar 2002 20:58:49 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre3-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18: many IDE errors
In-Reply-To: <Pine.LNX.4.10.10203240014430.2377-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reported CRC errors, intermittently, on all six IDE disks, each
a master on a separate cable.

Andre Hedrick wrote:
> It is not a case of bad cables but maybe cable routing.
> Also, four 160GB disks eat power!

I reorganized the cables so that each takes a differnt path from the
mobo to the disk. I still see errors, so far on hda. I will see if
the rate is really reduced.

> I have a box dual athlon similar setup w/ 460W ps
> I have to wait for the PS to warm up or there is not enough juice to
> properly spin up the last drive.  However if I replace the four 160GB's
> with four 20GB Seagate's no problem.

I do not have spinup problems. Neither does the computer :-)

> You are going to need at least a 400W PS w/ almost no ripple to make it
> work.  If you have this then check the cable routing.

The new PS should do it then.

> Also hdparm -i /dev/hdX to see if their transfer rates are reduced.

OK, I checked, and after a bus reset the disk in error was dropped
from udma5 to udma4. I did not see more errors after that (but the
setup is up for less than one day so far). I plan to push it hard
tomorrow.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
