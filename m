Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316615AbSE0Nc3>; Mon, 27 May 2002 09:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316616AbSE0Nc2>; Mon, 27 May 2002 09:32:28 -0400
Received: from spook.vger.org ([213.204.128.210]:6305 "HELO
	kenny.worldonline.se") by vger.kernel.org with SMTP
	id <S316615AbSE0Nc0>; Mon, 27 May 2002 09:32:26 -0400
Date: Mon, 27 May 2002 16:09:36 +0200 (CEST)
From: me@vger.org
To: Simen Timian Thoresen <simentt@dolphinics.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/hd[ijkl] only using udma (not udma 100)
In-Reply-To: <200205271322.g4RDMgi11561@scispor.dolphinics.no>
Message-ID: <Pine.LNX.4.21.0205271606390.7794-100000@kenny.worldonline.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2002, Simen Timian Thoresen wrote:

> > I booted with:
> > linux ide0=autotune ide1=autotune ide2=autotune ide3=autotune
> > 
> > and now all drives are running just (U)DMA and speeds on the 3 first
> > droped to 15m/s.
> > 
> > The settings file you gave here, is there some possibility to configure
> > settings there? I see things like current_speed and init_speed that would
> > be nice to try and tweak.
> > 
> I believe that file is read only, and that the changes are made with hdparm or 
> autotune.
> 
> I have not tried to change anything yet (I first noticed this yesterday while 
> replacing disks in a raid), but I'll have a go with hdparm when I get home and 
> see what I can shake up.
> 
> I believe you can set trasfer-mode directly using hdparm -x<mode>, but I 
> don't see why the kernel should not set this by default.
> 

Well, as i read the ide .c i see that preconfigureation (if you can call
it that, more like what drives/interfaces do we assume is there), i only
see that for ide0-3. Now ide0-1 is onboard and ide1-2 is the first ide
card but nothing is made with ide4-5 which is the second ide card and i
think that the problem.

It would realy be nice to find a way to force transfer mode on boot up but
i cant see to find any way.



