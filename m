Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129903AbRALQqJ>; Fri, 12 Jan 2001 11:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131464AbRALQp6>; Fri, 12 Jan 2001 11:45:58 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:46465 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S129903AbRALQpp>;
	Fri, 12 Jan 2001 11:45:45 -0500
Date: Fri, 12 Jan 2001 11:42:32 -0500 (EST)
From: Richard A Nelson <cowboy@vnet.ibm.com>
X-X-Sender: <cowboy@back40.badlands.lexington.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
In-Reply-To: <20010112170234.A2766@athlon.random>
Message-ID: <Pine.LNX.4.31.0101121139470.25694-100000@back40.badlands.lexington.ibm.com>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001, Andrea Arcangeli wrote:

> It doesn't make much sense to me to put the "can_I_use" global information in
> the per-cpu slots, that's obviously the wrong place for it. We simply need to
> add a new entry to /proc (say "/proc/osinfo") to provide the "can_I_use"
> informations instead (TSC included).  Breaking /proc/cpuinfo isn't the way to
> go IMHO.

Sorry, but you're not taking the long view here,  "can_I_use" most
definetly should be per-cpu...

Its fine either way on current x86 and many other platforms, but falls
on its face in the presence of asymetric MP.
-- 
Rick Nelson
Netscape is not a newsreader, and probably never shall be.
	-- Tom Christiansen

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
