Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314154AbSDQWfs>; Wed, 17 Apr 2002 18:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314190AbSDQWfs>; Wed, 17 Apr 2002 18:35:48 -0400
Received: from twinlark.arctic.org ([208.44.199.239]:8082 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S314154AbSDQWfr>; Wed, 17 Apr 2002 18:35:47 -0400
Date: Wed, 17 Apr 2002 15:35:44 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Baldur Norddahl <bbn-linux-kernel@clansoft.dk>
cc: nick@snowman.net, Mike Dresser <mdresser_l@windsormachine.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: IDE/raid performance
In-Reply-To: <20020417173629.GA32736@dark.x.dtu.dk>
Message-ID: <Pine.LNX.4.44.0204171514350.2509-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2002, Baldur Norddahl wrote:

> It is not likely that both CPUs are burning 66W during the inital phases of
> boot where the disk do their spinup.

while one cpu is almost certainly idle during, the other probably is not
doing nice things like going into HALT states; so it's entirely likely
that it's consuming a substantial amount of power.  the BIOS does not
typically ever use HALT or other power saving states except on non-boot
CPUs.

i've got an external power meter for doing measurements of this sort of
thing, and i recently built a dual athlon system (tyan S2462NG mobo) w/
four maxtor D740X 80GB disks (on a pair of promise ultra100 TX2).  its
peak during powerup is 255W.  it idles at 193W, and will run up to 225W
while compiling a kernel.

(i made no attempt to find a "power virus" for this system.  i have a 460W
power supply and i'm happy i'm well within limits.)

fwiw, my drives are rated at 24W each for power up... and the CPUs are
1.4GHz (purchased in feb/02, which was when the 1.4GHz were the best
price/performance, so around the middle of AMD's yield curve.)

my meter is a ~USD1000 lab quality meter... but you can get reasonablly
accurate measurements by picking up a ~USD50 "AC clamp meter" from an
electrician's supply store.  look for one with 0.1A accuracy.  AC clamp
meters use magnetic inductance to measure the current flow around an AC
wire.  (for example, see
<http://www.fluke.com/products/home.asp?SID=5&AGID=3&PID=30405>)

to make the measurements you need to put the clamp around a single live
wire.  you don't need to remove insulation from a live wire -- the
magnetic induction occurs even if there's still insulation around it.
but you can't measure with both live wires inside the clamp (their fields
are opposite and cancel)... so you do need to isolate the clamp around one
live wire ...

i've carefully removed the outer (black) insulation from a computer power
cable, exposing the three (still insulated) wires inside (which happen to
be black, white, and green).  then i put the clamp around the black wire
for measurement.  (or you can measure entire circuits at the fuse box.)

WARNING DANGER!  i'm not responsible for any damage, injury and so forth,
which you incur as a result of trying to use one of these devices.  you
assume all responsibility, and so forth.  see my legal disclaimer at
<http://arctic.org/~dean/legal.html> if you're in doubt.

remember that power = current * volts-rms... (and now all the EE geeks
will jump in and tell me how i'm wrong and what the real detailed formula
actually is, and how power supplies quote their power numbers in confusing
manners, and so forth... and me being a software engineer i'm happy just
to see that i'm only consuming half the rated power of my power supply,
and that's probably a fine enough safety margin :)

-dean

