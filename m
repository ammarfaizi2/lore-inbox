Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262513AbTCRSzj>; Tue, 18 Mar 2003 13:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262533AbTCRSzj>; Tue, 18 Mar 2003 13:55:39 -0500
Received: from 12-225-92-115.client.attbi.com ([12.225.92.115]:13696 "EHLO
	p3.coop.hom") by vger.kernel.org with ESMTP id <S262513AbTCRSzi>;
	Tue, 18 Mar 2003 13:55:38 -0500
Date: Tue, 18 Mar 2003 11:05:57 -0800
From: Jerry Cooperstein <coop@axian.com>
To: linux-kernel@vger.kernel.org
Subject: seqlock/unlock(&xtime_lock) problems cause keyboard, time skew problems
Message-ID: <20030318190557.GA14447@p3.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2.5.60 my thinkpad keyboard repeat rate has been erratic when
started up on battery power; plugging into AC after startup only makes
it worse.  Starting up on AC is fine.  Compiling without apm in any
form is fine.

I posted on this a month ago and noone had solutions although I got
several emails from folks with similarly afflicted machines.

Since then I've noticed that I also get a bad time skew, with the
system clock jumping forward.

I'm pretty sure the problem arose with the introduction of the
seqlock/unlock interface to protect xtime_lock instead of a regular rw
lock.  Short of trying to back the whole thing out, does any one have
similar observations, suggestions, solutions?

======================================================================
 Jerry Cooperstein,  Senior Consultant,  <coop@axian.com>
 Axian, Inc., Software Consulting and Training
 4800 SW Griffith Dr., Ste. 202,  Beaverton, OR  97005 USA
 http://www.axian.com/               
======================================================================
