Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbTIABr4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 21:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbTIABr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 21:47:56 -0400
Received: from dyn-ctb-210-9-245-175.webone.com.au ([210.9.245.175]:14340 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262036AbTIABrz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 21:47:55 -0400
Message-ID: <3F52A546.9020608@cyberone.com.au>
Date: Mon, 01 Sep 2003 11:47:50 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy v10
References: <3F5044DC.10305@cyberone.com.au> <1806700000.1062361257@[10.10.2.4]> <1807550000.1062362498@[10.10.2.4]>
In-Reply-To: <1807550000.1062362498@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin J. Bligh wrote:

>>Kernbench: (make -j vmlinux, maximal tasks)
>>                              Elapsed      System        User         CPU
>>              2.6.0-test4       45.87      116.92      571.10     1499.00
>>       2.6.0-test4-nick10       46.91      114.03      584.16     1489.25
>>
>
>Actually, now looks like you have significantly more idle time, so perhaps
>the cross-cpu (or cross-node) balancing isn't agressive enough:
>

Yeah, there is a patch for this in mm that is not in mine. It should
help both mine and mainline though...

Looks like mine is still context switching a bit more by the increased
user time but its probably nearly acceptable now.


