Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbWAUBuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbWAUBuA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 20:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWAUBuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 20:50:00 -0500
Received: from ns.suse.de ([195.135.220.2]:16035 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932374AbWAUBt7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 20:49:59 -0500
From: Andreas Schwab <schwab@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: set_bit() is broken on i386?
References: <200601201955_MC3-1-B649-DCF5@compuserve.com>
	<1137806107.8691.25.camel@lade.trondhjem.org>
X-Yow: Yes, Private DOBERMAN!!
Date: Sat, 21 Jan 2006 02:49:53 +0100
In-Reply-To: <1137806107.8691.25.camel@lade.trondhjem.org> (Trond Myklebust's
	message of "Fri, 20 Jan 2006 20:15:07 -0500")
Message-ID: <jek6cu73jy.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

> On Fri, 2006-01-20 at 19:53 -0500, Chuck Ebbert wrote:
>
>> #define ADDR (*(volatile long *) addr)
>> static inline void set_bit(int nr, volatile unsigned long * addr)
>> {
>> 	__asm__ __volatile__( "lock ; "
>> 		"btsl %1,%0"
>> 		:"=m" (ADDR)
>> 		:"Ir" (nr));
>> }
>
> The asm needs a memory clobber in order to avoid reordering with the
> assignment to b[1]:

Check out 2.6.16-rc1, this has already been fixed.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
