Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275571AbRJAVdt>; Mon, 1 Oct 2001 17:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275573AbRJAVdj>; Mon, 1 Oct 2001 17:33:39 -0400
Received: from barry.mail.mindspring.net ([207.69.200.25]:2872 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S275571AbRJAVdW>; Mon, 1 Oct 2001 17:33:22 -0400
Subject: Re: [PATCH][RFC] Allow net devices to contribute to /dev/random
From: Robert Love <rml@ufl.edu>
To: Pavel Machek <pavel@suse.cz>
Cc: David Wagner <daw@mozart.cs.berkeley.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20011001164354.A21715@bug.ucw.cz>
In-Reply-To: <1001461026.9352.156.camel@phantasy>
	<9or70g$i59$1@abraham.cs.berkeley.edu> <1001465531.10701.61.camel@phantasy>
	 <20011001164354.A21715@bug.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.30.08.08 (Preview Release)
Date: 01 Oct 2001 17:33:43 -0400
Message-Id: <1001972029.2277.41.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-10-01 at 10:43, Pavel Machek wrote:
> > Obviously the timer interrupt would be the worst idea ever.  Its the
> > same value (HZ) on almost all versions of Linux (Alpha being on example
> > where it is not the same).
> 
> Actually, not quite. On 2.4.9 system, console kept interrupts disabled
> for so long that timer interrupt was pretty good source of randomness.

That is pretty sad, to be honest :)

Besides, on some systems interrupts may rarely be disabled -- its too
hard to tell.  We don't want another config option, do we? :)

Also, 2.4.10 merged Andrew Morton's console-locking patch, so one can
hope the console's latency is improved.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

