Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269786AbRHaXxg>; Fri, 31 Aug 2001 19:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269795AbRHaXx0>; Fri, 31 Aug 2001 19:53:26 -0400
Received: from barbados.bluemug.com ([63.195.182.101]:54281 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S269786AbRHaXxN>; Fri, 31 Aug 2001 19:53:13 -0400
Date: Fri, 31 Aug 2001 16:53:29 -0700
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] processes with shared vm
Message-ID: <20010831165329.I16749@bluemug.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <997973469.7632.10.camel@pc-16.suse.lists.linux.kernel> <oupelqbw0z4.fsf@pigdrop.muc.suse.de> <998038019.7627.21.camel@pc-16.office.scali.no> <36530000.998058370@baldur> <20010817225537.B2429@gruyere.muc.suse.de> <6400000.998082950@baldur>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6400000.998082950@baldur>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2001 at 04:15:50PM -0500, Dave McCracken wrote:
> --On Friday, August 17, 2001 22:55:37 +0200 Andi Kleen <ak@suse.de> wrote:
> 
> >Also gtop should display correct results even with the programs
> >that don't use CLONE_THREAD.
> 
> Are there any programs that use CLONE_VM and not CLONE_THREAD?

Yes, I have written an emulation layer for an embedded OS which
does its own preemptive scheduling using signals.  It uses CLONE_VM
but not CLONE_THREAD or CLONE_SIGHAND.  Currently it is very
painful to debug with gdb :-(, although the multithreaded core
dumps in -ac are a godsend.

miket
