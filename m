Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131588AbRDJMZ7>; Tue, 10 Apr 2001 08:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131590AbRDJMZt>; Tue, 10 Apr 2001 08:25:49 -0400
Received: from iris.mc.com ([192.233.16.119]:34507 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S131588AbRDJMZo>;
	Tue, 10 Apr 2001 08:25:44 -0400
From: Mark Salisbury <mbs@mc.com>
To: Martin Mares <mj@suse.cz>, Andi Kleen <ak@suse.de>
Subject: Re: No 100 HZ timer !
Date: Tue, 10 Apr 2001 08:14:03 -0400
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff Dike <jdike@karaya.com>, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <200104091830.NAA03017@ccure.karaya.com> <20010410075109.A9549@gruyere.muc.suse.de> <20010410113309.A16825@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010410113309.A16825@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Message-Id: <0104100818281A.01893@pc-eng24.mc.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2001, Martin Mares wrote:
> Except for machines with very slow timers we really should account time
> to processes during context switch instead of sampling on timer ticks.
> The current values are in many situations (i.e., lots of processes
> or a process frequently waiting for events bound to timer) a pile
> of random numbers.

yup.  however, there is a performance penalty even on fast machines for the
fine grained process time usage accounting, and it in the past there has been a
strong reluctance to add overhead to syscalls and other context switches.

It would probably be a good compile config option to allow fine or coarse
process time accounting, that leaves the choice to the person setting up the
system to make the choice based on their needs.


 -- 
/*------------------------------------------------**
**   Mark Salisbury | Mercury Computer Systems    **
**   mbs@mc.com     | System OS - Kernel Team     **
**------------------------------------------------**
**  I will be riding in the Multiple Sclerosis    **
**  Great Mass Getaway, a 150 mile bike ride from **
**  Boston to Provincetown.  Last year I raised   **
**  over $1200.  This year I would like to beat   **
**  that.  If you would like to contribute,       **
**  please contact me.                            **
**------------------------------------------------*/

