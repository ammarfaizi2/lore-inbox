Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311557AbSCNITn>; Thu, 14 Mar 2002 03:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311559AbSCNITf>; Thu, 14 Mar 2002 03:19:35 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:31503 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S311557AbSCNITR>; Thu, 14 Mar 2002 03:19:17 -0500
Date: Thu, 14 Mar 2002 09:19:15 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Guennadi Liakhovetski <gl@dsa-ac.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_SOUND_GAMEPORT in 2.5
Message-ID: <20020314091915.C31998@ucw.cz>
In-Reply-To: <20020313182054.A31062@ucw.cz> <Pine.LNX.4.33.0203140910150.15512-100000@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0203140910150.15512-100000@pcgl.dsa-ac.de>; from gl@dsa-ac.de on Thu, Mar 14, 2002 at 09:12:04AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 09:12:04AM +0100, Guennadi Liakhovetski wrote:
> > > drivers/input/gameport/Config.in doesn't seem quite right to me, in
> > > general and for ARM specifically:
> > > if [ "$CONFIG_GAMEPORT" = "m" ]; then
> > > 	define_tristate CONFIG_SOUND_GAMEPORT m
> > > fi
> > > if [ "$CONFIG_GAMEPORT" != "m" ]; then
> > > 	define_tristate CONFIG_SOUND_GAMEPORT y
> > > fi
> > >
> > > Could the maintainer please change this?
> >
> > What's the problem here?
> 
> The problem is, that if you don't have anything like a sound-card/gameport
> at all, CONFIG_SOUND_GAMEPORT still will be YES. Ok, I didn't check in the
> code, maybe it doesn't add a single byte to the kernel, .config looks a
> bit confusing, doesn't it?

Yes, it doesn't add anything. It's just a switch that *disables*
gameport code in sound drivers if no gameport support is selected in the
kernel.

-- 
Vojtech Pavlik
SuSE Labs
