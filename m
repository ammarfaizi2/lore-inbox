Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267263AbUHIUin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267263AbUHIUin (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 16:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267249AbUHIUic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 16:38:32 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:45994 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S267198AbUHIUhT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 16:37:19 -0400
Date: Mon, 9 Aug 2004 16:40:51 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: davidsen@oddball.prodigy.com
To: linux-kernel@vger.kernel.org
Subject: Mozilla hang with 2.6.8-rc3-mm1
Message-ID: <Pine.LNX.4.44.0408091634420.32016-100000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running this kernel, preempt enabled, SMP enabled to get it to compile, I 
get Mozilla hangs, seemingly caused by a zombie process. I say that 
cautiously, the zombie is not seen when the hang is not present, the hang 
always has the zombie, they may have common cause.

ps output attached, config is on another machine not currently mountable. 
At this point just a heads up, I don't have enough info to debug. This is 
Mozilla 7.1, I'm going to upgrade to 7.1.2 because of security issues, 
I'll repost with config if the problem comes back, the NFS server machine 
will be up by noon tomorrow.

~~~~

 1349 ?        S      0:00  \_ /bin/sh /usr/bin/mozilla PWD=/home/davidsen 
TZ=EST5EDT XAUTHORITY=/ho
 1359 ?        S      0:00      \_ /bin/sh 
/usr/local/mozilla/run-mozilla.sh /usr/local/mozilla/mozi
 1364 ?        S     41:25          \_ /usr/local/mozilla/mozilla-bin 
PWD=/home/davidsen XSUNTRANSPO
 1368 ?        S      0:06              \_ /usr/local/mozilla/mozilla-bin 
PWD=/home/davidsen XSUNTRA
 1369 ?        S      0:17              |   \_ 
/usr/local/mozilla/mozilla-bin PWD=/home/davidsen XSU
 1371 ?        S      6:53              |   \_ 
/usr/local/mozilla/mozilla-bin PWD=/home/davidsen XSU
31520 ?        Z      0:00              \_ [netstat] <defunct>


