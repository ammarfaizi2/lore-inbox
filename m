Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWBCN0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWBCN0z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 08:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWBCN0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 08:26:53 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:58317 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750745AbWBCN0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 08:26:52 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 03 Feb 2006 14:25:41 +0100
To: jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
Cc: schilling@fokus.fraunhofer.de, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, James@superbug.co.uk, j@bitron.ch,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43E359D5.nail5CAB7WYVL@burner>
References: <43DDFBFF.nail16Z3N3C0M@burner>
 <1138642683.7404.31.camel@juerg-pd.bitron.ch>
 <43DF3C3A.nail2RF112LAB@burner>
 <1138710764.17338.47.camel@juerg-t40p.bitron.ch>
 <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail>
 <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo>
 <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com>
 <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr>
 <20060202210949.GD10352@voodoo>
In-Reply-To: <20060202210949.GD10352@voodoo>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jim Crilly" <jim@why.dont.jablowme.net> wrote:

> I see the same thing with, the only external kernel patch I have
> applied is Suspend2. The ATA scanbus code tries to 
> open("/dev/hda", O_RDWR|O_NONBLOCK|O_EXCL) and that fails, and since
> the scanning code stops once one device fails to open the whole scan
> aborts. Apparently O_EXCL was added by Ubuntu and Debian to stop
> burns being corrupted by hald polling the device while a disc is
> being burned. If you want to read the entire thread it's bug #262678
> in Debian.

This is an excellent example to verify how bad Linux distribution developent
is done.....

Note that the main problem here is an applicaion unfriendly service 
on Linux that disturbes other applications like cdrecord.

As there is a bug in this service, I would expect that this bug should be fixed.
Instead of doing this or at least trying to get help from experienced people 
like me, some people did prefer to change cdrecord in a way that caused more
problems than it pretends to fix.

Note that the "requirement" for O_EXCL is a bad idea and needs fixing.
If you believe that this is impossible, just have a look at the OpenSolaris vold
and volfs subsystem.....

Note that Linux distributors apply other changes to cdrecord that causes 
problems in the same area: patching cdrecord to allow a grace time < 3 seconds
of course disallows a useful solution in this area.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
