Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131643AbRDCMVa>; Tue, 3 Apr 2001 08:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131386AbRDCMVU>; Tue, 3 Apr 2001 08:21:20 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:15233 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S131232AbRDCMVH>; Tue, 3 Apr 2001 08:21:07 -0400
Date: Tue, 3 Apr 2001 14:20:24 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andries.Brouwer@cwi.nl, torvalds@transmeta.com, hpa@transmeta.com,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
Message-ID: <20010403142024.Z8155@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010403120911.B4561@nightmaster.csn.tu-chemnitz.de> <E14kPZz-0007tk-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E14kPZz-0007tk-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Apr 03, 2001 at 01:06:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2001 at 01:06:33PM +0100, Alan Cox wrote:
> Device numbers/names have to be constant in order to detect
> disk layout changes across boots.

Names stay constant, but why the NUMBERS? The names should stay
constant and represent the actual layout on each busses (say:
sane hierachic enumeration) of course.

But /dev/ide/host0/bus0/target0/lun0/part1 could get a new device
number on every reboot, right?

I'm sure, I'm missing some important usage of device of device
numers here (not counting the ones listed already), but I don't
know what ;-)

Otherwise it would be too easy to remove static major/minors and
all the fun allocating them. And LANANA would have one thing less
to worry about ;-)

One thing I certainly miss: DevFS is not mandatory (yet).

Thanks & Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
