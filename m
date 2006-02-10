Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWBJNNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWBJNNz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 08:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWBJNNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 08:13:55 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:18884 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932081AbWBJNNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 08:13:54 -0500
Date: Fri, 10 Feb 2006 14:13:50 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: peter.read@gmail.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43EC72E3.nailISD4HI9WC@burner>
Message-ID: <Pine.LNX.4.61.0602101412180.31246@yvahk01.tjqt.qr>
References: <200602031724.55729.luke@dashjr.org> <43E7545E.nail7GN11WAQ9@burner>
 <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de>
 <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner>
 <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner>
 <20060208162828.GA17534@voodoo> <43EA1D26.nail40E11SL53@burner>
 <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner>
 <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr> <43EB7210.nailIDH2JUBZE@burner>
 <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr> <43EB7BBA.nailIFG412CGY@burner>
 <Pine.LNX.4.61.0602091832500.30108@yvahk01.tjqt.qr> <43EC72E3.nailISD4HI9WC@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Right. The question was rather like this:
>> Say we have our non-stable /dev/sr0 mapping to /dev/sg0, and it has got BTL 
>> 1,1,0. Now, if the user starts `cdrecord -dev=1,1,0`,
>> `ls -l /proc/$(pidof -s cdrecord)/fd/` should show (and in fact did when I 
>> used ide-scsi back then) /dev/sg0, right?
>>
>> If so, what's wrong with just opening /dev/sg0 directly (as per user 
>> request, i.e. cdrecord -dev=/dev/sg0) and sending the scsi commands down 
>> the fd?
>
>As I did write _many_ times, this was done by the program "cdwrite" on Linux
>in 1995 and as cdwrite did not check whether if actually got a CD writer,
>cdwrite did destroy many hard disk drives just _because_ the /dev/sg* 
>is non-stable.
>
>People did not believe this and did write shell scripts with e.g. /dev/sg0 
>inside and later suffered from the non-stable /dev/sg* <-> device relation.
>
Exactly. But, if I now say -dev=1,1,0 instead of e.g. -dev=/dev/sg0, who or 
what makes sure that 1,1,0 {is not | does not map to} a harddisk?


Jan Engelhardt
-- 
