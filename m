Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbTK3JJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 04:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbTK3JJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 04:09:57 -0500
Received: from play.smurf.noris.de ([192.109.102.42]:30168 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP id S262397AbTK3JJz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 04:09:55 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: What exactly are the issues with 2.6.0-test10 preempt?
Date: Sun, 30 Nov 2003 10:09:28 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2003.11.30.09.09.28.112431@smurf.noris.de>
References: <20031124191459.99375.qmail@web40902.mail.yahoo.com>
NNTP-Posting-Host: linux.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: play.smurf.noris.de 1070183368 11686 192.109.102.39 (30 Nov 2003 09:09:28 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Sun, 30 Nov 2003 09:09:28 +0000 (UTC)
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bradley Chapman wrote:

> So what exactly is the problem?

I'm seeing
- User Interface corruption under X. That shows as random processes
crashing with SIGFPE (interestingly, often two unrelated X processes crash
at the same time -- sometimes one of them is the server) or SEGV, 

I just switched to -test11 and turned off preemption. I don't see any more
crashes or weird behavior, but now performance sucks -- console scrolling
(frame buffer) stalls for seconds, keyboard repeat likewise, and the X
server suddenly decides it wants twice the CPU (60% instead of 30%).

I'll rebuild test11 with preempt and check whether there are any changes.
(Yes I know, changing two variables at the same time was somewhat stupid.)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
If you're careful enough, nothing bad or good will ever happen to you.

