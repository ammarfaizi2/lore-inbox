Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131127AbRBER1j>; Mon, 5 Feb 2001 12:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129539AbRBER13>; Mon, 5 Feb 2001 12:27:29 -0500
Received: from relais.videotron.ca ([24.201.245.36]:15103 "EHLO
	VL-MS-MR002.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S135470AbRBER1R>; Mon, 5 Feb 2001 12:27:17 -0500
Message-ID: <3A7EE0C2.20DF8016@videotron.ca>
Date: Mon, 05 Feb 2001 12:20:02 -0500
From: Martin Laberge <mlsoft@videotron.ca>
Organization: MLSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Kenneth Yeung <kkyeung@expert.cc.purdue.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: digiboard support in linux
In-Reply-To: <Pine.GSO.3.96.1010205092911.25633A-100000@expert.cc.purdue.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenneth Yeung wrote:

> Martin,
>
>         From reading the info on Digi's site, they say that for PC/x the
> driver is already built into the kernel.  Am I still supposed to load the
> drivers up?  If so, then i'm in trouble because I don't have any drivers
> for the PC/X on Redhat.  I've been reading the install instructions from:
> http://support.digi.com/support/techsupport/unix/linux/pcx.html
>
> Thanks for your help!
> -Ken
>
> On Sat, 3 Feb 2001, Martin Laberge wrote:
>
> > Kenneth Yeung wrote:
> >
> > > Hello Martin
> > >
> > >         Thanks for the info, I'm having a little trouble getting the ports
> > > configured.  On my system, it looks like half the ports are on irq 2 and
> > > the other half are on irq 5.  and looks like they have been configured the
> > > right way?  But i can't seem to get them to run getty so that I can test
> > > the connection.
> > >
> > > Thanks!
> > > -Ken
> > >
> > > On Tue, 30 Jan 2001, Martin Laberge wrote:
> > >
> > > > Kenneth Yeung wrote:
> > > >
> > > > > Hello all
> > > > >
> > > > > Can anyone tell me where I can find infomation on digiboard support in
> > > > > linux specifically the PC/X model?
> > > > >
> > > > > THanks
> > > > > -Ken
> > > > >
> > > > > -
> > > > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > > > the body of a message to majordomo@vger.kernel.org
> > > > > Please read the FAQ at http://www.tux.org/lkml/
> > > >
> > > > yes i used it often in my installations and no problem with that
> > > > since 2.0.x
> > > >
> > > > 2.2.x works good too
> > > >
> > > > never tried with linux 2.4.x
> > > >
> > > >
> > > > driver is supported by digiboard itself   and by linux
> > > >
> > > > you have the choice of 2 drivers for these boards....
> > > >
> > > > i used for my part the PC/8e  PC/16e and PC/32e   In ISA versions
> > > > and never had any problems... (except figuring out how to install for the
> > > > first time)
> > > > but it is very simple if you know how to read install instructions
> > > >
> > > >
> > > > Martin Laberge
> > > > mlsoft@videotron.ca
> > > >
> > > >
> > > >
> >
> > could you send me the configuration logs and system boot messages about the
> > digiboard...
> >
> > for my part i used agetty on these ports and the board use only one interrupt
> > (exept if you have many boards...
> > in that case one interrupt by board ... )
> >
> > did you executed the DigiLoad command in your boot scripts like instructed in
> > documentations...
> > did you put the board drivers (?????.bin) in the right places...
> >
> > they have to be loaded for the board to work...
> >
> > Martin Laberge
> > mlsoft@videotron.ca
> >
> >
> >

the drivers are for the Intelligents boards  and are located in /etc/digi/?????.bin

if you are using the non intelligent boards, you can use the drivers from the kernel,
and follow the instructions you referred abobe

for my part i allways used the intelligent boards   ex: PC/16e   (note the 'e') and i
did it with the digiboard provided drivers...

for non intelligent boards, i suppose the instructions you referred to were valid...
I read them and found it clean for me...
make all the steps as indicated...

one exeption perhaps...   I used ttyD? in place of ttyS?   just not to conflict with
the standard serial ports...
in the intelligent boards, they referred to ttyD? too... then i allways did it this
way...

maybe you could try the Digiboard provided drivers if you continue to have
problems...
I never used those included with linux kernel... Digiboard should know their hardware
well enough to provide for working drivers
better than anyone else... i suppose...

Also there is the case of Hardware CTS/RTS/DTR/... pins...
if you work with 3 wire serial connections, i propose you set the ports to CLOCAL
or/and jump the 4,5 / 6,8,20 pins of the DB-25
or the corresponding ones on others connectors...

Martin Laberge
mlsoft@videotron.ca




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
