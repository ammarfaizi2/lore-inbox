Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbUCEIAi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 03:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUCEIAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 03:00:38 -0500
Received: from main.gmane.org ([80.91.224.249]:40606 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262128AbUCEIAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 03:00:36 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Weird utmp (?) problem on 2.6.4-rc1-mm{1,2}
Date: Thu, 04 Mar 2004 23:44:33 -0800
Message-ID: <pan.2004.03.05.07.44.32.964894@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-195-135.dsl.pltn13.pacbell.net
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that 2.6.4-rc1-mm[12] are not recycling ptys:

23:43:39 up 16:37,  5 users,  load average: 0.39, 0.30, 0.21
USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT
joshk    tty1     -                21:45    1:58m  1:57   0.00s /bin/sh /usr/bi
joshk    pts/22   :0.0             21:45    3:02   1.12s  1.12s ssh influx
joshk    pts/23   :0.0             21:45    0.00s  0.02s  0.00s w
joshk    pts/28   :0.0             22:25    1:16m  0.02s  0.02s -bash

When I close a terminal, and open another, the pts/ should be reused,
shouldn't it?

-- 
Joshua Kwan


