Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130846AbRALRIc>; Fri, 12 Jan 2001 12:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131229AbRALRIX>; Fri, 12 Jan 2001 12:08:23 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:13858 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130846AbRALRIL>; Fri, 12 Jan 2001 12:08:11 -0500
Date: Fri, 12 Jan 2001 18:05:56 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Richard A Nelson <cowboy@vnet.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
Message-ID: <20010112180556.J2766@athlon.random>
In-Reply-To: <20010112170234.A2766@athlon.random> <Pine.LNX.4.31.0101121139470.25694-100000@back40.badlands.lexington.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0101121139470.25694-100000@back40.badlands.lexington.ibm.com>; from cowboy@vnet.ibm.com on Fri, Jan 12, 2001 at 11:42:32AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 11:42:32AM -0500, Richard A Nelson wrote:
> On Fri, 12 Jan 2001, Andrea Arcangeli wrote:
> 
> > It doesn't make much sense to me to put the "can_I_use" global information in
> > the per-cpu slots, that's obviously the wrong place for it. We simply need to
> > add a new entry to /proc (say "/proc/osinfo") to provide the "can_I_use"
> > informations instead (TSC included).  Breaking /proc/cpuinfo isn't the way to
> > go IMHO.
> 
> Sorry, but you're not taking the long view here,  "can_I_use" most
> definetly should be per-cpu...
> 
> Its fine either way on current x86 and many other platforms, but falls
> on its face in the presence of asymetric MP.

Point taken, feel free to have a can_I_use per-cpu instead of global but don't
overwrite the cpu_has with it. 

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
