Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVCHPVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVCHPVf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 10:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVCHPVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 10:21:35 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:44725 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261407AbVCHPVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 10:21:23 -0500
Message-ID: <422DC2F1.7020802@g-house.de>
Date: Tue, 08 Mar 2005 16:21:21 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050212)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: oom with 2.6.11
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hallo list,

today my machine went out out memory and noticing it several hours after
the first OOM message in the log, i wonder
   1) why this happened at all and
   2) why almost every service was killed despite the clever algorithms
      documented in mm/oom_kill.c.

the first oom message went to the syslog at 01:27, i was away and no heavy
tasks were scheduled:

http://nerdbynature.de/bits/sheep/2.6.11/oom/oom_2.6.11.txt

mysqld got killed by the oom killer, so i have to suspect mysql for being
the reason for oom here, even that i know that mysqld is running all day
long. several other tasks got killed, but "Free swap" stays at 0kB and the
oom killer kills almost every other tasks, with no success in freeing ram.

the log stops at 03:21, perhaps syslog-ng got killed.
at around 07:31 i noticed the mess, did SYSRQ-E and now i was able to
login again. i pressed SYSRQ-M/T/P too, they are all in the log. at this
time loadavg was at 249 ;)

i went to runlevel 2, then up again to 3 and all services are up and
running again.

some 2.6.11-rc3 BK snapshot was running pretty stable (no OOM) for ~30
days before i switched to 2.6.11 (vanilla) a few days ago. i have to (not)
reproduce the problem the next night, i wonder if it will happen again.

do you vm-gurus have any idea to the points asked above?

more infos about the box here: http://nerdbynature.de/bits/sheep/2.6.11/oom/


thank you for your comments,
Christian.
-- 
BOFH excuse #281:

The co-locator cannot verify the frame-relay gateway to the ISDN server.
