Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283603AbRLMHul>; Thu, 13 Dec 2001 02:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283658AbRLMHub>; Thu, 13 Dec 2001 02:50:31 -0500
Received: from inje.iskon.hr ([213.191.128.16]:50889 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S283603AbRLMHuZ>;
	Thu, 13 Dec 2001 02:50:25 -0500
To: Morgan Collins <sirmorcant@morcant.org>
Cc: "Marcelo ''Mosca'' de Paula Bezerra" <mosca@roadnet.com.br>,
        Rui Sousa <rui.p.m.sousa@clix.pt>,
        emu10k1-devel@opensource.creative.com, linux-kernel@vger.kernel.org
Subject: Re: emu10k1 - interrupt storm?
In-Reply-To: <Pine.LNX.4.33.0112121112450.2868-100000@sophia-sousar2.nice.mindspeed.com>
	<3C175A7C.6C532320@roadnet.com.br> <878zc8az65.fsf@atlas.iskon.hr>
	<1008196905.980.6.camel@ember>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: 13 Dec 2001 08:50:18 +0100
In-Reply-To: <1008196905.980.6.camel@ember> (Morgan Collins's message of "12 Dec 2001 14:41:45 -0800")
Message-ID: <dnellztv7p.fsf@magla.zg.iskon.hr>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Morgan Collins <sirmorcant@morcant.org> writes:

> On Wed, 2001-12-12 at 13:47, Zlatko Calusic wrote:
> > "Marcelo ''Mosca'' de Paula Bezerra" <mosca@roadnet.com.br> writes:
> > 
> > > Try running esd with the -as 10 options..
> > > As the help says, it will disconnect the audio device after 10 seconds
> > > of inactivity. It will at least help you with the interrupt load while
> > > not using sound.
> > > 
> > 
> > Yes, nice idea, but easier said than done. :)
> > 
> > Unfortunately esd is started by the gnome desktop environment and I
> > can disable or enable it, but can't set any parameters (as far as I
> > can see). Probably I'll disable it for good, as emu10k1 driver already
> > does a great job mixing multiple sound streams.
> > 
> > Regards,
> 
> in $prefix/etc/esd.conf
> add:
> 
> spawn_options=-as 10
> 

Hm, that is interesting. In my /etc/esound/esd.conf there are these
few lines:

[esd]
auto_spawn=0
spawn_options=-terminate -nobeeps -as 5
spawn_wait_ms=100

So esd already has -as parameter, but if I look in the process list I
see it started only as `esd -nobeeps'. I'll investigate further...

Thanks for the idea.
-- 
Zlatko
