Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131478AbRCNRfI>; Wed, 14 Mar 2001 12:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131479AbRCNRe6>; Wed, 14 Mar 2001 12:34:58 -0500
Received: from zeus.kernel.org ([209.10.41.242]:34509 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131478AbRCNRet>;
	Wed, 14 Mar 2001 12:34:49 -0500
Date: Wed, 14 Mar 2001 12:31:22 -0500 (EST)
From: Richard A Nelson <cowboy@vnet.ibm.com>
X-X-Sender: <cowboy@badlands.lexington.ibm.com>
To: <linux-kernel@vger.kernel.org>
Subject: alarm() vs setitimer() problem?
Message-ID: <Pine.LNX.4.33.0103141226060.2359-100000@badlands.lexington.ibm.com>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is linux 2.4.2-ac19 (and to a lesser extent 2.2.19pre16) doing something
non-standard wrt setitimer?

On light to mid loaded machines (2-8 load average), it seems like I'm
missing some setitimer(REAL) signals !

Running the program using alarm() instead of setitimer(REAL) doesn't
miss events.

Both machines are UP, running glibc 2.2.2 and gcc 2.95.3

on 2.2.19pre16, chaning the interval from 60s to 180s seems to have
removed the problem

on 2.4.2-ac19, using 180s didn't change the problem at all, only running
with alarm() instead solves the problem.

-- 
Rick Nelson
Life'll kill ya                         -- Warren Zevon
Then you'll be dead                     -- Life'll kill ya

