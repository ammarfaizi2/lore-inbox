Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270332AbTHQQ2Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 12:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270354AbTHQQ2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 12:28:16 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:487
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270332AbTHQQ2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 12:28:14 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Voluspa <voluspa@comhem.se>
Subject: Re: [RFC] Re: Blender profiling-1 O16.2int
Date: Mon, 18 Aug 2003 02:34:41 +1000
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>
References: <20030817003128.04855aed.voluspa@comhem.se> <20030817073859.51021571.voluspa@comhem.se> <200308172336.42593.kernel@kolivas.org>
In-Reply-To: <200308172336.42593.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308180234.41545.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Addendum:

KernProfile during starvation:
   435 get_offset_tsc                            18.9130
   273 do_softirq                                 1.8079
   263 sys_gettimeofday                           1.3350
   121 do_gettimeofday                            0.9167
    72 fget                                       1.1077
    68 schedule                                   0.0465
    20 do_sys_settimeofday                        0.0943
    20 do_settimeofday                            0.0627
    14 fput                                       0.7000
    14 add_wait_queue                             0.1474
    11 __wake_up                                  0.1250
    11 remove_wait_queue                          0.0815
    11 do_anonymous_page                          0.0199
     9 pipe_poll                                  0.0726
     9 link_path_walk                             0.0040
     8 free_hot_cold_page                         0.0311

vmstat during starvation
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0      0  99716  56348 193256    0    0     0     0 1687  5962 92  8  0  0
 1  0      0  99716  56376 193256    0    0     0   144 1691  5976 81 19  0  0
 1  0      0  99748  56376 193256    0    0     0     0 1656  6057 87 13  0  0
 2  0      0  99748  56376 193256    0    0     0     0 1636  5477 85 15  0  0
11  0      0  99748  56376 193256    0    0     0     0 1430   445 51 49  0  0
12  0      0  99748  56376 193256    0    0     0     0 1459   362 52 48  0  0
12  0      0  99764  56392 193256    0    0     0    92 1474   400 51 49  0  0
12  0      0  99764  56392 193256    0    0     0     0 1463   356 53 47  0  0
12  0      0  99764  56392 193256    0    0     0     0 1466   379 50 50  0  0

Note drop in ctx, rise in load (although in top only blender is actually 
getting cpu at 99%) and massive rise in sys time.

Con

