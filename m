Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133068AbRECQrG>; Thu, 3 May 2001 12:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133098AbRECQq4>; Thu, 3 May 2001 12:46:56 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:21018 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S133068AbRECQqu>; Thu, 3 May 2001 12:46:50 -0400
Date: Thu, 3 May 2001 18:46:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Cabaniols, Sebastien" <Sebastien.Cabaniols@Compaq.com>
Cc: "'Andrew Morton'" <andrewm@uow.edu.au>,
        "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'davem@redhat.com'" <davem@redhat.com>,
        "'kuznet@ms2.inr.ac.ru'" <kuznet@ms2.inr.ac.ru>
Subject: Re: [BUG] freeze Alpha ES40 SMP 2.4.4.ac3, another TCP/IP Problem ? ( was 2.4.4 kernel crash , possibly tcp related )
Message-ID: <20010503184610.T1162@athlon.random>
In-Reply-To: <1FF17ADDAC64D0119A6E0000F830C9EA04B3CDD1@aeoexc1.aeo.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1FF17ADDAC64D0119A6E0000F830C9EA04B3CDD1@aeoexc1.aeo.cpqcorp.net>; from Sebastien.Cabaniols@Compaq.com on Thu, May 03, 2001 at 06:16:02PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2001 at 06:16:02PM +0200, Cabaniols, Sebastien wrote:
> The only thing that does not work under load is the network.... TCP/IP ?

My alpha is running 2.4.4aa3 under very high load (apache beaten from ab
in loop via 100mbit switched network [tulip on the alpha] plus cerberus)
and I didn't had any problem so far (it only deadlocked with OOM after
one day of day of tux [instead of apache] + cerberus regression testing
but that's only because of a memleak in tux that I reproduced on x86 too
it seems)

I'm going to release soon a 2.4.5pre1aa1 that will compile with modules
as well. The only annoying thing is that UP kernel compiles seems not to
boot but I hope that will be fixed soon too.

So I doubt the problem is the tcp stack, it may not be the driver but it
shouldn't be a generic bug in vanilla 2.4.4 at least.

Andrea
