Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTGHNO6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 09:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbTGHNO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 09:14:58 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:37528 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262288AbTGHNO5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 09:14:57 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16138.51005.54300.297204@laputa.namesys.com>
Date: Tue, 8 Jul 2003 17:29:33 +0400
To: bzzz@tmi.comex.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] parallel directory operations
In-Reply-To: <874r1xuehd.fsf@gw.home.net>
References: <87wuetukpa.fsf@gw.home.net.suse.lists.linux.kernel>
	<p73brw5qmxk.fsf@oldwotan.suse.de>
	<87of05ujfo.fsf@gw.home.net>
	<20030708134601.7992e64a.ak@suse.de>
	<87fzlhuif0.fsf@gw.home.net>
	<20030708141136.18e0034f.ak@suse.de>
	<877k6tuh5g.fsf@gw.home.net>
	<16138.49898.424148.525523@laputa.namesys.com>
	<874r1xuehd.fsf@gw.home.net>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bzzz@tmi.comex.ru writes:
 > >>>>> Nikita Danilov (ND) writes:
 > 
 > 
 >  ND> By taking this approach one step further you may just add a semaphore
 >  ND> into struct dentry and take it instead of directory ->i_sem. I think
 >  ND> Alexander Viro tried something similar in the past, but it slowed down
 >  ND> common case when there is no concurrent access to the directory.
 > 
 > it's not semaphore. locks are created on demand to protect part of directory.
 > we can't have a lots of semaphores allocated statically for each part of
 > each directory.
 > 
 > BTW, all of this have to be enabled by 'pdirops' ext3's mount option. so, things
 > don't slow down w/o this option.

I am talking about "dynamic locks" taken in fs/namei.c. Have you
measured how your patch affects single-threaded case?

 > 

Nikita.
