Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264104AbTGGR6F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 13:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264203AbTGGR6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 13:58:05 -0400
Received: from george.he.net ([216.218.157.2]:33554 "EHLO george.he.net")
	by vger.kernel.org with ESMTP id S264104AbTGGR6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 13:58:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Lincoln D. Durey" <durey@EmperorLinux.com>
Reply-To: emperor@EmperorLinux.com
Organization: EmperorLinux
To: LKML <linux-kernel@vger.kernel.org>
Subject: Linux and IBM : "unauthorized" mini-PCI : Cisco mpi350 _way_ sub-optimal
Date: Mon, 7 Jul 2003 14:12:00 -0400
User-Agent: KMail/1.4.1
References: <1054658974.2382.4279.camel@tori> <20030610233519.GA2054@think>
In-Reply-To: <20030610233519.GA2054@think>
Cc: EmperorLinux Research <research@EmperorLinux.com>,
       "Theodore Ts'o" <tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200307071412.00625.durey@EmperorLinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ted,

This is an amazingly sub-optimal solution, and will make running Linux on the 
T40/X31 prohibitively difficult for most linux users.  Do you want everyone 
to use Linux?  Then tell IBM to let them use wifi cards that are easy to use, 
and support standard (and open) APIs.

(Ted)
> If the goal is simply to let a T40p laptop work with an internal
> wireless card, there is a solution that works today.  Simply use the
> Cisco MPI 350 mini-pci card instead, which *is* a supported card and
> works just fine with the T40p.

(my stock answer to the _many_ who have asked me:)
... so, in short yes, I'm supporting 802.11b wifi on T40 and X31 via the Cisco 
cards with backdated firmwares, and the Cisco ACU/bcard utils.

Of course this is _far_ from optimal, in that:

1) the Cisco cards must be setup by a closed-source app (then don't conform to 
the Linux wireless-tools API (Wireless Extension)).  Anyone here who has used 
"acu" and "bcard" can step in...

2) newer Cisco cards have firmwares _so_ new, you have to boot into _windows_ 
to flash then back to a linux-friendly firmware.  The new firmware (5th rev?) 
will lock the system on "modprobe mpi350", you need to get back to the 50003 
firmware.  Cisco cards with firmware ver. 50001, 50003, 50220, 52017 are all 
revertable in our testing.  (That is Linux can load mpi350.o, so you can use 
"acu" to backdate the firmware).  Cisco and IBM are both now shipping mpi350 
cards with a new firmware that causes the load of mpi350 to _lock_ the 
system.

3) the user of Linux on a T40 or X31 will not get any choice as to which WiFi 
card (s)he uses.  Cisco is the only way to go, and its a damn hard way.

4) 2+3 == So, some poor sap who got a T40, but wanted to hold off on the wifi, 
and he was dedicated enough to go 100% Linux, will be in a no-wifi-ever 
corner (since he can't flash the firmware ...) and can't go prism2...  Thanks 
IBM!

5) IBM's BIOS policy of not allowing wifi cards not on their "white list" to 
be in the system at boot time is a very bad thing for the Linux community.

(Ted)
> You can download the mpi350.c driver from the Cisco web page, and I
> was able to drop it into a 2.4 Linux kernel tree and build it.  For
> more details please see http://thunk.org/tytso/linux/t40.html.

And just for the record, yes mpi350 drops in easily, but watch out that you 
don't modprobe it with the newer firmwares, Also for the record, "ACU" 
totally sucks, and "bcard" is little better.

And all these nice Linux geeks aren't happy either:

(Jimmy Leung)
> Hello Lincoln, I found your posting on google regarding your T40 & wireless
> card conflict... I was curious if you were ever able to find a fix?  I am
> in somewhat the same dilemma.  I purchased 2 intel wireless minipci cards
> only to find my T40 refuses to boot up unless it's an true IBM option/Intel
> card or an IBM option/Cisco card.

("McKinney, Chuck")
> Did you ever find an answer for this problem.
> I just bought one of these cards for my T40 and I get the same error.

(David Louis Richmond @ Harvard)
> I saw your LKML posting [1][2] on the IBM T40 bios refusing to boot with
> "unauthorized" wifi minipci cards thanks to a google search; I'm
> experiencing precisely the same issue myself.

("Mike Hampele")
> Just reading your posts about the 1802 errors.
> Did you manage to get any workarounds to this?


	--  Lincoln @ EmperorLinux

