Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264323AbTDPMDB (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 08:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264324AbTDPMDB 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 08:03:01 -0400
Received: from miranda.zianet.com ([216.234.192.169]:40209 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S264323AbTDPMC7 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 08:02:59 -0400
Subject: Re: Kernels since 2.5.60 upto 2.5.67 freeze when X server
	terminates
From: Steven Cole <elenstev@mesatop.com>
To: Valdis.Kletnieks@vt.edu
Cc: Joseph Fannin <jhf@rivenstone.net>, Florin Iucha <florin@iucha.net>,
       linux-kernel@vger.kernel.org, Dave Jones <davej@codemonkey.org.uk>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <200304160825.h3G8PtMS001267@turing-police.cc.vt.edu>
References: <20030415133608.A1447@cuculus.switch.gts.cz>
	 <20030415125507.GA29143@iucha.net> <3E9C03DD.3040200@oracle.com>
	 <20030415164435.GA6389@rivenstone.net> <20030415182057.GC29143@iucha.net>
	 <20030416044144.GA32400@rivenstone.net>
	 <200304160825.h3G8PtMS001267@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1050495049.27972.15.camel@spc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 16 Apr 2003 06:10:49 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-16 at 02:25, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 16 Apr 2003 00:41:48 EDT, Joseph Fannin said:
> 
> >     Except that I'm seeing the very same sort of freeze on with a
> >  Rage128 card with XFree86 4.2.1.
> > 
> >     Are we all Debian sid users, perhaps?
> 
> Nice try, but I'm seeing it on a RedHat 9-ish laptop with this card:
> 
> 01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 440 Go] (rev a3)
> 
> using XFree86 4.3.0 and the binary NVidia 4191 driver.  I hadn't posted because
> I figured it was an NVidia problem and tainted  quite thoroughly.
> 
> Another data point:  I *dont* see this sort of freeze if I start it with
> 'NvAGP=1' (use internal agp), but I *do* see it with 'NvAGP=2' or '3'
> (which tell it to use the kernel 'agpgart' code).
> 
> Sorry Dave, looks like a bug in AGP....

Yet another data point.  I've seen this with RedHat 9 and i810 and
2.5.67+. I've haven't had time to test without AGP yet

I could avoid the freeze by starting X with "startx". Then, when going
back to runlevel 3, the freeze did _not_ occur. 

I saw the freeze when selecting "Log Out" from either KDE or Gnome, but
only if I started X with /sbin/init 5.

Occasionally and with 2.5.67-mm1 only, instead of a freeze, I saw a
spontaneous reboot.

I'm many miles from that test box now but if I get the chance I'll test
without AGP.

Steven

