Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130859AbQJaXWp>; Tue, 31 Oct 2000 18:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130886AbQJaXWh>; Tue, 31 Oct 2000 18:22:37 -0500
Received: from chiara.elte.hu ([157.181.150.200]:51207 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130859AbQJaXWW>;
	Tue, 31 Oct 2000 18:22:22 -0500
Date: Wed, 1 Nov 2000 01:32:21 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: root@chaos.analogic.com, Andi Kleen <ak@suse.de>,
        Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <39FF5259.822F28FF@timpanogas.org>
Message-ID: <Pine.LNX.4.21.0011010129010.18143-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 31 Oct 2000, Jeff V. Merkey wrote:

> > One could create a 'kernel' that does:
> >         for(;;)
> >         {
> >           proc0();
> >           proc1();
> >           proc2();
> >           proc3();
> >           etc();
> >         }
> 
> would be coded like this (no C compiler):
> 
> proc0:
> 
> proc1:
> 
> proc2:
> 
> proc3:
> 
> etc:
> 
> label:
>      jmp  proc0

oh, and what happens if it turns out that some other place wants to call
proc3 as well? Recode the assembly - cool! Not.

> I just avoided 5 x 20 bytes of pushes and pops on the stack ad optimized
> for a simple fall through case.  

FYI, GCC does not generate 5 x 20 bytes of pushes and pops. In fact in the
above specific case it will not generate a single push (automatically -
you dont have to worry about it).

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
