Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131503AbQLHELA>; Thu, 7 Dec 2000 23:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131623AbQLHEKv>; Thu, 7 Dec 2000 23:10:51 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:37636 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131503AbQLHEKo>; Thu, 7 Dec 2000 23:10:44 -0500
Message-ID: <3A303F7E.1984E8F6@timpanogas.org>
Date: Thu, 07 Dec 2000 18:55:10 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>, Rainer Mager <rmager@vgkk.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Signal 11
In-Reply-To: <E144BOL-0003Eg-00@the-village.bc.nu> <NEBBJBCAFMMNIHGDLFKGMEFHCIAA.rmager@vgkk.com> <20001208022044.A6417@gruyere.muc.suse.de> <3A303852.790E3CE4@timpanogas.org> <20001208024018.A6673@gruyere.muc.suse.de> <3A303CAD.5600DE5A@timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"Jeff V. Merkey" wrote:
> 
> > So have you enabled core dumps and actually looked at the core dumps
> > of the programs using gdb to see where they crashed ?
> 
> Yes.  I can only get the SSH crash when I am running remotely from the
> house over the internet, and it only shows then when running a build in
> jobserver mode (parallel build).  The X problem seems related as well,
> since it's related to (usually) NetScape spawing off a forked process.
> I will attempt to recreate tonight, and post the core dump file.

BTW.  Were I to wager a guess, I would guess it's related to the paging
problems in 2.4 when a process gets cloned, since everytime I have seen
it, it happens when a child process gets forked then accesses the cloned
data from the parent.  In the previous core dumps, it always puked right
after a call to fork() when the child process attempted to WRITE (not
read) data in the program.

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
