Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266330AbUBMB7b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 20:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266646AbUBMB7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 20:59:31 -0500
Received: from mail.shareable.org ([81.29.64.88]:18306 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266330AbUBMB7a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 20:59:30 -0500
Date: Fri, 13 Feb 2004 01:57:57 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Valdis.Kletnieks@vt.edu, Michael Frank <mhf@linuxmail.org>,
       Nick Piggin <piggin@cyberone.com.au>,
       Giuliano Pochini <pochini@shiny.it>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: ext2/3 performance regression in 2.6 vs 2.4 for small interl
Message-ID: <20040213015757.GC25499@mail.shareable.org>
References: <XFMail.20040212104215.pochini@shiny.it> <402B5502.2010207@cyberone.com.au> <200402130105.22554.mhf@linuxmail.org> <200402121718.i1CHITFf018390@turing-police.cc.vt.edu> <20040212205503.GA13934@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040212205503.GA13934@hh.idb.hist.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> Something similiar could be done for io niceness.  If we run out of
> normal priority io, how about not issuing the low priority io
> right away.  Anticipate there will be more high-priority io
> and wait for some idle time before letting low-priority
> requests through.  And of course some maximum wait to prevent
> total starvation.

The problem is quite similar to scheduling for quality on a network
device.  Once a packet has started going it, usually you cannot abort
the packet for a higher priority one.

I thought there was a CBQ I/O scheduling patch or such to offer some
kind of I/O niceness these days?

-- Jamie
