Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266201AbTGIXVY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 19:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266205AbTGIXVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 19:21:23 -0400
Received: from [213.4.129.129] ([213.4.129.129]:14501 "EHLO tsmtp7.mail.isp")
	by vger.kernel.org with ESMTP id S266201AbTGIXVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 19:21:22 -0400
Date: Thu, 10 Jul 2003 01:36:00 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: benchmark: 2.5 io test regression?
Message-Id: <20030710013600.1483e80a.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I just went to my 2.5 kernel source tree and i did

#time grep foo * -r

in both 2.4 & 2.5

doing this in 2.4 takes:
real    0m50.614s
user    0m1.150s
sys     0m2.560s

2.5.74-mm3 AS:
real    0m46.207s
user    0m1.156s
sys     0m3.161s

2.5.74-mm3 deadline:
real    0m57.418s
user    0m1.160s
sys     0m3.107s

I repeated the tests and they show very similar numbers. One time 2.4 was faster
than 2.5 with AS.
Hardware is p3 2x800 UDMA 100 7200 rpm 2 MB ide disk, filesystem ext3 (default
mount options). DMA was activated in both 2.4 and 2.5.


Should 2.5 be faster here, or it's the expected behaviour? I'd
have expected a bit more of AS, but perhaps AS it isn't good for
this benchmark?



