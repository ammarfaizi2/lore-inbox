Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132318AbRDWJxH>; Mon, 23 Apr 2001 05:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132434AbRDWJw5>; Mon, 23 Apr 2001 05:52:57 -0400
Received: from [202.54.26.202] ([202.54.26.202]:39127 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S132318AbRDWJwm>;
	Mon, 23 Apr 2001 05:52:42 -0400
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: linux-kernel@vger.kernel.org
Message-ID: <65256A37.0034E7B4.00@sandesh.hss.hns.com>
Date: Mon, 23 Apr 2001 15:01:34 +0530
Subject: xtime.tv_usec update in timer interrupt
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,
     In update_wall_one_tick() function, we have following
           xtime.tv_usec += tick + time_adjust_step.

where tick = (1000000 + hz/2)/hz.

In systems where we have TSC why we cannot use that to update xtime.tv_usec. It
should give better time estimate. and the values that are retured in
sys_gettimeofday would also be more accurate .

Amol



