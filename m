Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272324AbRILSJ6>; Wed, 12 Sep 2001 14:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272415AbRILSJs>; Wed, 12 Sep 2001 14:09:48 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:2302
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S272338AbRILSJg>; Wed, 12 Sep 2001 14:09:36 -0400
Date: Wed, 12 Sep 2001 11:09:50 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Duron kernel crash (i686 works)
Message-ID: <20010912110950.D25683@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E15h9RE-0004Qe-00@the-village.bc.nu> <2415359415.20010912164800@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2415359415.20010912164800@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2001 at 04:48:00PM +0300, VDA wrote:
> >> A better way to do it is to bencmark several routines at
> >> startup time and pick the best one. It is done now
> >> for RAID xor'ing routine.

> AC> Not in this case. It is Athlon specific code. It was fine
> AC> tuned when it was written

> Yes, but sometimes we have routines which perform
> differently on different CPUs. See inslude/asm-i386/string.h
> and string-486.h: on Pentium rep movsd is faster, on 386 unrolled
> loop is faster... so optimal routine can be picked only at runtime.
> CPU-specific routines can compete in such runtime benchmark
> too when proper processor is detected - see how KNI-specific
> RAID xor routine does that.

Hmm, just how far do you want to take that?  Compile in all of the
optimizations and test which is fastest on each processor at startup?

Hmm, that might not be a bad idea for dev kernels, as it might show
optimization problems on certain processors...
