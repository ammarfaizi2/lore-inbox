Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261978AbTDADRV>; Mon, 31 Mar 2003 22:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262005AbTDADRV>; Mon, 31 Mar 2003 22:17:21 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:33174 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S261978AbTDADRU>; Mon, 31 Mar 2003 22:17:20 -0500
Date: Mon, 31 Mar 2003 19:28:38 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: whitney@math.berkeley.edu
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.65: Caching MSR_IA32_SYSENTER_CS kills dosemu
In-Reply-To: <Pine.LNX.4.44.0303311612060.6908-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0303311751550.2324-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Mar 2003, Linus Torvalds wrote:

> Can you check dosemu in text mode to see if the kernel prints out
> anything. I realize that not many things are relevant in text mode, but
> I have this memory of dosemu at least historically supporting it. Maybe
> not any more.

OK, running dosemu at the console does not cause a lock up.  More
specifically:  just running dosemu doesn't cause a lock up ever.  To get
it to lock up, I have to run this game I play.  Under X, just running the
game and waiting at the game's main menu causes the lock up in a couple
minutes.  At the console, the game's graphics mode is not supported, so I
get a blank screen.  But if I run the game blind and wait at the main
menu, there is never a lock up.

Also, it seems that turning off preempt makes the problem go away.  At
least, I haven't got any lockups yet.

Cheers, Wayne


