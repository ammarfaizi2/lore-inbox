Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129591AbRBAINS>; Thu, 1 Feb 2001 03:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129580AbRBAINJ>; Thu, 1 Feb 2001 03:13:09 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:9234
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129591AbRBAINC>; Thu, 1 Feb 2001 03:13:02 -0500
Date: Thu, 1 Feb 2001 00:12:28 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Tom Leete <tleete@mountain.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Ford <david@linux.com>,
        Stephen Frost <sfrost@snowman.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x and SMP fails to compile (`current' undefined)
In-Reply-To: <3A7915AF.5C9C54CF@mountain.net>
Message-ID: <Pine.LNX.4.10.10102010011530.15351-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make it and I will care and post it on kernel.org for you.
I need that patch soon.

On Thu, 1 Feb 2001, Tom Leete wrote:

> Alan Cox wrote:
> > 
> > > It's not an incompatibility with the k7 chip, just bad code in
> > > include/asm-i386/string.h. in_interrupt() cannot be called from there.
> > 
> > The string.h code was fine, someone came along and put in a ridiculous loop
> > in the include dependancies and broke it. Nobody has had the time to untangle
> > it cleanly since
> 
> Yes, bitrot. I don't see a rearrangement of system headers happening in 2.4.
> I'm pretty sure if I committed such a patch it would have no measurable
> lifetime.
> 
> > 
> > > I have posted a patch here many times since last May. Most recent was
> > > Saturday.
> > 
> > uninlining the code is too high a cost.
> 
> I question that. Athlon does branch prediction on call targets, function
> calls are cheap. 3dnow saves 25%-50% of cycles on a copy. How many function
> calls can be paid for with 1000 cycles or so?
> 
> My patch still inlines the standard string const_memcpy for the case of
> small known length.
> 
> If I configure SMP for a UP box, performance is clearly not my first
> concern. If I have a real SMP Athlon system, performance should not improve
> by only using one processor.
> 
> How about we get it to build before we optimize it?
> 
> Regards,
> Tom
> 
> -- 
> The Daemons lurk and are dumb. -- Emerson
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
