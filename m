Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129253AbQKARd3>; Wed, 1 Nov 2000 12:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130204AbQKARdT>; Wed, 1 Nov 2000 12:33:19 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:19213 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129253AbQKARdB>; Wed, 1 Nov 2000 12:33:01 -0500
Message-ID: <3A0052D3.32326393@timpanogas.org>
Date: Wed, 01 Nov 2000 10:28:51 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Andrea Arcangeli <andrea@suse.de>, Larry McVoy <lm@bitmover.com>,
        Paul Menage <pmenage@ensim.com>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <39FF49C8.475C2EA7@timpanogas.org>
	 <E13qj56-0003h9-00@pmenage-dt.ensim.com>
	 <39FF3D53.C46EB1A8@timpanogas.org>
	 <20001031140534.A22819@work.bitmover.com>
	 <39FF4488.83B6C1CE@timpanogas.org>
	 <20001031142733.A23516@work.bitmover.com>
	 <39FF49C8.475C2EA7@timpanogas.org> <5.0.0.25.2.20001101094152.03caed30@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Anton Altaparmakov wrote:
> 
>
> IMHO stability is more important than anything else. - I prefer to run 20
> Linux servers which will result in no phonecalls at midnight calling me
> into College to reboot them compared to a Netware server which runs as fast
> as the 20 Linux servers but disturbs my out-of-working-hours time!
> 
> I agree that having ring 0 OS will improve performance, no doubt about
> that, but at what price?
> 

It depends on how well we do out job.  I guess that's the real debate. 
Welcome back, 
how's things.

:-)

Jeff

> Just my 2p.
> 
> Anton
> 
> >And on sane architectures like alpha you don't even need to flush the TLB
> >during "real" context switching so all your worry to share the same VM for
> >everything is almost irrelevant there since it happens all the time anyways
> >(until you overflow the available ASN bits that takes a lots of forks to
> >happen).
> >
> >So IMHO for you it's much saner to move all your performance critical code
> >into
> >kernel space (that will be just stability-risky enough as khttpd and tux are).
> >In 2.4.x that will avoid all the cr3 reloads and that will be enough as what
> >you really care during fileserving are the copies that you must avoid.
> >
> >Andrea
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >Please read the FAQ at http://www.tux.org/lkml/
> 
> --
>       "Education is what remains after one has forgotten everything he
> learned in school." - Albert Einstein
> --
> Anton Altaparmakov  Voice: +44-(0)1223-333541(lab) / +44-(0)7712-632205(mobile)
> Christ's College    eMail: AntonA@bigfoot.com / aia21@cam.ac.uk
> Cambridge CB2 3BU    ICQ: 8561279
> United Kingdom       WWW: http://www-stu.christs.cam.ac.uk/~aia21/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
