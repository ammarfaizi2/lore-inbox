Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265900AbUFDSFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUFDSFZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 14:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265897AbUFDSFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 14:05:25 -0400
Received: from xs4all.vs19.net ([213.84.236.198]:5043 "EHLO spaans.vs19.net")
	by vger.kernel.org with ESMTP id S265903AbUFDSFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 14:05:06 -0400
Date: Fri, 4 Jun 2004 20:05:03 +0200
From: Jasper Spaans <jasper@vs19.net>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to fix timestamps in bk repo?
Message-ID: <20040604180503.GA14530@spaans.vs19.net>
References: <20040604081926.GA24427@spaans.vs19.net> <20040604155613.GA1761@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604155613.GA1761@work.bitmover.com>
X-Copyright: Copyright 2004 Jasper Spaans, unauthorised distribution prohibited
User-Agent: Mutt/1.5.6i
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: spaans@spaans.vs19.net
X-SA-Exim-Scanned: No (on spaans.vs19.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 08:56:13AM -0700, Larry McVoy wrote:
> > Is it possible to reset the (BK-)timestamps on the following files in the
> > http://linus.bkbits.net:8080/linux-2.5 repository? Somehow, they've gotten a
> > timestamp which lies in the future, causing lots of warnings when I use a bk
> > exported tree.
> 
> Sorry, the timestamps are part of the BK metadata and there isn't any way
> to alter them after the fact.  

Ack. I just tried something with the following result:

---8<---
# This is a BitKeeper generated diff -Nru style patch.
#
# drivers/base/class.c
#   2004/06/04 19:55:06+02:00 spaans@spaans.vs19.net +0 -1
#   Fix timestamp
# 
# drivers/base/class.c
#   2004/06/04 19:54:56+02:00 spaans@spaans.vs19.net +1 -0
# 
# ChangeSet
#   2004/06/04 19:55:32+02:00 spaans@spaans.vs19.net 
#   class.c:
#     Fix timestamp
# 
---8<---

Can anyone confirm that importing this does the trick? If so, I'll whip up
the 'patch' for all six files.

Regards,
-- 
Jasper Spaans                                       http://jsp.vs19.net/
 19:56:31 up 9970 days, 10:43, 0 users, load average: 6.19 6.08 5.67
  -... .- -.. --. . .-. -... .- -.. --. . .-. -... .- -.. --. . .-.
