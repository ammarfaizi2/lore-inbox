Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291889AbSBTO4o>; Wed, 20 Feb 2002 09:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291888AbSBTO4e>; Wed, 20 Feb 2002 09:56:34 -0500
Received: from msp-dsl-42.datasync.com ([208.164.149.42]:15237 "HELO
	gulf.gulfsales.com") by vger.kernel.org with SMTP
	id <S291885AbSBTO4T>; Wed, 20 Feb 2002 09:56:19 -0500
From: "Glover George" <dime@gulfsales.com>
To: "'Mr. James W. Laferriere'" <babydr@baby-dragons.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: st0: Block limits 1 - 16777215 bytes.
Date: Wed, 20 Feb 2002 08:56:41 -0600
Message-ID: <003601c1ba1e$ce631630$0300a8c0@yellow>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <Pine.LNX.4.44.0202192005050.32040-100000@filesrv1.baby-dragons.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, after playing with it a little more I found out that the message I'm
getting about the block sizes isn't related to the lockups.  I can lock
the system up by tar'ing up the /proc directory (why are you tar'ing the
/proc directory!!! I know!!! But that's not the point).  I had no
problem with RH 7.2's supplied 7.2 kernel (2.4.7-10).  However, this is
2.4.17 (with the linux-abi patch). 

I have been able to make succesful backups as long as I ignore the /proc
directory but something must be wrong.  Doing an "ls -la *" doesn't lock
the machine though.  Only when tar'ing it (I suppose because of a read).
It doesn't lock up consistently in the same place when reading from the
proc directory however, but always in the proc.  I made about 15 test
runs and they all died in proc and --exclude proc doesn't cause it to
lock somewhere else.

I guess the question is (and I've had it for a while) is how do I get
the system to log more info for me?  I'm a little new a debugging the
kernel, but I did compile most of the debugging into a test kernel.
However, the system hard locks with no oops or anything in the logs.
The system must be shutdown by holding the power button in for 4
seconds. I know this must not be a huge problem because no ones
mentioned it, so I'd like to do some more investigating on my part.
Thanks for your help.

> 	Hello Glover ,  I get the same messages & do not get system
> 	lock ups .  Might try sending a little bit more info about
> 	what is going on around any of the lock ups .  If you can
> 	reliably lock up the system by accessing the tape drive .
> 	Then send some info to the list about the system & the tape
> 	drive and how it is attached to the system .  Hth ,  JimL
> ps:	All disk & tape drives are scsi .
> 
> 
> On Tue, 19 Feb 2002, Glover George wrote:
> 
> > I've been experiencing mysterious lockups since upgrading to kernel 
> > 2.4.17.  Looking in the /var/log/messages I hadn't seen anything 
> > suspicious until now.  I guess the machine hasn't had time to write 
> > this to disk except every now and then.  The message
> >
> > Feb 19 11:29:55 butler kernel: st0: Block limits 1 - 16777215 bytes.
> >
> > I notice this after rebooting after the crash.  So I tried manually 
> > doing a tar to the tape drive and was able to successfully lock the 
> > machine up.  Can someone help me understand this and if it 
> is simply a 
> > limit problem, why would the machine lock up?
> >

