Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312212AbSDNMhX>; Sun, 14 Apr 2002 08:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312248AbSDNMhW>; Sun, 14 Apr 2002 08:37:22 -0400
Received: from velli.mail.jippii.net ([195.197.172.114]:2511 "HELO
	velli.mail.jippii.net") by vger.kernel.org with SMTP
	id <S312212AbSDNMhV>; Sun, 14 Apr 2002 08:37:21 -0400
Date: Sun, 14 Apr 2002 15:39:35 +0300
From: Anssi Saari <as@sci.fi>
To: Andre Hedrick <andre@linux-ide.org>
Cc: vojtech@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: PROMBLEM: CD burning at 16x uses excessive CPU, although DMA is enabled
Message-ID: <20020414123935.GA6441@sci.fi>
In-Reply-To: <200204092206.02376.roger.larsson@norran.net> <Pine.LNX.4.10.10204091320450.25275-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2002 at 01:27:48PM -0700, Andre Hedrick wrote:
> On Tue, 9 Apr 2002, Roger Larsson wrote:
> 
> > On tisdagen den 9 april 2002 12.01, Anssi Saari wrote:
> > > On Mon, Apr 08, 2002 at 06:02:55PM -0400, Mark Hahn wrote:
> > > > I think someone else already pointed out that doing
> > > > a kernel profile would be good.  strace would also
> > > > be quite useful, even just the -c form.
> > >
> > > Here it is:
> > >
> > > With unmaskirq=1 first:
> > >
> > >
> > >     49 handle_IRQ_event                           0.5104
> > >    239 file_read_actor                            2.4896
> > >   3324 default_idle                              69.2500
> > >  20097 ide_output_data                          104.6719
> > 
> > Hey, what is this?
> > 
> > Comment of the function is:
> > "This is used for most PIO data transfers *to* the IDE interface"
> > (see /drivers/ide/ide.c:426)
> > Has it reverted to PIO mode?
> 
> This is because there are not a proper and correct state diagram data
> handler set for ATAPI, period.  Initially the driver evolved out of PIO
> calls to the PACKET_COMMAND opcode for the ATA command set.  Since there
> has been zero updates/attempts to create a proper ATAPI/ASPI by anyone,
> you can expect PIO transactions.

I have now tried the writer on an old Pentium motherboard with Intel
430HX chipset and PIIX3. The performance problems didn't happen there,
so I would guess this is more a problem with how Linux handles the VIA
686b southbridge.

But what can I do to help fix this problem?

