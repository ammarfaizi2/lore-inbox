Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132846AbRDDPuv>; Wed, 4 Apr 2001 11:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132849AbRDDPur>; Wed, 4 Apr 2001 11:50:47 -0400
Received: from atlrel2.hp.com ([156.153.255.202]:61429 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S132846AbRDDPtR>;
	Wed, 4 Apr 2001 11:49:17 -0400
Message-ID: <3ACB4278.2E4F48C0@fc.hp.com>
Date: Wed, 04 Apr 2001 09:49:12 -0600
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
Cc: Hubertus Franke <frankeh@us.ibm.com>, mingo@elte.hu,
        Mike Kravetz <mkravetz@sequent.com>,
        Fabio Riccardi <fabio@chromium.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: a quest for a better scheduler
In-Reply-To: <OFB30A8B18.2E3AD16C-ON85256A24.004BD696@pok.ibm.com> <20010404171227.W20911@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Wed, Apr 04, 2001 at 10:03:10AM -0400, Hubertus Franke wrote:
> > I understand the dilemma that the Linux scheduler is in, namely satisfy
> > the low end at all cost. [..]
> 
> We can satisfy the low end by making the numa scheduler at compile time (that's
> what I did in my patch at least).
> 
> Andrea

I fully agree with this approach. It would be very hard to design a
scheduler that performs equally well on a UP machine running couple of
processes and a NUMA machine. These two cases represent the two ends of
spectrum. The two schedulers should be separate IMO and one of them
should be selected at compile time.

--
Khalid
 
====================================================================
Khalid Aziz                             Linux Development Laboratory
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
