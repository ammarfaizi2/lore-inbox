Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268520AbUHQXgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268520AbUHQXgh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 19:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266769AbUHQXgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 19:36:37 -0400
Received: from av7-1-sn1.fre.skanova.net ([81.228.11.113]:44444 "EHLO
	av7-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S268520AbUHQXgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 19:36:33 -0400
To: Julien Oster <lkml-7994@mc.frodoid.org>
Cc: Frediano Ziglio <freddyz77@tin.it>, axboe@suse.de,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Packet writing problems
References: <1092669361.4254.24.camel@freddy> <m3acwuq5nc.fsf@telia.com>
	<m3657iq4rk.fsf@telia.com> <1092686149.4338.1.camel@freddy>
	<m37jrxk024.fsf@telia.com> <87acwt49zl.fsf@killer.ninja.frodoid.org>
From: Peter Osterlund <petero2@telia.com>
Date: 18 Aug 2004 01:36:30 +0200
In-Reply-To: <87acwt49zl.fsf@killer.ninja.frodoid.org>
Message-ID: <m3y8kdibgh.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Julien Oster <lkml-7994@mc.frodoid.org> writes:

> Peter Osterlund <petero2@telia.com> writes:
> 
> Hello Peter,
> 
> > That shouldn't cause any real problems, but since it's quite
> > confusing, here is a patch to fix it.  With this change, both DVD+RW
> > and DVD-RW media is correctly identified in the kernel log, and DVD
> > speeds are printed in kB/s.
> 
> The following patch on top of your patch adds all commonly used media
> types to the output and changes CD-R and CD-RW to be detected by
> profile type. It also reports unconforming non-standard profiles as
> well as profiles which have a MMC profile definition but are unknown
> as of the current MMC3 revision.
> 
> Please review.

Will any of those printk's ever get printed? Media types that can't be
handled by the packet driver aren't supposed to make it past the
pkt_good_disc() test.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
