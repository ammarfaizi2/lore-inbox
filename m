Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283566AbRLOT1k>; Sat, 15 Dec 2001 14:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283588AbRLOT1b>; Sat, 15 Dec 2001 14:27:31 -0500
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:43219 "EHLO
	gull.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S283566AbRLOT1Q>; Sat, 15 Dec 2001 14:27:16 -0500
Message-ID: <3C1B17D7.9F4372BC@earthlink.net>
Date: Sat, 15 Dec 2001 04:28:55 -0500
From: Jeff <piercejhsd009@earthlink.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: war <war@starband.net>
CC: Wakko Warner <wakko@animx.eu.org>,
        Kristian Peters <kristian.peters@korseby.net>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: cdrecord reports size vs. capabilities error....
In-Reply-To: <3C1880F4.8CE5AC8F@earthlink.net> <3C19DEAF.4080703@korseby.net> <20011214064202.A24719@animx.eu.org> <3C1A0DF6.5030401@korseby.net> <3C1A11AF.610B9B02@starband.net> <20011214170105.B25469@animx.eu.org> <3C1AB9F4.BFEABFEB@starband.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I guess the problem was in my module.conf file, I forgot to add alias
scd1 sr_mod. I didn't remember the capabilities error from before. The
warning is still there in scanbus, but everything is now working
correctly.
Thanks to everybody for their help.

war wrote:
> 
> Yeah, when I switched controllers etc it puts the message in different spots.
> I'm not sure why it does that.
> You'll have to ask the guy who wrote the driver I guess.
> 
> Wakko Warner wrote:
> 
> > > That just means it is not a standard compliant CDRW drive.
> > > I've asked Joerg Schilling about this and that's what he said.
> > > I get the same thing.
> > >
> > > Linux sg driver version: 3.1.20
> > > Using libscg version 'schily-0.5'
> > > scsibus0:
> > >         0,0,0     0) *
> > >         0,1,0     1) *
> > >         0,2,0     2) 'IOMEGA  ' 'ZIP 100         ' 'J.03' Removable Disk
> > >         0,3,0     3) 'MATSHITA' 'CD-ROM CR-8008  ' '8.0e' Removable CD-ROM
> > >         0,4,0     4) *
> > >         0,5,0     5) *
> > >         0,6,0     6) *
> > >         0,7,0     7) *
> > > scsibus1:
> > >         1,0,0   100) '        ' 'SMART100X/2400  ' '1.44' Removable CD-ROM
> > >         1,1,0   101) 'PLEXTOR ' 'CD-R   PX-W1210A' '1.09' Removable CD-ROM
> > > cdrecord: Warning: controller returns wrong size for CD capabilities page.
> > >         1,2,0   102) 'MATSHITA' 'CD-ROM CR-581-M ' '1.05' Removable CD-ROM
> > >         1,3,0   103) 'HP      ' 'CD-Writer+ 7500 ' '1.0a' Removable CD-ROM
> > >         1,4,0   104) 'SONY    ' 'CD-ROM CDU77E-Q ' '1.3a' Removable CD-ROM
> > >         1,5,0   105) *
> > >         1,6,0   106) *
> > >         1,7,0   107) *
> >
> > Ok, but why would having 2 identical cdroms be different?  they both have
> > the same firmware, yet cdrecord -scanbus shows one of them with the wrong
> > size thing.  There's 2 scsi controllers, but if I swap them, the wrong size
> > stays with the drive, not the controller.
> >
> > --
> >  Lab tests show that use of micro$oft causes cancer in lab animals
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Jeff
piercejhsd009@earthlink.net
