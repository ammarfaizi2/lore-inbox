Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317201AbSFBPZ5>; Sun, 2 Jun 2002 11:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317202AbSFBPZ4>; Sun, 2 Jun 2002 11:25:56 -0400
Received: from pD9E239B5.dip.t-dialin.net ([217.226.57.181]:59063 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317201AbSFBPZ4>; Sun, 2 Jun 2002 11:25:56 -0400
Date: Sun, 2 Jun 2002 09:25:54 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Need help tracing regular write activity in 5 s interval
Message-ID: <Pine.LNX.4.44.0206020922410.29405-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> So: is there any trace software that can tell me "at 15:52:43.012345,
> process 4321 marked 7 blocks dirty on device /dev/hda5" (or even more
> detail so I can figure if it's just an atime update -- as with svscan --
> or a write access)? And that is NOT to be attached to a specific process
> (hint: strace is not an option).

Problem: we'd have to do that using printk. printk issues another write 
call, which will mark things dirty. Issued is another printk, which marks 
things dirty and issues another printk...

I suppose one write would become looped here?

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere

