Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266721AbUHaGJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266721AbUHaGJv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 02:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266733AbUHaGJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 02:09:51 -0400
Received: from [139.30.44.16] ([139.30.44.16]:33255 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S266721AbUHaGJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 02:09:49 -0400
Date: Tue, 31 Aug 2004 08:07:56 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: john stultz <johnstul@us.ibm.com>
cc: george anzinger <george@mvista.com>, Andrew Morton <akpm@osdl.org>,
       Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>,
       albert@users.sourceforge.net, hirofumi@mail.parknet.co.jp,
       lkml <linux-kernel@vger.kernel.org>, voland@dmz.com.pl,
       nicolas.george@ens.fr, david+powerix@blue-labs.org
Subject: Re: [PATCH] Re: boot time, process start time, and NOW time
In-Reply-To: <1093916047.14662.144.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.53.0408310757430.6523@gockel.physik3.uni-rostock.de>
References: <87smcf5zx7.fsf@devron.myhome.or.jp>  <20040816124136.27646d14.akpm@osdl.org>
  <Pine.LNX.4.53.0408172207520.24814@gockel.physik3.uni-rostock.de> 
 <412285A5.9080003@mvista.com>  <1092782243.2429.254.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.53.0408180051540.25366@gockel.physik3.uni-rostock.de> 
 <1092787863.2429.311.camel@cog.beaverton.ibm.com>  <1092781172.2301.1654.camel@cube>
  <1092791363.2429.319.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.53.0408180927450.14935@gockel.physik3.uni-rostock.de> 
 <20040819191537.GA24060@elektroni.ee.tut.fi>  <20040826040436.360f05f7.akpm@osdl.org>
  <Pine.LNX.4.53.0408261311040.21236@gockel.physik3.uni-rostock.de> 
 <Pine.LNX.4.53.0408310037280.5596@gockel.physik3.uni-rostock.de>
 <1093916047.14662.144.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2004, john stultz wrote:

> On Mon, 2004-08-30 at 16:00, Tim Schmielau wrote:
> > George, please excuse my lack of understanding. What again where the
> > precise reasons to have an ntp-corrected uptime?
> 
> Ah, here's the thread with the first mention of it that I could find.
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0306.1/1471.html

Ah, it seems George indeed did the patch because of these problems:

  http://www.uwsg.iu.edu/hypermail/linux/kernel/0306.1/1641.html

However, the actual reason were just missing wall_to_monotonic 
initializations:

  http://www.uwsg.iu.edu/hypermail/linux/kernel/0306.2/1330.html

This was fixed in mainline:

  http://linus.bkbits.net:8080/linux-2.5/cset%403f0e60dcpIosK3b5_uJ-aD9Mare17w

Tim
