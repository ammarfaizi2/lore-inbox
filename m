Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271707AbRHQVQD>; Fri, 17 Aug 2001 17:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271694AbRHQVPx>; Fri, 17 Aug 2001 17:15:53 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:45488 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S271707AbRHQVPm>;
	Fri, 17 Aug 2001 17:15:42 -0400
Date: Fri, 17 Aug 2001 16:15:50 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Andi Kleen <ak@suse.de>
cc: Terje Eggestad <terje.eggestad@scali.no>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] processes with shared vm
Message-ID: <6400000.998082950@baldur>
In-Reply-To: <20010817225537.B2429@gruyere.muc.suse.de>
In-Reply-To: <997973469.7632.10.camel@pc-16.suse.lists.linux.kernel>
 <oupelqbw0z4.fsf@pigdrop.muc.suse.de>
 <998038019.7627.21.camel@pc-16.office.scali.no> <36530000.998058370@baldur>
 <20010817225537.B2429@gruyere.muc.suse.de>
X-Mailer: Mulberry/2.1.0b3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Friday, August 17, 2001 22:55:37 +0200 Andi Kleen <ak@suse.de> wrote:

> Even with a tgid you would need some way to avoid its counter wrapping
> and getting reused.

While in theory the pid that is used for tgid should never die while the 
thread group exists, this case needs to be handled for thread groups in 
general.  The number shouldn't be re-used for a pid as long as it's in use 
as a tgid.

> Also gtop should display correct results even with the programs
> that don't use CLONE_THREAD.

Are there any programs that use CLONE_VM and not CLONE_THREAD?

Actually I think we should make tgid visible in /proc in general because 
it's a useful thing to know, whether it's the right mechanism for gtop or 
not.  I'll work up a patch.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

