Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRCFTnb>; Tue, 6 Mar 2001 14:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129434AbRCFTnV>; Tue, 6 Mar 2001 14:43:21 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:16914 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S129428AbRCFTnL>;
	Tue, 6 Mar 2001 14:43:11 -0500
Date: Tue, 06 Mar 2001 20:42:56 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: scsi vs ide performance on fsync's
To: torvalds@transmeta.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3AA53DC0.C6E2F308@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds himself wrote :

> On Tue, 6 Mar 2001, Alan Cox wrote: 
> > 
> > > > I don't know if there is any way to turn of a write buffer on an IDE disk. 
> > > You want a forced set of commands to kill caching at init? 
> > 
> > Wrong model 
> > 
> > You want a write barrier. Write buffering (at least for short intervals) in 
> > the drive is very sensible. The kernel needs to able to send drivers a write 
> > barrier which will not be completed with outstanding commands before the 
> > barrier. 
> 
> Agreed. 
> 
> Write buffering is incredibly useful on a disk - for all the same reasons 
> that an OS wants to do it. The disk can use write buffering to speed up 
> writes a lot - not just lower the _perceived_ latency by the OS, but to 
> actually improve performance too. 
> 
> But Alan is right - we needs a "sync" command or something. I don't know 
> if IDE has one (it already might, for all I know). 

ATA , SCSI and ATAPI all have a FLUSH_CACHE command. (*)
Whether the drives implement it is another question ...

(*) references : 
  ATA-6 draft standard from www.t13.org
  MtFuji document from ????????


-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
