Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131292AbRCHJH3>; Thu, 8 Mar 2001 04:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131296AbRCHJHU>; Thu, 8 Mar 2001 04:07:20 -0500
Received: from mx0.gmx.net ([213.165.64.100]:34566 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S131292AbRCHJHQ>;
	Thu, 8 Mar 2001 04:07:16 -0500
Date: Thu, 8 Mar 2001 10:06:57 +0100 (MET)
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE bug in 2.4.2-ac12?
From: Konrad Stopsack <konrad_lkml@gmx.de>
In-Reply-To: <20010308095705.A976@suse.cz>
Message-ID: <32463.984042417@www29.gmx.net>
Mime-Version: 1.0
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0009979400@gmx.net
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Authenticated-IP: [141.76.11.162]
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Thu, Mar 08, 2001 at 09:51:43AM +0100, Konrad Stopsack wrote:
> 
> > > I don't see any other way how the ZIP could have impact on the IDE 
HDD
> > > on a different IDE interface.
> > The 82c586b can be a chip with locked-together IDE controllers, can't
> it?
> 
> What do you mean by 'locked together'?
Nasty chips whose two IDE channels aren't really separated. On one IDE 
channel you either can use DMA or not. On these chips, switching off DMA 
at the second controller also disables DMA at the first.

> 
> > > If you wonder why /proc/ide/via reports slower DMA rates for the HDD
> > > when the ZIP is connected is because the auto slowdown code kicks in
> and
> > > lowers the transfer rate when too many CRC errors happen.
> > 
> > Well, and what should I do now? I really need the ZIP drive. 
> > Try without CD-ROM? Buy new ATX case with 300W power supply? And new 
> > motherboard? And new processor? And ... and ... and?
> > Isn't there a chance to unlock the IDE channels (if they are locked)? 
> > Remember, I've heard about a Windows patch to do this.
> 
> I have two vt82c586b's here and one old vt82c586. All work fine with
> different drive combinations, one even has a CD-ROM and a ZIP on the
> secondary channel like yours.

Yeah, Ok. My combination SHOULD work without any problems...

What else could I do? Swap CD-ROM and ZIP? Try new 2.4.2-ac14 with command 
line parameters "ide0=dma ide1=nodma"?

cu Konrad

-- 
Konrad Stopsack - konrad@stopsack.de

Sent through GMX FreeMail - http://www.gmx.net
