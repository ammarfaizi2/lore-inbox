Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311935AbSCOGIu>; Fri, 15 Mar 2002 01:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311936AbSCOGIk>; Fri, 15 Mar 2002 01:08:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53766 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311935AbSCOGIa>;
	Fri, 15 Mar 2002 01:08:30 -0500
Date: Fri, 15 Mar 2002 06:08:29 +0000
From: Joel Becker <jlbec@evilplan.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: frankeh@watson.ibm.com, matthew@hairy.beasts.org,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] Re: futex and timeouts
Message-ID: <20020315060829.L4836@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Rusty Russell <rusty@rustcorp.com.au>, frankeh@watson.ibm.com,
	matthew@hairy.beasts.org, linux-kernel@vger.kernel.org,
	lse-tech@lists.sourceforge.net
In-Reply-To: <20020314151846.EDCBF3FE07@smtp.linux.ibm.com> <E16lkRS-0001HN-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16lkRS-0001HN-00@wagner.rustcorp.com.au>; from rusty@rustcorp.com.au on Fri, Mar 15, 2002 at 04:39:50PM +1100
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 04:39:50PM +1100, Rusty Russell wrote:
> Yep, sorry, my mistake.  I suggest make it a relative "struct timespec
> *" (more futureproof that timeval).  It would make sense to split the
> interface into futex_down and futex_up syuscalls, since futex_up
> doesn't need a timeout arg, but I haven't for the moment.

	Why waste a syscall?  The user is going to be using a library
wrapper.  They don't have to know that futex_up() calls sys_futex(futex,
FUTEX_UP, NULL);

Joel

-- 

Life's Little Instruction Book #182

	"Be romantic."

			http://www.jlbec.org/
			jlbec@evilplan.org
