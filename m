Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317003AbSFFQVC>; Thu, 6 Jun 2002 12:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317004AbSFFQVB>; Thu, 6 Jun 2002 12:21:01 -0400
Received: from ns1.ptt.yu ([212.62.32.1]:12483 "EHLO ns1.ptt.yu")
	by vger.kernel.org with ESMTP id <S317003AbSFFQVB>;
	Thu, 6 Jun 2002 12:21:01 -0400
Subject: Process-Shared Mutex (futex) - What is it good for ?
From: Vladimir Zidar <vladimir@mindnever.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 06 Jun 2002 18:21:01 +0200
Message-Id: <1023380463.1751.39.camel@server1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Nice to have everything as POSIX says, but how could process-shared
mutex be usefull ? Imagine two processes useing one mutex to lock shared
memory area. One process locks, and then dies (for example, it goes
sigSEGV way). Second process could wait for ages (untill reboot ?) and
it won't get lock() on that mutex ever. Wouldn't it be more usefull to
have automatic mutex cleanup after process death ? Just make a cleanup,
and mark it as 'damaged', so other processes will eventualy get error
saying that something went wrong.


-- 
Bye,

 and have a very nice day !



