Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbUCRTqg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 14:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbUCRTqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 14:46:05 -0500
Received: from ns.suse.de ([195.135.220.2]:9913 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262904AbUCRTpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 14:45:44 -0500
Subject: Re: CONFIG_PREEMPT and server workloads
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Takashi Iwai <tiwai@suse.de>, andrea@suse.de, mjy@geizhals.at,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040318112941.0221c6ac.akpm@osdl.org>
References: <40591EC1.1060204@geizhals.at>
	 <20040318060358.GC29530@dualathlon.random> <s5hlllycgz3.wl@alsa2.suse.de>
	 <20040318110159.321754d8.akpm@osdl.org> <s5hbrmuc6ed.wl@alsa2.suse.de>
	 <20040318112941.0221c6ac.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1079639286.4187.2113.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 18 Mar 2004 14:48:07 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 14:29, Andrew Morton wrote:

> > yep, i see a similar problem also in reiserfs's do_journal_end().
> > it's in lock_kernel().
> 
> I have a scheduling point in journal_end() in 2.4.  But I added bugs to
> reiserfs a couple of times doing this - it's pretty delicate.  Beat up on
> Chris ;)

;-) Not sure if Takashi is talking about -suse or -mm, the data=ordered
patches change things around.  He sent me suggestions for the
data=ordered latencies already, but it shouldn't be against the BKL
there, since I drop it before calling write_ordered_buffers().

-chris


