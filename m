Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267156AbTBICcY>; Sat, 8 Feb 2003 21:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267157AbTBICcY>; Sat, 8 Feb 2003 21:32:24 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:15256 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S267156AbTBICcX>; Sat, 8 Feb 2003 21:32:23 -0500
Date: Sat, 8 Feb 2003 18:41:54 -0800
Message-Id: <200302090241.h192fsK04501@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
X-Fcc: ~/Mail/linus
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@digeo.com>,
       <arjanv@redhat.com>
Subject: Re: heavy handed exit() in latest BK
In-Reply-To: Linus Torvalds's message of  Saturday, 8 February 2003 18:33:06 -0800 <Pine.LNX.4.44.0302081826230.7675-100000@home.transmeta.com>
X-Fcc: ~/Mail/linus
X-Shopping-List: (1) Intransigent fission
   (2) Alphabetic L'eggs
   (3) Runcible tedious trash
   (4) Anomalous prostitutes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Roland, does this look sane to you? 

Hey, that's my patch!  :-) Actually, mine has one line of difference, which
is not to set TIF_SIGPENDING when SIGCONT is blocked.  That difference is
visible to kernel threads that block SIGCONT and check signal_pending,
of which there are some though I don't recall understanding why.

I am still doing tests.
