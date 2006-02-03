Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWBCSLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWBCSLP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWBCSLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:11:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63120 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751305AbWBCSLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:11:14 -0500
Date: Fri, 3 Feb 2006 10:11:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Larry Finger <Larry.Finger@lwfinger.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.16-c2
In-Reply-To: <43E39932.4000001@lwfinger.net>
Message-ID: <Pine.LNX.4.64.0602031007420.4630@g5.osdl.org>
References: <43E39932.4000001@lwfinger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Feb 2006, Larry Finger wrote:
>
> I know you must have a good reason to switch to the 'pack' form in the git
> tree, but I'm curious. I did a git pull late yesterday, which was "normal",
> and another this morning when I saw that 2.6.16-rc2 was posted. I was quite
> surprised to download 110 MB of data to get roughly 150 changed lines.

Don't use rsync (or http) access unless you have to.

Try using "git://git.kernel.org/" instead. 

Now, it may be that if we have lots of people using it, the CPU usage of 
the server-side effort will go through the roof, and we'll have to come up 
with something else (most likely meaning having some mirrors also run 
git-daemon, so that the CPU overhead can be pushed out too).

The point being that you shouldn't see the packing as even an issue (it 
should be a per-repository decision). The fact that it shows up is because 
of using non-git-aware protocols.

		Linus
