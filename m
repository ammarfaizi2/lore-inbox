Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265094AbSJWRDA>; Wed, 23 Oct 2002 13:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265096AbSJWRC7>; Wed, 23 Oct 2002 13:02:59 -0400
Received: from chaos.analogic.com ([204.178.40.224]:27782 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265094AbSJWRC5>; Wed, 23 Oct 2002 13:02:57 -0400
Date: Wed, 23 Oct 2002 13:11:35 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: bert hubert <ahu@ds9a.nl>
cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       "David S. Miller" <davem@rth.ninka.net>, netdev@oss.sgi.com,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] tuning linux for high network performance?
In-Reply-To: <20021023170102.GA5302@outpost.ds9a.nl>
Message-ID: <Pine.LNX.3.95.1021023130843.14535A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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


