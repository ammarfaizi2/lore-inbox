Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266465AbUJAVdC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266465AbUJAVdC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 17:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUJAVcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 17:32:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:39366 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266578AbUJAVXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 17:23:13 -0400
Date: Fri, 1 Oct 2004 14:23:01 -0700
From: Chris Wright <chrisw@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "Jack O'Quin" <joq@io.com>, Chris Wright <chrisw@osdl.org>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de
Subject: Re: [PATCH] Realtime LSM
Message-ID: <20041001142259.I1924@build.pdx.osdl.net>
References: <1094967978.1306.401.camel@krustophenia.net> <20040920202349.GI4273@conscoop.ottawa.on.ca> <20040930211408.GE4273@conscoop.ottawa.on.ca> <1096581213.24868.19.camel@krustophenia.net> <87pt43clzh.fsf@sulphur.joq.us> <20040930182053.B1973@build.pdx.osdl.net> <87k6ubcccl.fsf@sulphur.joq.us> <1096663225.27818.12.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1096663225.27818.12.camel@krustophenia.net>; from rlrevell@joe-job.com on Fri, Oct 01, 2004 at 04:40:25PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell (rlrevell@joe-job.com) wrote:
> On Fri, 2004-10-01 at 00:05, Jack O'Quin wrote:
> > The ulimit approach is way too cumbersome.
> 
> Agreed.  The whole point of getting realtime-lsm in the kernel is to
> make it _easier_ to get a linux audio (or other realtime system) up and
> running.

It's nice to have something that's easy to use, but that's not a great
justification for addition to the kernel.  Esp. when there's a
functional userspace solution.

> Would it be feasible to use rlimits to let users run
> SCHED_FIFO processes?

No, it doesn't support that.  I suppose it could, whether is should
is another matter.

> The ulimit approach would probably be acceptable
> if it subsumed all the functionality of the realtime-lsm module.

Hrm, I guess we'll have to agree to disagree.  The whole point of the
mlock rlimits code is to enable this policy to be pushed to userspace.
A generic method of enabling capabilities is the best way to go, long
term.  Any interest in pursuing that?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
