Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266101AbSKUMu6>; Thu, 21 Nov 2002 07:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266153AbSKUMu6>; Thu, 21 Nov 2002 07:50:58 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:57871 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S266101AbSKUMu6>; Thu, 21 Nov 2002 07:50:58 -0500
Date: Thu, 21 Nov 2002 13:57:30 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Adrian Bunk <bunk@fs.tum.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 kconfig doesn't handle "&& m" correctly
In-Reply-To: <20021121083912.GE11952@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0211211350270.2113-100000@serv>
References: <20021121083912.GE11952@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 21 Nov 2002, Adrian Bunk wrote:

> config SOUND_WAVEFRONT
> 	tristate "Full support for Turtle Beach WaveFront (Tropez Plus, Tropez, Maui) synth/soundcards"
> 	depends on SOUND_OSS && m
> ...
> 
> <--  snip  -->
> 
> 
> It seems the "&& m" (a common way to ensure that something can only be
> built modular) isn't handled correctly.

Did you disable modules? When modules are disabled tristate symbols are 
treated like booleans, that means they are visible if the dependencies are 
different than 'n'. For this it should be possible to automatically add 
'&& MODULES' if the parser sees a 'm'. I'll have to check this out.

bye, Roman

