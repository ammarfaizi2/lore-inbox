Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262582AbRFNNRh>; Thu, 14 Jun 2001 09:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262609AbRFNNRR>; Thu, 14 Jun 2001 09:17:17 -0400
Received: from danielle.hinet.hr ([195.29.254.157]:14352 "EHLO
	danielle.hinet.hr") by vger.kernel.org with ESMTP
	id <S262582AbRFNNRO>; Thu, 14 Jun 2001 09:17:14 -0400
Date: Thu, 14 Jun 2001 15:17:10 +0200
From: Mario Mikocevic <mozgy@hinet.hr>
To: Juri Haberland <juri@koschikode.com>
Cc: linux-kernel@vger.kernel.org, haberland@altus.de, kraxel@bytesex.org
Subject: Re: Need a helping hand (realproducer and radio device)
Message-ID: <20010614151709.A30276@danielle.hinet.hr>
In-Reply-To: <20010614093405.C6467@danielle.hinet.hr> <20010614092617.12555.qmail@babel.spoiled.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010614092617.12555.qmail@babel.spoiled.org>; from juri@koschikode.com on Thu, Jun 14, 2001 at 09:26:17AM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > I have an Hauppauge WinTV/Radio card and I want to be able to use it's radio
> > device as a source for live broadcast.
> > 
> > It's RH71 distro updated with mainstream 2.4.5 .
> > 
> > Radio device works fine on it's own meaning that I can tune the station and
> > listen to it.
> > 
> > RealProducer (8.5) also works fine meaning that it encodes video inputs and Line-In
> > input into realmedia stream just fine.
> > 
> > The problem is that in startup realproducer mutes (IMO) or shuts down or something, that radio
> > device on bt8x8 card and therefore no actual audio signal gets to Line-In resulting in no audio
> > in realmedia stream.
> 
> I had a similar problem long time ago. The point is that the realproducer
> mutes the recording source in the mixer. Try to reenable it using aumix or
> a similar application.

Well, it seems that problem is not in muted device ->

before starting realproducer :

# aumix -q
vol 94, 94
pcm 94, 94
speaker 0, 0
line 93, 93, R
mic 0, 0, P
cd 0, 0, P
pcm2 0, 0
igain 0, 0, P
line1 0, 0, P
phin 0, 0, P
phout 0, 0
video 0, 0, P


after starting realproducer :

# aumix -q
vol 94, 94
pcm 50, 0
speaker 0, 0
line 93, 93, R
mic 0, 0, P
cd 0, 0, P
pcm2 0, 0
igain 0, 0, P
line1 0, 0, P
phin 0, 0, P
phout 0, 0
video 0, 0, P


if I get back those values with aumix I still don't get audio from radio device so it
must be something with bt8x8 radio part ->

# radio 88.1 <> /dev/null 
open /dev/radio: Device or resource busy

Gerd, can you help here please !?

-- 
Mario Mikoèeviæ (Mozgy)
My favourite FUBAR ...
