Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315417AbSELUfy>; Sun, 12 May 2002 16:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315419AbSELUfx>; Sun, 12 May 2002 16:35:53 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:19606 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S315417AbSELUfv>;
	Sun, 12 May 2002 16:35:51 -0400
Message-ID: <3CDED21B.3050208@colorfullife.com>
Date: Sun, 12 May 2002 22:35:39 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?iso-8859-2?Q?Witek_Kr=EAcicki?= <adasi@kernel.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG 2.5.X] Hollow processes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > It's impossible to check what the process is (trying to read
 > /proc/{pid}/{anyting} causes reading process to hang in the
 > same way (so we have now 2 hanging processes).

Have you tried SysRQ+showTasks? That dumps the kernel stack. You can 
convert the numbers to names with ksymoops, or often klogd will convert 
them and the result is in /var/log/messages.

What exactly hangs?
Could you run

	strace ls /proc/1234
	strace cat /proc/1234/maps
	strace ls /proc/1234/fd -l

Which syscall hangs?
SMP or UP?

-- 

	Manfred

