Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313675AbSD3Qbo>; Tue, 30 Apr 2002 12:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313676AbSD3Qbn>; Tue, 30 Apr 2002 12:31:43 -0400
Received: from h24-78-175-24.vn.shawcable.net ([24.78.175.24]:9345 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S313675AbSD3Qbn>;
	Tue, 30 Apr 2002 12:31:43 -0400
Date: Tue, 30 Apr 2002 09:32:04 -0700
From: Simon Kirby <sim@netnation.com>
To: Karel Kulhavy <clock@ghost.cybernet.cz>
Cc: linux-kernel@vger.kernel.org,
        ALSA development <alsa-devel@alsa-project.org>
Subject: Re: GUS anti-noise hack
Message-ID: <20020430163204.GA12258@netnation.com>
In-Reply-To: <20020430182134.C22103@ghost.cybernet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2002 at 06:21:34PM +0200, Karel Kulhavy wrote:

> The linux GUS driver sometimes begins to make a white noise in right or left
> channel. It is very annoying because it is very remarkable and is there for
> every mp3 you listen to.
> 
> I have developped a hack how to get rid of it when it happens.
> 
> a:
> 
> cat /dev/urandom > /dev/dsp and wait for an audible chirp in the bad
> channel. Then try to play some mp3. If noise persists, goto a;
> 
> It has worked for me already for two times and I spared myself two reboots :)

Is this the ALSA driver?  I may be having the same problem.

With the OSS driver it mostly works, but changing mixer settings during
lpayback causes stereo timing skewing, which is extremely noticeable with
headphones even after changing the volume two or three times.  (The
music sounds like it's moving to one side.)

With the ALSA driver, about 25% of the time after starting MP3 playback,
the right channel (right channel only) will start playing an incorrect
part of the GUS memory and sound like old data or uninitialized memory. 
Stopping and starting playback usually fixes this (stopping and starting
will eventually always fix it).  Quite annoying. :)

(Also, multiple open in the GUS driver is completely broken and freezes
my machine right now.  A few years back it used to work properly.)

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
