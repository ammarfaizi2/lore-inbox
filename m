Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268014AbUHXDXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268014AbUHXDXf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 23:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268539AbUHXDXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 23:23:32 -0400
Received: from mail-13.iinet.net.au ([203.59.3.45]:63392 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S268014AbUHXDX3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 23:23:29 -0400
Message-ID: <412AB4AC.8040702@cyberone.com.au>
Date: Tue, 24 Aug 2004 13:23:24 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Performance of -mm2 and -mm4
References: <336080000.1093280286@[10.10.2.4]>
In-Reply-To: <336080000.1093280286@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin J. Bligh wrote:

>Kernbench: (make -j vmlinux, maximal tasks)
>                              Elapsed      System        User         CPU
>                  2.6.8.1       43.90       87.76      572.94     1505.67
>              2.6.8.1-mm1       44.26       87.71      574.73     1496.33
>              2.6.8.1-mm2       44.27       90.27      574.84     1502.33
>              2.6.8.1-mm4       45.87       97.60      595.23     1510.00
>
>mm2 seems to take slightly (but consistently) more systime than mm1, and
>mm4 is significantly worse still ;-(
>
>

Increasing base_timeslice here takes about 10s off the user time,
and maybe 1-2 off elapsed. You may see a better improvement because
the machine I'm testing on has very small caches; I assume you are
using a 32-way NUMAQ with 1-2MB caches?

