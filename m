Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265172AbTFSFyd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 01:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265464AbTFSFyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 01:54:33 -0400
Received: from mx2.elte.hu ([157.181.151.9]:24990 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265172AbTFSFyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 01:54:32 -0400
Date: Thu, 19 Jun 2003 08:07:50 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Andrew Morton'" <akpm@digeo.com>,
       "'george anzinger'" <george@mvista.com>,
       "'joe.korty@ccur.com'" <joe.korty@ccur.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "Li, Adam" <adam.li@intel.com>
Subject: RE: O(1) scheduler seems to lock up on sched_FIFO and sched_RR ta
 sks
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780DD16DB0@orsmsx116.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0306190807210.3404-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Jun 2003, Perez-Gonzalez, Inaky wrote:

> My point here is: I am trying to trace where this program is making use
> of workqueues inside of the kernel, and I can find none. The only place
> where I need to look some more is inside the timer code, but in a quick
> glance, it seems it is not being used, so why is it affected by the
> reprioritization of the events/0 thread? George, can you help me here?

well, printk (console input/output) can already make use of keventd.

	Ingo

