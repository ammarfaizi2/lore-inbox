Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbUKGGsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbUKGGsc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 01:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbUKGGsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 01:48:32 -0500
Received: from quechua.inka.de ([193.197.184.2]:63419 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261547AbUKGGsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 01:48:30 -0500
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: OT: cron filling process table (was: deadlock with 2.6.9)
Organization: Deban GNU/Linux Homesite
In-Reply-To: <200411070058_MC3-1-8E27-AAEF@compuserve.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CQgqi-0006iS-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 07 Nov 2004 07:48:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

just an thought on cron, not very kernel related:

In article <200411070058_MC3-1-8E27-AAEF@compuserve.com> you wrote:
> Why so many cron processes?  Is this normal on your system, or does it
> look like cron keeps spawning processes because it gets no response on the
> sockets?

if you have a cron job which is executed very often cron will spawn a new
child everytime the deadline is reached. if the client is stuck for some
reason (ie. uninterruptiple sleep while accessing a broken ressource) it
will soon fill up your systems.

Personally thats why I prefer a cron-like system, which is configured with
maximum concurrency (or always serialize the jobs for a given type). This
has problems with handing jobs, but it is generally more stable for the
system.

Greetings
Bernd
