Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261590AbSJ2Gik>; Tue, 29 Oct 2002 01:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261601AbSJ2Gik>; Tue, 29 Oct 2002 01:38:40 -0500
Received: from alpha2.its.monash.edu.au ([130.194.1.4]:18183 "EHLO
	ALPHA2.ITS.MONASH.EDU.AU") by vger.kernel.org with ESMTP
	id <S261590AbSJ2Gij>; Tue, 29 Oct 2002 01:38:39 -0500
Date: Tue, 29 Oct 2002 17:37:33 +1100 (EST)
From: netdev-bounce@oss.sgi.com
To: undisclosed-recipients:;
Message-id: <20021029063733.0B22B1300D2@splat.its.monash.edu.au>
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002, bert hubert wrote:

> On Wed, Oct 23, 2002 at 03:42:48PM +0200, Roy Sigurd Karlsbakk wrote:
> > > The e1000 can very well do hardware checksumming on transmit.
> > >
> > > The missing piece of the puzzle is that his application is not
> > > using sendfile(), without which no transmit checksum offload
> > > can take place.
> > 
> > As far as I've understood, sendfile() won't do much good with large files. Is 
> > this right?
> 
> I still refuse to believe that a 1.8GHz Pentium4 can only checksum
> 250megabits/second. MD Raid5 does better and they probably don't use a
> checksum as braindead as that used by TCP.
> 
> If the checksumming is not the problem, the copying is, which would be a
> weakness of your hardware. The function profiled does both the copying and
> the checksumming.
> 
> But 250megabits/second also seems low.
> 
> Dave? 
> 

Ordinary DUAL Pentium 400 MHz machine does this...


Calculating CPU speed...done
Testing checksum speed...done
Testing RAM copy...done
Testing I/O port speed...done

                     CPU Clock = 400  MHz
                checksum speed = 685  Mb/s
                      RAM copy = 1549 Mb/s
                I/O port speed = 654  kb/s


This is 685 megaBYTES per second.

                checksum speed = 685  Mb/s



Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America



