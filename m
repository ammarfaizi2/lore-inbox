Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316940AbSE1VP2>; Tue, 28 May 2002 17:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316938AbSE1VP0>; Tue, 28 May 2002 17:15:26 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:62873 "EHLO
	postfix1-2.free.fr") by vger.kernel.org with ESMTP
	id <S316941AbSE1VOh>; Tue, 28 May 2002 17:14:37 -0400
Message-Id: <200205282113.g4SLD6n05000@colombe.home.perso>
Date: Tue, 28 May 2002 23:13:03 +0200 (CEST)
From: fchabaud@free.fr
Reply-To: fchabaud@free.fr
Subject: Re: 2.4.19-pre8-ac5 swsusp panic
To: pavel@suse.cz
Cc: matthias.andree@stud.uni-dortmund.de, linux-kernel@vger.kernel.org
In-Reply-To: <20020527140111.G35@toy.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 27 Mai, Pavel Machek a écrit :
> Hi!
> 
>> > I tried SysRq-D and finally got a kernel "panic: Request while ide driver
>> > is blocked?"
>> > 
>> > Before that, I saw "waiting for tasks to stop... suspending kreiserfsd",
>> > nfsd exiting, "Freeing memory", "Syncing disks beofre copy", then some
>> > "Probem while suspending", then some "Resume" and finally the panic.
>> > 
>> > It may be worth noting that one swap partition is on a SCSI drive, and
>> > that my IDE drives were in standby (not idle) mode, i. e. their spindle
>> > motors were stopped.
>> > 
>> 
>> AFAIK swap partition under SCSI is not supported for the moment.
> 
>  can you elaborate? swsusp ddoes not careif it is scsi on ide and I had it
> running on usb-storage device at one point.
> 								Pavel
> 

Well we haven't the equivalent to ide_disk_(un)suspend. I agree that
this should be sufficient to make it work, but SCSI may be a little more
difficult to patch.

--
Florent Chabaud         ___________________________________
SGDN/DCSSI/SDS/LTI     | florent.chabaud@polytechnique.org
http://www.ssi.gouv.fr | http://fchabaud.free.fr

