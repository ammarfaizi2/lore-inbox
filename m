Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262213AbRE2ELB>; Tue, 29 May 2001 00:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbRE2EKw>; Tue, 29 May 2001 00:10:52 -0400
Received: from unthought.net ([212.97.129.24]:61594 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S262213AbRE2EKl>;
	Tue, 29 May 2001 00:10:41 -0400
Date: Tue, 29 May 2001 06:10:39 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: "G. Hugh Song" <ghsong@kjist.ac.kr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Plain 2.4.5 VM...
Message-ID: <20010529061039.D29962@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	"G. Hugh Song" <ghsong@kjist.ac.kr>, linux-kernel@vger.kernel.org
In-Reply-To: <200105290232.f4T2W9m00876@bellini.kjist.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <200105290232.f4T2W9m00876@bellini.kjist.ac.kr>; from ghsong@kjist.ac.kr on Tue, May 29, 2001 at 11:32:09AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2001 at 11:32:09AM +0900, G. Hugh Song wrote:
> 
> Jeff Garzik wrote: 
> > 
> > Ouch! When compiling MySql, building sql_yacc.cc results in a ~300M 
> > cc1plus process size. Unfortunately this leads the machine with 380M of 
> > RAM deeply into swap: 
> > 
> > Mem: 381608K av, 248504K used, 133104K free, 0K shrd, 192K 
> > buff 
> > Swap: 255608K av, 255608K used, 0K free 215744K 
> > cached 
> > 
> > Vanilla 2.4.5 VM. 
> > 
> 
> This bug known as the swap-reclaim bug has been there for a while since 
> around 2.4.4.  Rick van Riel said that it is in the TO-DO list.
> Because of this, I went back to 2.2.20pre2aa1 on UP2000 SMP.
> 
> IMHO, the current 2.4.* kernels should still be 2.3.*.  When this bug
> is removed, I will come back to 2.4.*.

Just keep enough swap around.  How hard can that be ?

Really, it's not like a memory leak or something.  It's just "late reclaim".

If Linux didn't do over-commit, you wouldn't have been able to run that job
anyway.

It's not a bug.  It's a feature.  It only breaks systems that are run with "too
little" swap, and the only difference from 2.2 till now is, that the definition
of "too little" changed.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
