Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135283AbRDRUGe>; Wed, 18 Apr 2001 16:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135284AbRDRUGX>; Wed, 18 Apr 2001 16:06:23 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:7685 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S135283AbRDRUGL>; Wed, 18 Apr 2001 16:06:11 -0400
Date: Wed, 18 Apr 2001 21:58:04 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Dragan Milenkovic <tyrant@galeb.etf.bg.ac.yu>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: uname ?
Message-ID: <20010418215804.M6985@arthur.ubicom.tudelft.nl>
In-Reply-To: <Pine.LNX.4.21.0104181938060.14886-100000@galeb.etf.bg.ac.yu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0104181938060.14886-100000@galeb.etf.bg.ac.yu>; from tyrant@galeb.etf.bg.ac.yu on Wed, Apr 18, 2001 at 07:56:25PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2001 at 07:56:25PM +0200, Dragan Milenkovic wrote:
> <rpm-related>
> Few days ago, I found an incredibly usable option in latest gcc versions.
> gcc -march=k6 -mcpu=k6

That -mcpu flag is not necessary. From the gcc info files:

`-march=CPU TYPE'
     Generate instructions for the machine type CPU TYPE.  The choices
     for CPU TYPE are the same as for `-mcpu'.  Moreover, specifying
     `-march=CPU TYPE' implies `-mcpu=CPU TYPE'.

> I started rebuilding SRPMS with these as optflags, just to find out that
> some packages don't use optflags, but use -march=`uname -m`.

Which breaks very nice if you want to cross compile packages:

  erik@arthur:/tmp> arm-linux-gcc -march=`uname -m` -c foo.c
  cc1: bad value (i686) for -march= switch

> So ...
> </rpm-related>
> 
> What about uname -m and non-Intel processors? Is there going to be
> a change? I hope we all agree that K6 is not i586 or i686.
> I vote for breaking compatibility!

You want to fix the kernel when gcc is not even consistent across its
targets? Have a look at the gcc info files: the -march= flag for ARM
targets behaves completely different from its ix86 counterpart. And the
gcc Sparc target doesn't even recognise an -march= flag.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
