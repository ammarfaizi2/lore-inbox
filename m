Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311554AbSCNIND>; Thu, 14 Mar 2002 03:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311555AbSCNIMx>; Thu, 14 Mar 2002 03:12:53 -0500
Received: from smtp-sec1.zid.nextra.de ([212.255.127.204]:30987 "EHLO
	smtp-sec1.zid.nextra.de") by vger.kernel.org with ESMTP
	id <S311554AbSCNIMl>; Thu, 14 Mar 2002 03:12:41 -0500
Date: Thu, 14 Mar 2002 09:12:04 +0100 (CET)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_SOUND_GAMEPORT in 2.5
In-Reply-To: <20020313182054.A31062@ucw.cz>
Message-ID: <Pine.LNX.4.33.0203140910150.15512-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > drivers/input/gameport/Config.in doesn't seem quite right to me, in
> > general and for ARM specifically:
> > if [ "$CONFIG_GAMEPORT" = "m" ]; then
> > 	define_tristate CONFIG_SOUND_GAMEPORT m
> > fi
> > if [ "$CONFIG_GAMEPORT" != "m" ]; then
> > 	define_tristate CONFIG_SOUND_GAMEPORT y
> > fi
> >
> > Could the maintainer please change this?
>
> What's the problem here?

The problem is, that if you don't have anything like a sound-card/gameport
at all, CONFIG_SOUND_GAMEPORT still will be YES. Ok, I didn't check in the
code, maybe it doesn't add a single byte to the kernel, .config looks a
bit confusing, doesn't it?

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

