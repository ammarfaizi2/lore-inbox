Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129723AbRCHVM6>; Thu, 8 Mar 2001 16:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129727AbRCHVMs>; Thu, 8 Mar 2001 16:12:48 -0500
Received: from eschelon.gamesquad.net ([216.115.239.45]:13 "HELO
	eschelon.gamesquad.net") by vger.kernel.org with SMTP
	id <S129723AbRCHVMf>; Thu, 8 Mar 2001 16:12:35 -0500
From: "Vibol Hou" <vhou@khmer.cc>
To: "Vibol Hou" <vhou@khmer.cc>, "Andrew Morton" <andrewm@uow.edu.au>,
        "Mike Galbraith" <mikeg@wen-online.de>
Cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>, <balbir@reflexnet.net>,
        <hahn@coffee.psychology.mcmaster.ca>
Subject: RE: System slowdown on 2.4.2-ac5 (recurring from 2.4.1-ac20 and2.4.0)
Date: Thu, 8 Mar 2001 13:11:29 -0800
Message-ID: <NDBBKKONDOBLNCIOPCGHGEFJFEAA.vhou@khmer.cc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <NDBBKKONDOBLNCIOPCGHIEJKFDAA.vhou@khmer.cc>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, after finally getting 2.4.2-ac14 to compile and installed, the system
crashed twice within an hour of each other.  Once because of a kernel BUG in
printk.c, which was coupled with an NMI Watchdog trigger according to
Andreas Dilger.  The other because of the same apparant reason the system
has been bogging down before.  Not good.

Since I do not want to risk trashing the drives any more than I already have
and suffering from loss of sleep having to babysit this server, I am
discontinuing testing of the 2.4.x series kernel on my system.  I will
attempt to setup a copy of the system locally, but I don't quite have the
resources necessary to generate the varied type of loads that the remote
server receives on a daily basis.  It's odd that I seem to be the only
person experiencing this problem, so it can be attributed to some hardware
problems that the 2.2.x series is immune to or a miracle combination of
hardware that happens to dislike 2.4, or maybe it's just plain bad luck ;)

Anyways, think about this one: What would cause bind to spit out many of
these messages as the system is beginning to slowdown to a crawl?

Mar  8 09:26:28 omega named[167]: ns_req: sendto([216.104.96.10].2483):
Resource temporarily unavailable

Bind does this every time the system starts bogging down.  The system is
obviously receiving TCP packets, but can't send them back out due to the
aforementioned error.  The console doesn't really lock as SysRQ still works;
though getty isn't responsive after the system hits the slowdown state.  I
hope all the other information I've collected thus far along with this small
piece will help determine the location of the problem and maybe a fix for it
(if it is a problem at all).

In the meanwhile, good hacking!  I appreciate all the help I've gotten from
the kind people on this list.  All the kernel developers have done an
excellent job on streamlining this kernel to make it faster and more
efficient, but it's still not as stable as the 2.2.x kernel (at least for
me).

-Vibol

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Vibol Hou
Sent: Wednesday, March 07, 2001 10:26 AM
To: Andrew Morton; Mike Galbraith
Cc: Vibol Hou; Linux-Kernel; balbir@reflexnet.net;
hahn@coffee.psychology.mcmaster.ca
Subject: RE: System slowdown on 2.4.2-ac5 (recurring from 2.4.1-ac20
and2.4.0)


> But the failing of Vibol's server remains a mystery.  I suggest
> an upgrade to 2.4.2-ac13 would be worthwhile - at least we'll
> get a full task table dump.

I'll get it up and running and report back with the trace next time
something goes awry.

-Vibol

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

