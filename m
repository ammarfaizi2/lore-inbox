Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279813AbRJ0Mdw>; Sat, 27 Oct 2001 08:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279814AbRJ0Mdp>; Sat, 27 Oct 2001 08:33:45 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:6651 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S279813AbRJ0Mdg>; Sat, 27 Oct 2001 08:33:36 -0400
From: Stefan Hoffmeister <lkml.2001@econos.de>
To: linux-kernel@vger.kernel.org
Subject: Bandwidth QoS for disks?
Date: Sat, 27 Oct 2001 14:34:43 +0200
Organization: Econos
Message-ID: <9i9lttg9ifdhigh57imv15jhakefk10p9c@4ax.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

is there anything in the kernel that would allow an application to
*declare* that it needs disk read (or possibly) write bandwidth of n
KB/s?

The kernel would make every attempt to deliver that bandwidth, even
allowing starvation of other less important clients, except for some
5-10% headroom for emergency? I realise that the kernel cannot
*guarantee* that bandwidth, but some kind of priorization scheme would
help often enough, I guess.

I just lost another CD-R due to cron with lots and lots of on-disk
seeking kicking in, killing all that bandwidth cdrecord needed - and I
don't have one of these new and fancy burn-proof things (and, yes, I
should have suspended cron and friends, but I am only human and
computers are meant to made my life easier).

Sure, I could instruct cdrecord to increase its own read-ahead cache
from 4 MB to, say, 128 MB. But read-ahead cache != "QoS" (except for
volume of data == size of read-ahead cache), only a lame attempt at,
well, being helpful in an imperfect world.
