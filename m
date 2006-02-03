Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWBCOIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWBCOIr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 09:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWBCOIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 09:08:47 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:22947 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750825AbWBCOIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 09:08:46 -0500
Date: Fri, 3 Feb 2006 15:08:32 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Luke-Jr <luke@dashjr.org>
cc: Matthias Andree <matthias.andree@gmx.de>,
       Lee Revell <rlrevell@joe-job.com>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest) (was:
 Rationale for RLIMIT_MEMLOCK?)
In-Reply-To: <200602021717.08100.luke@dashjr.org>
Message-ID: <Pine.LNX.4.61.0602031502000.7991@yvahk01.tjqt.qr>
References: <20060123105634.GA17439@merlin.emma.line.org>
 <20060123212119.GI1820@merlin.emma.line.org> <Pine.LNX.4.61.0601241823390.28682@yvahk01.tjqt.qr>
 <200602021717.08100.luke@dashjr.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-421540535-1138975712=:7991"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-421540535-1138975712=:7991
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

>> >2. find out the current state of affairs,
>>
>> I am currently able to properly write all sorts of CD-R/RW and DVD±R/RW,
>> DVD-DL with no problems using
>>     cdrecord -dev=/dev/hdb
>> it _currently_ works, no matter how ugly or not this is from either Jörg's
>> or any other developer's POV - therefore it's fine from the end-user's POV.
>
>How did you manage to burn a dual layer disc? I have been completely 
>unsuccessful at doing this at all. :(
>

You have to add  -driver=mmc_dvdplusr , because the Dual Layer discs are 
not yet in the ProDVD database as it seems.

>> I'm fine (=I agree) with the general possibility of having it setuid,
>> though.
>
>Provided it doesn't allow burning files the real-user shouldn't be able to 
>access... But since cdrecord is commonly suid-root, I presume this has long 
>been taken into consideration.
>
Security-critical environments like data centers either have a Windows 
NT-style machine providing <enter whacky burning software here>, or they 
've got a specialized machine that is marked "use for cd burning - note 
security implications". Usually there is no problem with that as in that 
case, you should remove your ISO you copied over for writing after writing.

>> SUSE currently does it in A Nice Way: setfacl'ing the devices to include
>> read access for currently logged-in users. (Well, if someone logs on tty1
>> after you, you're screwed anyway - he could have just ejected the cd when
>> he's physically at the box.)
>
>Aren't user-groups per-session anyway? Why not simply have the login program 
>apply a 'localusers' group to all local sessions and set device permissions 
>for that group?

userwhat? You mean supplemental groups as printed by id(1)? I find them 
ugly, because it's a real hassle to manage it with files.

In the past, NGROUPS_MAX also was 32, being more of a limit than today.

>To add to the security, perhaps there is a way to remove the 
>'localusers' permissions from all backgrounded processes (screen, etc) when 
>the user logs out?
>


Jan Engelhardt
-- 
--1283855629-421540535-1138975712=:7991--
