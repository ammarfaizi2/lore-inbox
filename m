Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWAYByE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWAYByE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 20:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWAYByE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 20:54:04 -0500
Received: from wumpus.mythic-beasts.com ([212.69.37.9]:38842 "EHLO
	wumpus.mythic-beasts.com") by vger.kernel.org with ESMTP
	id S1750765AbWAYByD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 20:54:03 -0500
Date: Wed, 25 Jan 2006 01:54:01 +0000
From: Chris Lightfoot <chris@ex-parrot.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel freeze on 2.4.32, apparently in cached_lookup
Message-ID: <vZtReWfk3Hr2.aYFsDRcqPWlIvTnz7jlvlw@sphinx.mythic-beasts.com>
References: <tQjo3cDibk0S.MeaWngl+j1QiYR1U5+Ih3w@sphinx.mythic-beasts.com> <20060124211311.GV7142@w.ods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124211311.GV7142@w.ods.org>
User-Agent: Mutt/1.4i
X-Mail-Author: me
X-Face: "kUA_=&I|(by86eXgYc|U}5`O%<xlo,~+JN9uk"Z`A.UCf2\1KKZ{FY-IIOqH/IS"=5=cb` U,mDyyf8a6BzVgYT~pRtqze]%s#\(J{/um"(r,Ol^4J*Y%aWe-9`ZKGEYjG}d?#u2jzP,x37.%A~Qa ;Yy6Fz`i/vu{}?y8%cI)RJpLnW=$yTs=TDM'MGjX`/LDw%p;EK;[ww;9_;UnRa+JZYO}[-j]O08X\N m/K>M(P#,)y`g7N}Boz4b^JTFYHPz:s%idl@t$\Vv$3OL6:>GEGwFHrV$/bfnL=6uO/ggqZfet:&D3 Q=9c
X-Face-Plug: http://www.mythic-beasts.com/tools-toys/xface/
X-Sigs-Plug: vote on my signature quotes at http://ex-parrot.com/~chris/scripts/amisigornot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 10:13:12PM +0100, Willy Tarreau wrote:
    [...]
> What seems strange in your report is that the kernel freezes.
> The only part in cached_lookup() which could freeze IMHO is
> when it calls d_lookup(), but for this, you should have a
> closed loop instead of a linked list. It could happen with
> some memory corruption, but you would get far more oopses
> and panics than freezes. For this reason, I believe you
> might have some random problem on your filesystem. Could
> you run a full fsck on it ?

fsck finds the filesystem is clean; I ran memtest
overnight when I built the machine and it didn't find
anything. Nick's suggestion that it could be a temperature
problem is also interesting; I've added another fan to the
machine and I'll see if that helps matters; if not I'll
try memtest again.

-- 
``It's not a bomb. It's a device that explodes.''
  (possibly-apocryphal statement by French spokesman,
  before the 1995 nuclear tests)
