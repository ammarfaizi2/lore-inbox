Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266670AbUGQIuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266670AbUGQIuY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 04:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUGQIuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 04:50:23 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:5785 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S266670AbUGQIuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 04:50:22 -0400
Message-ID: <40F8E868.7000008@colorfullife.com>
Date: Sat, 17 Jul 2004 10:50:48 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
Subject: Re: [RFC] Lock free fd lookup
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wli wrote

>> * It requires type stable storage.  That is, once a data area has been
>>   allocated to a particular structure type, it always contains that
>>   structure type, even when it has been freed from the list.  Each list
>>   requires its own free pool, which can never be returned to the OS.
>
>The last of these is particularly lethal.
>  
>
It might be possible to combine such a lock free algorithms with RCU and 
then set Hugh's SLAB_DESTROY_BY_RCU: It inserts a call_rcu between 
leaving the free pool and returning the page to the OS.

--
    Manfred
