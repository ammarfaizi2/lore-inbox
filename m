Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287946AbSACBGE>; Wed, 2 Jan 2002 20:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287915AbSACBF4>; Wed, 2 Jan 2002 20:05:56 -0500
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:42184 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S288046AbSACBFq>; Wed, 2 Jan 2002 20:05:46 -0500
Date: Thu, 03 Jan 2002 01:04:11 UTC
From: Bill <billnvd@hotpop.com>
Subject: Slowdowns and Systems Pauses with 2.4.x.
To: linux-kernel@vger.kernel.org
Message-ID: <TradeClient.0.9.0.Linux-2.4.7.020102190411FFFFFFFC.1007@gx100.localhost.localdomain>
Organization: 
X-Mailer: TradeClient 0.9.0 [en] Linux 2.4.7
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
Importance: Normal
X-Accept-Language: en
Sensitivity: Public-Document
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have seen a lot of reports about 2.4.x having all sorts of slowdowns
and VM issues.  While way out of my league here, I wanted to comment on
some good behavior I noticed.  During my most recent recompile of 2.4.7,
my system performance went way up.  Responsiveness is excellent nearly
regardless of what I throw at it.  I am no programmer and I am not sure
if any information I can provide would be useful to anyone, but I would
be willing to offer whatever I can to aid kernel hackers in tracking
down what seems to be hitting a lot of people with 2.4.x.

System: Dell GX100
566 Celeron w/192meg, 184meg swap
ATA66 10gig WD 102BB (ext2fs)
ATAPI CDROM (not sure of brand)
onboard i810 4meg agp
onboard 3com905c
ES 1371

Linux version 2.4.7(no patches), (gcc version 2.95.3 19991030
(prerelease))
XFree86 4.0.1, IceWM 1.0.4. 

This compile was with no module support(first time I tried it that way)
and no devfs.  I really don't know what information to supply without
posting huge amounts of potentially worthless data, but let me give an
example of the responsiveness.

Simultaneous user processes:
cp a 675meg file to new dir in xterm(bash),
ftp to remote system via ethernet averaging about 4MB/s, file size
>600meg,
accept incoming ftp using inetd/wuftpd via ethernet averaging about
4MB/s, file size > 600meg,
edge enhance a 5000 x 4000 jpg with gimp
xmms playing ogg files
cdparanoia ripping cd at 1x (the rip was successful)
Opera and Netscape both up with lkml archives, several pages each.
licq online
tradeclient email - retrieving from 3 servers
launched a second gimp and opened a 400x400 jpg

and finally ogg encoder kicked in via grip

Until the ogg encoder kicked in the cpu load was about 5.5 and the xmms
was playing perfect.  The encoder started to cause a skip and the mouse
picked up a occasional, very short pause <1/4sec, but the the system
remained very useable.  During the slightly over 3 minutes of ftp in
both directions, switching desktops, opening new xterms, command line
access, scrolling and changing pages in browerrs, etc were all
responsive.  Slower of course, but considering the load was now over 7
it was not even near painful.  Average delays were maybe 1/2 - 3/4
second.

Based on previous configs with this system using 2.2.17, 2.2.19, 2.4.7
and 2.4.17, the above would have made this thing roll over and die for
10 minutes.  I don't know what I changed that caused this, but I like
it.

During this process, the system also swapped over 80 meg to disk with
all the other reads and writes going on.  Again, if any of my config
would be useful, please request whatever info/tests you need.

Bill

Best Regards,
Bill
