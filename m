Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268582AbUJTRIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268582AbUJTRIg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 13:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268701AbUJTRIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 13:08:19 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:28544 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S268702AbUJTRHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:07:20 -0400
Date: Wed, 20 Oct 2004 19:08:02 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Timothy Miller <miller@techsource.com>, Hugh Dickins <hugh@veritas.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20041020170802.GB24619@dualathlon.random>
References: <593560000.1094826651@[10.10.2.4]> <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain> <20040910151538.GA24434@devserv.devel.redhat.com> <20040910152852.GC15643@x30.random> <20040910153421.GD24434@devserv.devel.redhat.com> <41768858.8070709@techsource.com> <20041020153521.GB21556@devserv.devel.redhat.com> <1098290345.1429.65.camel@krustophenia.net> <20041020165050.GA24619@dualathlon.random> <1098291315.1429.79.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098291315.1429.79.camel@krustophenia.net>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 12:55:17PM -0400, Lee Revell wrote:
> This was not my point, I agree that the two have nothing to do with each
> other.  But if a hardirq handler runs for 3ms then no user code can run
> for 3ms.  Therefore this is a problem if our goal for desktop response
> is 1ms.

I sure agree it's a problem, but not always userspace code needs to run
for the user not to notice. With ring buffers in the kernel for playback
all you need is a nested irq for the user not to notice skips.
