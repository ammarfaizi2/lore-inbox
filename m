Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311211AbSDQRgc>; Wed, 17 Apr 2002 13:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311262AbSDQRgb>; Wed, 17 Apr 2002 13:36:31 -0400
Received: from dark.x.dtu.dk ([130.225.92.246]:19620 "HELO dark.x.dtu.dk")
	by vger.kernel.org with SMTP id <S311211AbSDQRga>;
	Wed, 17 Apr 2002 13:36:30 -0400
Date: Wed, 17 Apr 2002 19:36:29 +0200
From: Baldur Norddahl <bbn-linux-kernel@clansoft.dk>
To: nick@snowman.net
Cc: Baldur Norddahl <bbn-linux-kernel@clansoft.dk>,
        Mike Dresser <mdresser_l@windsormachine.com>,
        linux-kernel@vger.kernel.org
Subject: Re: IDE/raid performance
Message-ID: <20020417173629.GA32736@dark.x.dtu.dk>
In-Reply-To: <20020417140045.GC27648@dark.x.dtu.dk> <Pine.LNX.4.21.0204171108480.3300-100000@ns>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting nick@snowman.net (nick@snowman.net):
> On Wed, 17 Apr 2002, Baldur Norddahl wrote:
> > Quoting Mike Dresser (mdresser_l@windsormachine.com):
> > > On Wed, 17 Apr 2002, Baldur Norddahl wrote:
> > Motherboard: Tyan Tiger MPX S2466N
> > Chipset: AMD 760MPX
> > CPU: Dual Athlon MP 1800+ 1.53 GHz                                              
> > Two Promise Technology UltraDMA133 TX2 controllers
> > Two Promise Technology UltraDMA100 TX2 controllers
> > Matrox G200 AGP video card.
> > 1 GB registered DDR RAM
> > > Also, with 12 hd's, dual cpu's, etc, what kind of power supply are you
> > > using?
> > It is a 350W powersupply. I wanted something bigger, but couldn't get it for
> > sane prices. I can't rule out that it is overloaded of course. If it is, I
> > haven't seen any other symptoms, the system is rock stable so far.
> > Baldur
> AMD recommends a minimum of 400watts for a dual athlon system
> IIRC.  Ignoreing that the startup current on an IBM 5400rpm IDE disk seems
> to be about 25-30watts.  Each 1800+ MP puts out 66w of heat, meaning it
> uses more than 66w (I couldn't find the power useage stats) for a total of
> 132 watts, so on boot ignoreing everything but the disks and the chips
> you've got 12x25w (for the disks) + 2x66w (for the procs) or about
> 432watts.  This will go down alot after all your disks spin up, but I'm
> amazed your system boots.  Morale of this message:  Don't be a dipshit and
> put 12 IDE disks on a single power supply.
> 	Nick
> 

I checked and it is actually a 400W powersupply. Sorry about that.

Actually the power usage for the 80 GB western digital disks are:

Spinup(peak) 17.0W
Read/Write 8.0W
Seek 14.0W

And for the 160 GB maxtor disks:

Spinup(peak) 23.7W
Read/Write 4.8W
Seek 5.2W

This adds up to 8*17.0+4*23.7 = 231W spinup and 8*14.0+4*5.2 = 132W during
seek.

The Athlon MP 1800+ has the following stats:

Voltage: 1.75V
Maximum thermal power: 66.0W
Maximum Icc 37.7A
Typical thermal power: 58.9W
Typical Icc 33.7A

So the CPU maximum uses Vcc*Icc = 66.0W (wow they didn't lie about the
thermal power).

It is not likely that both CPUs are burning 66W during the inital phases of
boot where the disk do their spinup. Even then you might also be able to
draw more current out of the powersupply than its rating for a short while.

For this discussion it is more interresting if it is enough during normal
operations. Worst case we got 132W for the disks and 2*66W for the CPUs,
which leaves 400W - 132 - 2*66 = 136WW for the motherboard, gfx, 4 promise
controllers and the system disk. 

The recommended minimum powersupply for this motherboard is 300W.

Baldur
