Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423432AbWBBJyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423432AbWBBJyJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 04:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423429AbWBBJyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 04:54:08 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60646 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1161125AbWBBJyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 04:54:06 -0500
Date: Thu, 2 Feb 2006 10:54:05 +0100
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: jengelh@linux01.gwdg.de, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, James@superbug.co.uk, j@bitron.ch,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <mj+md-20060202.094513.20698.atrey@ucw.cz>
References: <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <43DDFBFF.nail16Z3N3C0M@burner> <1138642683.7404.31.camel@juerg-pd.bitron.ch> <43DF3C3A.nail2RF112LAB@burner> <mj+md-20060131.104748.24740.atrey@ucw.cz> <43DF65C8.nail3B41650J9@burner> <Pine.LNX.4.61.0602011612520.22529@yvahk01.tjqt.qr> <43E1D417.nail4MI11WTFI@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E1D417.nail4MI11WTFI@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Is there any reason why the people with small PCs should dominate the 
> people with big machines?
> 
> If you use /dev/hd*, you loose control after you add more than ~ 6-10 disks.

And this is why the current Linux naming scheme (udev etc.) gives you
the possibility to use both types of names.

When I have a single CD writer, it's silly to have to think about where
exactly it is connected. I refer to it as /dev/cdrw and everything is easy.

When I have multiple writers, I start to care about more -- but usually
it's still better to avoid using bus addresses (they are not too stable
-- after changing disks, I often end up with connecting my 2 CDWR's
to different controllers) and use udev to maintain stable naming.
I use /dev/cdrom-upper and /dev/cdrom-lower, which are assigned based
on manufacturer and serial number.

This is even easier to remember with a big amount of hardware :-)

And, which is more important, this scheme works for everything --
drives, mice, network interfaces and so on.

I don't see any reason why cdrecord on Linux should invent a different
naming scheme, especially as nobody has so far demonstrated any of its
advantages.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
MIPS: Meaningless Indicator of Processor Speed.
