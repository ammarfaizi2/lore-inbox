Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTENThp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 15:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbTENTho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 15:37:44 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58894 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261151AbTENThm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 15:37:42 -0400
Date: Wed, 14 May 2003 12:50:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ulrich Drepper <drepper@redhat.com>
cc: Dave Jones <davej@codemonkey.org.uk>,
       Christopher Hoover <ch@murgatroid.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
In-Reply-To: <3EC29CB2.4030707@redhat.com>
Message-ID: <Pine.LNX.4.44.0305141246180.27329-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 May 2003, Ulrich Drepper wrote:
> 
> Current == current development.  LinuxThreads is not developed anymore
> and with nptl futexes are mandatory.

Yes, I'm also not very eager to make "core functionality" a config option. 
The confusion with the INPUT layer config options was mighty, and none of 
it pleasant. And the *BSD's have historically had totally stupid problems 
with programs like Wine etc requireing kernel recompiles just because they 
made code functionality like vm86 mode or LDT support be a config option.

I don't see the point in dropping futexes except perhaps in a very 
controlled embedded environment, but if that is the case, then a PC config 
should just force it to "y" and not even ask the user. 

We absolutely do NOT want the situation where a program will not work just 
because the user forgot some config option that mostly isn't needed.

And futexes _are_ going to be needed. Any sane high-performance threading 
implementation _will_ use them. No ifs, buts or maybe's.

		Linus

