Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265230AbUGZM3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUGZM3N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 08:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265232AbUGZM3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 08:29:13 -0400
Received: from pD9E0E068.dip.t-dialin.net ([217.224.224.104]:26500 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S265230AbUGZM3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 08:29:11 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-I3
From: Thomas Charbonnel <thomas@undata.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040726111028.GA754@elte.hu>
References: <20040722175457.GA5855@ss1000.ms.mff.cuni.cz>
	 <20040722180142.GC30059@elte.hu> <20040722180821.GA377@elte.hu>
	 <20040722181426.GA892@elte.hu> <20040723104246.GA2752@elte.hu>
	 <4d8e3fd30407230358141e0e58@mail.gmail.com> <20040723110430.GA3787@elte.hu>
	 <4d8e3fd30407230442afe80c1@mail.gmail.com> <20040723120014.GA5573@elte.hu>
	 <1090626523.4851.32.camel@localhost>  <20040726111028.GA754@elte.hu>
Content-Type: text/plain
Message-Id: <1090844867.6860.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 26 Jul 2004 14:27:47 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote :
> * Thomas Charbonnel <thomas@undata.org> wrote:
> 
> > Hi,
> > 
> > I'm experiencing hard freezes in the early stage of the latency test
> > suite (X11 test, latencytest-0.5.4) with 2.6.8-rc2-I4, both with the
> > default vp:2 kp:0 and with vp:0 kp:0 (nvidia card, xfree drivers). I
> > was also experiencing hard freezes before with 2.6.7-mm7-H4 while
> > doing intensive disk I/O on reiserfs (e.g. tar big_file.tar.gz)
> 
> weird. Do you get these freezes with CONFIG_VOLUNTARY and CONFIG_PREEMPT
> turned off in the .config as well? Do you get them with the patch
> unapplied altogether?
> 
> hm ... arent you using the SMP kernel by any chance? The latencytest
> module has an SMP locking bug, fixed by the patch below.
> 
> 	Ingo

I was not using an SMP kernel.
I redid the test with 2.6.8-rc2-J4 (vp:2 kp:0), and latencytest-0.5.4
with your locking fix, and it went ok. I did the test holding a key to
track the problem I'm seeing with the keyboard (xrun/latency spike on
8.079 sec boundaries if a keybord interrupt happens at this moment).
You can find the results including the traces generated with showtrace
here :
http://www.undata.org/~thomas/test1.tar.bz2

Thomas


