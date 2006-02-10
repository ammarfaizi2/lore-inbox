Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWBJLER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWBJLER (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 06:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWBJLER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 06:04:17 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:48637 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751354AbWBJLEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 06:04:15 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 10 Feb 2006 12:02:59 +0100
To: schilling@fokus.fraunhofer.de, jengelh@linux01.gwdg.de
Cc: peter.read@gmail.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43EC72E3.nailISD4HI9WC@burner>
References: <200602031724.55729.luke@dashjr.org>
 <43E7545E.nail7GN11WAQ9@burner>
 <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de>
 <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner>
 <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner>
 <20060208162828.GA17534@voodoo> <43EA1D26.nail40E11SL53@burner>
 <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner>
 <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr>
 <43EB7210.nailIDH2JUBZE@burner>
 <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr>
 <43EB7BBA.nailIFG412CGY@burner>
 <Pine.LNX.4.61.0602091832500.30108@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602091832500.30108@yvahk01.tjqt.qr>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:


> Right. The question was rather like this:
> Say we have our non-stable /dev/sr0 mapping to /dev/sg0, and it has got BTL 
> 1,1,0. Now, if the user starts `cdrecord -dev=1,1,0`,
> `ls -l /proc/$(pidof -s cdrecord)/fd/` should show (and in fact did when I 
> used ide-scsi back then) /dev/sg0, right?
>
> If so, what's wrong with just opening /dev/sg0 directly (as per user 
> request, i.e. cdrecord -dev=/dev/sg0) and sending the scsi commands down 
> the fd?

As I did write _many_ times, this was done by the program "cdwrite" on Linux
in 1995 and as cdwrite did not check whether if actually got a CD writer,
cdwrite did destroy many hard disk drives just _because_ the /dev/sg* 
is non-stable.

People did not believe this and did write shell scripts with e.g. /dev/sg0 
inside and later suffered from the non-stable /dev/sg* <-> device relation.


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
