Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317283AbSGTAi4>; Fri, 19 Jul 2002 20:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317286AbSGTAi4>; Fri, 19 Jul 2002 20:38:56 -0400
Received: from stargazer.compendium-tech.com ([64.156.208.76]:26116 "EHLO
	stargazer.compendium.us") by vger.kernel.org with ESMTP
	id <S317283AbSGTAiG>; Fri, 19 Jul 2002 20:38:06 -0400
Date: Fri, 19 Jul 2002 17:40:20 -0700 (PDT)
From: Kelsey Hudson <khudson@compendium.us>
X-X-Sender: khudson@betelgeuse.compendium-tech.com
To: Kelledin <kelledin+LKML@skarpsey.dyndns.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Tyan s2466 stability
In-Reply-To: <200207182004.51402.kelledin+LKML@skarpsey.dyndns.org>
Message-ID: <Pine.LNX.4.44.0207191735040.2394-100000@betelgeuse.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2002, Kelledin wrote:

> On Thursday 18 July 2002 07:27 pm, Kelsey Hudson wrote:
> > according to the amd760mpx datasheet, stuff on the 32/33MHz
> > bus isn't allowed to busmaster while the 64/66MHz bus is
> > operating at 66MHz. so that means the 66MHz bus needs to be
> > throttled to 33MHz either via a 3.3V 33MHz card stuck in it,
> > or that pretty blue jumper stuffed on the appropriate FORCE
> > 33MHz header on the board.
> 
> VERY nice info, thanx. ;)
> 
> I'll have to save this info for myself; I've always been planning 
> to get a dual Athlon setup sooner or later.

Yeah, that was probably the biggest issue we had integrating these 
machines. That, and the need for a monstrous power supply to feed those 
power-hungry CPUs.

[ .. ]
> > if you need help integrating one of these boards into your
> > system i may be able to provide some insight.
> 
> Is this motherboard using the Phoenix, AMI, or Award BIOS?  Award 
> is nice and simple and solid; AMI is ok, but often goes too much 
> for pretty looks; Phoenix SUCKS in every way possible.

Alas, it's PhoenixBIOS. Phoenix bought Award, though, so I'd expect Award 
to be phased out :(

> What other issues have you encountered with this board (and other 
> 760MP/MPX boards)?  So far I've heard of an issue with 3com 
> Gigabit cards on some specific model of Tyan 760MP/MPX board, 
> but no definite details.  I've also heard of lm_sensors people 
> having a fair amount of trouble with it.

This is my only experience with a dual Athlon board. There were some minor 
issues in kernel-space when we first bought these machines; using a recent 
(>2.4.18) kernel causes these problems to mostly disappear.

I helped the lm_sensors team with the sensors on this board; after 
extensive experimentation I managed to get both of the sensors chips 
(which are at the same I2C address ... WTF was tyan thinking?!) working 
and displaying data. I still am unsure which temperature sensor monitors 
which peripheral, but I've got a pretty good idea of it.

If something strange comes up, LMK and I might have a solution for you.

-- 
 Kelsey Hudson                                       khudson@compendium.us
 Software Engineer/UNIX Systems Administrator
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------

