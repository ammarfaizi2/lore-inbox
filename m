Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317464AbSFDW2E>; Tue, 4 Jun 2002 18:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316935AbSFDW2D>; Tue, 4 Jun 2002 18:28:03 -0400
Received: from daimi.au.dk ([130.225.16.1]:29649 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S316933AbSFDW2A>;
	Tue, 4 Jun 2002 18:28:00 -0400
Message-ID: <3CFD3EE5.DAE3E2C9@daimi.au.dk>
Date: Wed, 05 Jun 2002 00:27:49 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Vojtech Pavlik <vojtech@suse.cz>, Derek Vadala <derek@cynicism.com>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, Tedd Hansen <tedd@konge.net>,
        Christian Vik <christian@konge.net>,
        Lars Christian Nygaard <lars@snart.com>
Subject: Re: RAID-6 support in kernel?
In-Reply-To: <Pine.LNX.4.33.0206031020290.30424-100000@mail.pronto.tv> <Pine.GSO.4.21.0206030213510.23709-100000@gecko.roadtoad.net> <20020603113128.C13204@ucw.cz> <20020604154904.J36@toy.ucw.cz>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> > > > It'll waste 9 drives, giving me a total capacity of 7n instead of 14n.
> > > > And, by definition, RAID-6 _can_ withstand _any_ two-drive failure.
> > >
> > > This is certainly not true.
> > >
> > > Combining N RAID-5 into a stripe wastes on N disks.
> > >
> > > If you combine two it wastes 2 disks, etc.
> > >
> > > That is, for each RAID-5 you waste a single disk worth of storage for
> > > partiy. I don't know what equation you're using where you get 9 drives
> > > from.
> >
> > He was thinking "mirror", not "stripe". Mirror of 2 RAID-5 arrays (would
> > be probably called RAID-15 (when there is a RAID-10 for mirrored stripe
> > arrays)), can withstand any two disks failing anytime. Even more for
> 
> RAID-1 over two RAID-5s should withstand any three failures, AFAICS.
> 
> You could do RAID-5 over RAID-5. That should survive any 2 failures and
> still be reasonably efficient.

It will actually survive any 3 disk failures. It is reasonable
if you have a lot of disks. It requires at least 9 disks and
I would prefere at least 25 disks.

RAID-4 and RAID-5 are very similar. And it happens to be the
case that if you only use two disks RAID-1, RAID-4, and RAID-5
are all identical. And each of them can survive a single disk
failure.

Any two of these RAIDs on top of each other can survive three
disk failures. That is true because it takes four disk failures
to loose data. On the upper most RAID you must loose two of the
lower level RAIDs, each of these two must have lost two disks.

RAID-4 on top of RAID-4 is actually just a two-dimentional
parity. RAID-5 on top of RAID-5 is very similar. 

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
