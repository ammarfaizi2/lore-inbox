Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030437AbWCUQ13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030437AbWCUQ13 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030444AbWCUQ12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:27:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56743 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030437AbWCUQ1A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:27:00 -0500
Date: Tue, 21 Mar 2006 08:26:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: mchehab@infradead.org
cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, akpm@osdl.org
Subject: Re: [PATCH 000/141] V4L/DVB updates part 1
In-Reply-To: <Pine.LNX.4.64.0603210741120.3622@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0603210748340.3622@g5.osdl.org>
References: <20060320150819.PS760228000000@infradead.org>
 <Pine.LNX.4.64.0603210741120.3622@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Mar 2006, Linus Torvalds wrote:
> 
> In particular, commit e338b736f1aee59b757130ffdc778538b7db18d6 is crap, 
> crap, CRAP.

Looking closer, the commit after that is a _real_ merge, and it looks like 
you did something strange when that at first conflicted in saa7134-dvb.c 
or something. I just don't even see _how_ you created that bogus non-merge 
commit. Are you using cogito? It has some problems with conflict 
resolution, I think. Real git should not even have allowed you to commit 
something that hadn't been resolved.

Anyway, if you want to fix this up without re-doing _everything_, the way 
to do so is to just start a new branch, and cherry-pick the non-crap 
commits. So you can fix it up, largely automatedly, with git.

I'm actually trying to do that right now, to see if I can re-create your 
tree without the errors.

		Linus
