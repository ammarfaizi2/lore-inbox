Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbTDQVqz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 17:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbTDQVqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 17:46:55 -0400
Received: from [12.47.58.203] ([12.47.58.203]:26851 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262629AbTDQVqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 17:46:54 -0400
Date: Thu, 17 Apr 2003 14:57:35 -0700
From: Andrew Morton <akpm@digeo.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: shemminger@osdl.org, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] Fix orlov allocator boundary case
Message-Id: <20030417145735.2a9eb17c.akpm@digeo.com>
In-Reply-To: <200304172327.09876.m.c.p@wolk-project.de>
References: <20030417111303.706d7246.shemminger@osdl.org>
	<20030417122142.39d27f73.akpm@digeo.com>
	<200304172327.09876.m.c.p@wolk-project.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Apr 2003 21:58:45.0429 (UTC) FILETIME=[84630E50:01C3052C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen <m.c.p@wolk-project.de> wrote:
>
> On Thursday 17 April 2003 21:21, Andrew Morton wrote:
> 
> Hi Andrew,
> 
> > OK, here be the fix.
> > I'm a bit peeved that this wasn't discovered until it hit Linus's tree.
> > Weren't these patches in -mjb as well?
> I guess this is also true for the ext3 code?

Only for the modified ext3 in the -mm tree.

> I am using the orlov stuff for 2.4.21* maintained by Theodore and Steven.

That kernel will not exhibit the problem - it is caused by the "fast version"
of the free inodes count being off by a few blocks, and the filesystem having
only one block group.

