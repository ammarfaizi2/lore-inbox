Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263344AbRFTAEP>; Tue, 19 Jun 2001 20:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264447AbRFTAEG>; Tue, 19 Jun 2001 20:04:06 -0400
Received: from kaboom.dsl.xmission.com ([166.70.14.108]:52815 "HELO
	mail.oobleck.net") by vger.kernel.org with SMTP id <S263344AbRFTAEC>;
	Tue, 19 Jun 2001 20:04:02 -0400
Date: Tue, 19 Jun 2001 18:04:21 -0600 (MDT)
From: Chris Ricker <kaboom@gatech.edu>
Reply-To: Chris Ricker <kaboom@gatech.edu>
To: "David S. Miller" <davem@redhat.com>
Cc: Jonathan Lundell <jlundell@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
In-Reply-To: <15151.48287.782428.953466@pizda.ninka.net>
Message-ID: <Pine.LNX.4.33.0106191801240.7174-100000@verdande.oobleck.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2001, David S. Miller wrote:

> <axe_grind>
>
> Don't believe me that Solaris sucks here?  Run this experiment under
> Solaris-latest and Linux on a sparc64 system (using lmbench):
>
> Under Solaris: ./lat_proc fork
> Under Linux: strace -f ./lat_proc fork
>
> I bet the Linux case does better than the Solaris run by some orders
> of magnitude.  That's how poor their fork/exit/switch code is.
>
> </axe_grind>

It's a very impressive difference:

Script started on Tue Jun 19 17:49:30 2001
[kaboom@thing2 linux]$ ./lat_proc fork
Process fork+exit: 563.7778 microseconds
[kaboom@thing2 linux]$ ./lat_proc fork
Process fork+exit: 565.5556 microseconds
[kaboom@thing2 linux]$ ./lat_proc fork
Process fork+exit: 568.0000 microseconds
[kaboom@thing2 linux]$ exit
Script done on Tue Jun 19 17:49:46 2001

Script started on Tue 19 Jun 2001 05:51:38 PM MDT
[kaboom@thing1 solaris]$ ./lat_proc fork
Process fork+exit: 4249.5000 microseconds
[kaboom@thing1 solaris]$ ./lat_proc fork
Process fork+exit: 4212.5000 microseconds
[kaboom@thing1 solaris]$ ./lat_proc fork
Process fork+exit: 4241.0000 microseconds
[kaboom@thing1 solaris]$ exit
script done on Tue 19 Jun 2001 05:52:19 PM MDT

thing1 and thing2 are identical Sun Blade 100s.  thing1 is running Solaris 8
(04/01 release), while thing2 is running 2.4.4 (Debian/unstable).

later,
chris

-- 
Chris Ricker                                               kaboom@gatech.edu
                                                          chris@gurulabs.com


