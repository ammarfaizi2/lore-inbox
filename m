Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbTGCTTf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 15:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265297AbTGCTTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 15:19:34 -0400
Received: from 200-204-171-188.insite.com.br ([200.204.171.188]:27657 "HELO
	proxy.inteliweb.com.br") by vger.kernel.org with SMTP
	id S265269AbTGCTTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 15:19:19 -0400
Message-ID: <018901c3419a$69efd440$3300a8c0@Slepetys>
From: "Roberto Slepetys Ferreira" <slepetys@homeworks.com.br>
To: <linux-kernel@vger.kernel.org>
Cc: <jguerrero@live365.com>
References: <3EDFDDBA.2060706@live365.com> <3F0475F7.1070208@nospam.com>
Subject: Re: PROBLEM:  2.4.20 os hang when accessing local ide harddrive
Date: Thu, 3 Jul 2003 16:36:35 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guerrero,

I am having some hangs with the 2.4.20 kernel without isolatting the source
of the trouble.

Is there any strange message at /var/log/message ? How do you concluded that
is the IDE drive ?

In my linux box, it halts without any clue of what is going on. First I
thank that the trouble was with AIC7xxx and SCSI drives, because of a
correlation of large I/O and linux halt, but after a big help from Justin
Gibbs, when I upgraded the AICxxx module to the newer, the system hangs
without the old message: Locking max tag count...

[]s
Slepetys


----- Original Message ----- 
From: "John E. Leon Guerrero" <jguerrero-useatsign-live365.com@nospam.com>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, July 03, 2003 3:29 PM
Subject: Re: PROBLEM: 2.4.20 os hang when accessing local ide harddrive


> whoops...looks like this made it to linux.kernel according to google.  i
> thought i was emailing a moderator with whom i'd elaborate further about
> the problem :)
>
> what i did not mention in the first posting is that the processes that
> do not touch the "frozen drive" continue to work fine for a couple of
> minutes before the entire machine freezes including those that do not
> use the "frozen drive".  in fact, the machine works great so long as i
> avoid the frozen drive.  accessing the idle ide drives is the catalyst
> which initiates the eventual machine hang.
>
> the hang can start by trying to list a directory on the ide drive.  once
> that happens, the ls process cannot be killed.  if i try to strace the
> ls process, then the strace process also becomes hung and unresponsive
> to control-c.  i'm not sure why, but eventually the machine will hang
> including those processes that do not access the ide drive.  in fact,
> when my oracle database is down, there is nothing that accesses the ide
> drives.  the database is normally down since it's a test instance.
>
> i've noticed 2 ways that the ide drives freeze.
> 1. after the machine has been idle all night, i'll go take a look at the
> ide filesystem and the hang will begin.
> 2. while doing an installation to the ide drive which writes about 2gb
> of data, the drive will hang eventually.
>
> i do not doubt that faulty hardware could be involved.  i tried changing
> the harddrive which resulted in basically the same failure...just
> delayed some.  it's also possible that the drive's hardware problem
> triggers a more general hardware failure which involves the
> motherboard/cpu/memory, etc in which case i would fully expect the
> machine to hang like it does.
>
> on a related note, i had seen a similar "drive hangs and soon after all
> processes stop responding" problem on a different machine (completely
> different hardware) when i tried to mount a floppy.  on this 2nd
> machine, that one hang is the only time that it ever happened.  the
> first machine will hang with relatively predictable frequency.
>
> i only raise this issue from the perspective of a production server
> where partial service availability might be desireable until a planned
> service outage could be scheduled to service a faulty drive.
>
> if this case is at all interesting to pursue, then i would be happy to
> help out debugging it with guidance.
>


