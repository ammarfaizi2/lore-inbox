Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131640AbRA1Abx>; Sat, 27 Jan 2001 19:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133036AbRA1Abe>; Sat, 27 Jan 2001 19:31:34 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:46096 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131640AbRA1Ab1>; Sat, 27 Jan 2001 19:31:27 -0500
Date: Sat, 27 Jan 2001 20:41:55 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: David Ford <david@linux.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: VM breakdown, 2.4.0 family
In-Reply-To: <3A727AF9.22B09950@linux.com>
Message-ID: <Pine.LNX.4.21.0101272039340.12703-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 27 Jan 2001, David Ford wrote:

> Since the testN series and up through ac12, I experience total loss of
> control when memory is nearly exhausted.
> 
> I start with 256M and eat it up with programs until there is only about
> 7 megs left, no swap.  From that point all user processes stall and the
> disk begins to grind nonstop.  It will continue to grind for about 25-30
> minutes until it goes completely silent.  No processes get killed, no VM
> messages are emitted.
> 
> The only recourse is the magic key.  If I reboot before the disk goes
> silent I can cleanly kill X with sysrq-E and restart.
> 
> If I wait until it goes silent, all is lost.  I have to sysrq-SUB.
> 
> Note, I do not have ANY swap enabled for these tests.
> 


Could you try this patch and tell the result?

http://bazar.conectiva.com.br/~marcelo/patches/v2.4/2.4.1pre10/bg_page_aging.patch

Thanks

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
