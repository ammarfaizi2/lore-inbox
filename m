Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbTJ0Mrf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 07:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbTJ0Mrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 07:47:35 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:45765 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261626AbTJ0Mre
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 07:47:34 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16285.5092.216272.470811@laputa.namesys.com>
Date: Mon, 27 Oct 2003 15:47:32 +0300
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Burton Windle <bwindle@fint.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: fsstress causes memory leak in test6, test8
In-Reply-To: <20031027121609.GA27611@redhat.com>
References: <Pine.LNX.4.58.0310251842570.371@morpheus>
	<20031026170241.628069e3.akpm@osdl.org>
	<20031027121609.GA27611@redhat.com>
X-Mailer: VM 7.17 under 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones writes:
 > On Sun, Oct 26, 2003 at 05:02:41PM -0800, Andrew Morton wrote:
 > 
 >  > It is not a "leak" as such - the dentries will get shrunk in normal usage
 >  > (create enough non-dir dentries and the "leaked" directory dentries will
 >  > get reclaimed).  The really deep directories which fsstress creates
 >  > demonstrated the bug.
 > 
 > This could explain the random reiserfs oopses/hangs I was seeing several
 > months back after running fsstress for a day or so. The reiser folks

This could explain hangs, but hardly oopses. System just freezes due to
out-of-memory.

 > were scratching their heads, and we even put it down to flaky hardware
 > or maybe even a CPU bug back then.

Of course we did, there are no bugs in reiserfs, you know. :)

 > 
 >  > Given that it took a year for anyone to notice, it's probably best that
 >  > this not be included for 2.6.0.
 > 
 > I agree in a "lets get 2.6 out the door" sense, but once thats 'out
 > there' a user-level DoS should be fixed up pretty quickly.
 > The paranoid could always run 2.6-mm I guess 8-)
 > 
 > 		Dave
 > 

Nikita.

