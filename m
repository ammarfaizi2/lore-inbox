Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129815AbQJ2Waz>; Sun, 29 Oct 2000 17:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129902AbQJ2Waq>; Sun, 29 Oct 2000 17:30:46 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:32261 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129815AbQJ2Wag>; Sun, 29 Oct 2000 17:30:36 -0500
Message-ID: <39FCA428.F89746F3@timpanogas.org>
Date: Sun, 29 Oct 2000 15:26:48 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Paul Mackerras <paulus@linuxcare.com.au>, linux-kernel@vger.kernel.org
Subject: Re: page->mapping == 0
In-Reply-To: <E13pz7a-0006JY-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:
> 
> > I would expect problems with truncate, mmap, rename, POSIX locks, fasync,
> > ptrace and mount go unnoticed for _long_. Ditto for parts of procfs
> 
> Well the ptrace one still has mysteriously breaks usermode linux against it
> on my list here. Was that ever explained. It looked like the stack got corrupted
> which is weird.

Do any of you guys have an SMP inverse assembler handy?  This bug is
scary as shit, and someone needs to setup an SMP ICE and actually trace
through the code (and set address breakpoints) to see just what is going
on.  It really is sounding like a race condition of some kind, and I
read everyone's "speculation" about what they think is happneing, but
how about getting some hardware tools, and tracking is down.  It feels
like an MMU bug of some type.  Who has access to Yellow Cover Intel
Errata sheets?  It may be a hardware bug intel knows about but we don't
-- their MMU is so bug infested how do we know it's not one of these.  

I don't think you guys have a good handle on it yet.  Linus seems to
think it's a coding problem with a race somewhere.  How about someone
getting some hardware tools and nailing the puppy to the floor so 2.4
can get out the door...

:-)

Jeff

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
