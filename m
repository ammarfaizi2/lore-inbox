Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbTDVG4Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 02:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbTDVG4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 02:56:24 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:46160 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262197AbTDVG4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 02:56:24 -0400
Date: Tue, 22 Apr 2003 03:08:27 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Dave Jones <davej@codemonkey.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] HT scheduler, sched-2.5.68-A9
In-Reply-To: <20030422040117.GA31324@suse.de>
Message-ID: <Pine.LNX.4.44.0304220305260.25143-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Apr 2003, Dave Jones wrote:

> Maybe this would be better resolved at runtime ? With the above patch,
> you'd need three seperate kernel images to run optimally on a system in
> each of the cases. The 'vendor kernel' scenario here looks ugly to me.

it's not a problem - vendors enable it and that's all. But the majority of 
SMP systems does not need a shared runqueue, so the associated overhead 
(which, while small, is nonzero) can be avoided.

> Dumping all this into the config system seems to be the wrong direction
> IMHO. The myriad of runtime knobs in the scheduler already is bad
> enough, without introducing compile time ones as well.

what runtime knobs? I've avoided as many of them as possible.

	Ingo

