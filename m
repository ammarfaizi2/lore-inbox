Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319392AbSIFVCA>; Fri, 6 Sep 2002 17:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319397AbSIFVB7>; Fri, 6 Sep 2002 17:01:59 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:39329 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S319392AbSIFVB6>;
	Fri, 6 Sep 2002 17:01:58 -0400
Message-ID: <3D7918E8.5030000@colorfullife.com>
Date: Fri, 06 Sep 2002 23:06:48 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Paul Larson <plars@linuxtestproject.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pid_max hang again...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Searching for a free pid value and inserting the thread into the task 
list should be atomic, otherwise the same pid value could be given to 2 
threads.

do_fork runs without the BLK, you might have to search for the pid 
within the write_lock_irq(&tasklist_lock) block.

--
	Manfred

