Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269270AbTGJNWm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 09:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269271AbTGJNWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 09:22:41 -0400
Received: from franka.aracnet.com ([216.99.193.44]:26050 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S269270AbTGJNWk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 09:22:40 -0400
Date: Thu, 10 Jul 2003 06:36:46 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org
Subject: Re: [announce, patch] 4G/4G split on x86, 64 GB RAM (and more) support
Message-ID: <86930000.1057844205@[10.10.2.4]>
In-Reply-To: <80050000.1057800978@[10.10.2.4]>
References: <Pine.LNX.4.44.0307082332450.17252-100000@localhost.localdomain> <80050000.1057800978@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Results now with highpte

2.5.74-bk6-44 is with the patch applied
2.5.74-bk6-44-on is with the patch applied and 4/4 config option.
2.5.74-bk6-44-hi is with the patch applied and with highpte instead.

Overhead of 4/4 isn't much higher, and is much more generally useful.

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
                   2.5.74       46.11      115.86      571.77     1491.50
            2.5.74-bk6-44       45.92      115.71      570.35     1494.75
         2.5.74-bk6-44-on       48.11      134.51      583.88     1491.75
         2.5.74-bk6-44-hi       47.06      131.13      570.79     1491.50

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.74       100.0%         0.1%
            2.5.74-bk6-44       100.3%         0.7%
         2.5.74-bk6-44-on        92.1%         0.2%
         2.5.74-bk6-44-hi        94.5%         0.1%


