Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVEWXLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVEWXLk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVEWXJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:09:43 -0400
Received: from Boole.cs.uh.edu ([129.7.240.11]:64139 "EHLO boole.cs.uh.edu")
	by vger.kernel.org with ESMTP id S261220AbVEWXEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 19:04:52 -0400
Message-ID: <33567.129.7.248.115.1116889489.squirrel@129.7.248.115>
Date: Mon, 23 May 2005 18:04:49 -0500 (CDT)
Subject: kernel 2.6.11.10, smp nice patch results ??
From: "Deepti Vyas" <dvyas@cs.uh.edu>
To: linux-kernel@vger.kernel.org
Reply-To: dvyas@cs.uh.edu
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried using 2.6.11.10 with patch-2.6.11-smpnice-1.diff.

So this is the output of top:
--------------

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  #C COMMAND
 3672 deepti    39  19 69116 2104  872 R 93.8  0.2   1:37.75  1 ep.B.4.nice
 3645 deepti    15   0  126m  57m 1188 R 43.9  5.7   0:52.26  0 cg.B.8
 3660 deepti    15   0  126m  56m 1124 R 41.6  5.6   0:47.24  0 cg.B.8
 3721 deepti    16   0  1944  940  760 R  0.3  0.1   0:00.02  1 top
    1 root      16   0  1680  552  480 S  0.0  0.1   0:00.84  1 init
    2 root      RT   0     0    0    0 S  0.0  0.0   0:00.00  0 migration/0

The nice application si still monopolizing CPU.

--------------

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  #C COMMAND
 3915 deepti    18   0  182m 110m 1484 R 56.5 10.9   3:19.71  1 cg.B.4
 3940 deepti    39  19 69116 2100  868 R 55.5  0.2   2:08.20  1 ep.B.2.nice
 3930 deepti    15   0  182m  95m 1420 S 50.5  9.5   2:37.74  0 cg.B.4
 3963 deepti    16   0  126m  57m 1196 R 23.8  5.7   0:31.12  0 cg.B.8
 3978 deepti    15   0  126m  56m 1132 S 12.9  5.6   0:29.19  0 cg.B.8
 3994 deepti    16   0  1944  948  764 R  1.0  0.1   0:00.14  1 top

Again the nice is getting more CPU than others.

----------

Can anyone suggest how to rectify this.

Thanks
Deepti



> You won't get -mm to work with that patch pure and simple. Get a 2.6.11
> based
> kernel (the latest 2.6.11.10 will work) and apply:
> http://ck.kolivas.org/patches/smpnice/patch-2.6.11-smpnice-1.diff
>
> Con
>




