Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278428AbRJ3Vxx>; Tue, 30 Oct 2001 16:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278429AbRJ3Vxn>; Tue, 30 Oct 2001 16:53:43 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:23053 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S278410AbRJ3Vxa>;
	Tue, 30 Oct 2001 16:53:30 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15327.7716.638079.235753@cargo.ozlabs.ibm.com>
Date: Wed, 31 Oct 2001 08:39:48 +1100 (EST)
To: linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
In-Reply-To: <20011030095757.A9956@hq2>
In-Reply-To: <Pine.LNX.4.33.0110300835140.8603-100000@penguin.transmeta.com>
	<20011030095757.A9956@hq2>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Victor Yodaiken writes:

> You can't turn off hardware hash-chains on anything past 603, sadly enough.
> So all Macs, many embedded boards, ...

All the 4xx, 8xx, and 82xx embedded PPC cpus use software TLB
loading.  The 7450 has a mode bit to say whether to use a hash table
or software TLB loading.  And the new "Book E" specification also
mandates software-loaded TLBs.

That still leaves almost all of the current Macs and RS/6000s using a
hash table, of course.  It does sound like providing at least the
option to use software TLB loading is becoming common in new PPC
designs.

(And BTW they are not hash *chains*, there is no chaining involved.
There is a primary bucket and a secondary bucket for any given
address, each of which can hold 8 ptes.)

Paul.
