Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129713AbQKAVg2>; Wed, 1 Nov 2000 16:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131541AbQKAVgS>; Wed, 1 Nov 2000 16:36:18 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:61709 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129713AbQKAVgP>; Wed, 1 Nov 2000 16:36:15 -0500
Message-ID: <3A008BEB.D33EE394@timpanogas.org>
Date: Wed, 01 Nov 2000 14:32:27 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@innominate.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <39FF3D53.C46EB1A8@timpanogas.org> <20001031140534.A22819@work.bitmover.com> <39FF4488.83B6C1CE@timpanogas.org> <20001031142733.A23516@work.bitmover.com> <39FF49C8.475C2EA7@timpanogas.org> <20001101023010.G13422@athlon.random> <20001031183809.C9733@.timpanogas.org> <20001101164106.F9774@athlon.random> <3A005217.88D2CA0D@timpanogas.org> <3A005476.17F0F253@timpanogas.org> <20001101190732.A19767@athlon.random> <3A00621F.7CC77F5A@timpanogas.org> <news2mail-3A008792.BAA8F70D@innominate.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Daniel Phillips wrote:
> 
> "Jeff V. Merkey" wrote:
> >
> > Andrea Arcangeli wrote:
> > >
> > > Speaking only for myself: on the technical side I don't think you can't be much
> > > faster than moving the performance critical services into the kernel and by
> > > skipping the copies (infact I also think that for fileserving skipping the
> > > copies and making sendfile to work and to work in zero copy will be enough).
> > > So I don't think losing robusteness this way can be explained in any technical
> > > way and no, it's not by showing me money that you'll convince me that's a good
> > > idea.
> >
> > This would help, but not as much as full ring 0.
> 
> My experience is that I can get pretty much the same performance in ring
> 3 as ring 0 as long as I don't reload segment registers or take CR3.  Is
> this right, or am I missing some fundamental kind of ring 3 overhead?
> 
> Even in ring 0, you can mostly protect processes from each other using
> segments: if you don't reload the segments you can restrict damage to
> your own segment.  It's not 100% safety but it is an enormous
> improvement over running in the same address space as the OS kernel.  I
> don't have any problem at all with the idea of running a lot of parallel
> tasks in the same address space: the safety of this comes down to the
> compiler you use to compile the processes.  If the compiler doesn't have
> ops that let processes damage each other then you won't get damage,
> assuming no bugs in your underlying implementation.
> 
> BTW, let me add my 'me too': go for it, there is obviously a pot of gold
> there, just don't let Sauron^H^H^H^H^H^H Bill get to it first.


Amen to that one.  BTW.  The package we mailed out to you from Brian
went yesterday.  Let me know when it arrives.  I sent it to the address
in Berlin you provided.     

:-)

Jeff

> 
> --
> Daniel
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
