Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265420AbTFSEYR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 00:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265421AbTFSEYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 00:24:17 -0400
Received: from fmr01.intel.com ([192.55.52.18]:14070 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S265420AbTFSEYQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 00:24:16 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780DD16D68@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Joe Korty'" <joe.korty@ccur.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: O(1) scheduler seems to lock up on sched_FIFO and sched_RR ta
	 sks
Date: Wed, 18 Jun 2003 21:38:12 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: 'joe.korty@ccur.com' [mailto:joe.korty@ccur.com]
>
> On Wed, Jun 18, 2003 at 06:44:42PM -0700, Perez-Gonzalez, Inaky wrote:
> >
> > Now that we are at that, it might be wise to add a higher-than-anything
> > priority that the kernel code can use (what would be 100 for user space,
> > but off-limits), so even FIFO 99 code in user space cannot block out
> > the migration thread, keventd and friends.
> 
> I would prefer users have the ability to put one or two truly critical RT
> tasks above keventd & family.  Such tasks would have to follow certain
rules
> .. run & sleep quick .. limited or no device IO ..  most communication to
> other tasks through shared memory .. possibly others.

Agreed - see my answers to George Anzinger and Robert Love; I wasn't
precise enough on meaning "yeah, you should be able to reprioritize it
at will". My point is that user programs have a limit that they cannot
use, while kernel threads can use the user's priority space and their
highest priority space.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
