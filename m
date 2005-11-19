Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbVKTIQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbVKTIQI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 03:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVKTIQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 03:16:08 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:20198 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751113AbVKTIQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 03:16:05 -0500
Date: Sat, 19 Nov 2005 23:30:11 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>,
       "SERGE E. HALLYN [imap]" <serue@us.ibm.com>, Paul Jackson <pj@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-ID: <20051119233010.GA3361@spitz.ucw.cz>
References: <20051114212341.724084000@sergelap> <20051114153649.75e265e7.pj@sgi.com> <20051115055107.GB3252@IBM-BWN8ZTBWAO1> <20051113152214.GC2193@spitz.ucw.cz> <9901B851-17B2-4AEB-813F-A92560DFE289@mac.com> <20051116203603.GA12505@elf.ucw.cz> <1132174090.5937.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132174090.5937.14.camel@localhost>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Hmm... it is hard to judge a patch without context. Anyway, can't we
> > get process snasphot/resume without virtualizing pids? Could we switch
> > to 128-bits so that pids are never reused or something like that?
> 
> That might work fine for a managed cluster, but it wouldn't be a good
> fit if you ever wanted to support something like a laptop in
> disconnected operation, or if you ever want to restore the same snapshot
> more than once.  There may also be some practical userspace issues
> making pids that large.
> 
> I also hate bloating types and making them sparse just for the hell of
> it.  It is seriously demoralizing to do a ps and see
> 7011827128432950176177290 staring back at you. :)

Well, doing cat /var/something/foo.pid, and seeing pid of unrelated process
is wrong, too... especially if you try to kill it....
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

