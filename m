Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTHVSbD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 14:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263455AbTHVSbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 14:31:03 -0400
Received: from gate.in-addr.de ([212.8.193.158]:37271 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S263398AbTHVSbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 14:31:01 -0400
Date: Fri, 22 Aug 2003 17:50:39 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>, Mike Fedyk <mfedyk@matchmail.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: md: bug in file raid5.c, line 540 was: Re: Linux 2.4.22-rc1
Message-ID: <20030822155039.GA6980@marowsky-bree.de>
References: <Pine.LNX.4.44.0308051543130.12501-100000@logos.cnet> <20030819202629.GA4083@matchmail.com> <20030819210913.GC4083@matchmail.com> <16197.43294.828878.586018@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16197.43294.828878.586018@gargle.gargle.HOWL>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-08-22T15:24:46,
   Neil Brown <neilb@cse.unsw.edu.au> said:

> This bug could happen if you try to fail a device that is not active.

Yes, thats not generally a tested code path in 2.4. On removing the
BUG() statement, also check that all counters get in/decremented
correctly, or the next lurking bug will hit you.

I fixed that for multipath in 2.4 too, but I can't get around to clean
up the patchset *sigh*


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering		ever tried. ever failed. no matter.
SuSE Labs				try again. fail again. fail better.
Research & Development, SuSE Linux AG		-- Samuel Beckett

