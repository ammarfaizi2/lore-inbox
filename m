Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132941AbRDRBOp>; Tue, 17 Apr 2001 21:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132948AbRDRBOc>; Tue, 17 Apr 2001 21:14:32 -0400
Received: from ladakh.smo.av.com ([209.73.174.140]:59144 "EHLO
	ladakh.smo.av.com") by vger.kernel.org with ESMTP
	id <S132941AbRDRBOS>; Tue, 17 Apr 2001 21:14:18 -0400
Message-ID: <3ADC7144.36E715C5@av.com>
Date: Tue, 17 Apr 2001 09:37:24 -0700
From: Laurent Chavet <lchavet@av.com>
Organization: AltaVista Company
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Is there a way to turn file caching off ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running on a machine with 2GB of memory and dual PIII 550MHZ.
Just after boot with "nothing else running":
I run a program that almost like dd if=/dev/null of=/local/test
count=10000 bs=1000000
Except that there is a thread for reading and a thread for writing.
The program itself almost doesn't take any CPU.
What's going on is top showing:
    First cache grows to the size of RAM (2GB) with transfer rate
slowing down as the cache grows.
    Then the transfer rates drops a lot (2 to 3 time slower than the
drive capacity) and there is a very high CPU usage of system time (more
than a CPU) used by bdflush and kswapd (and some others like kupdated).

Of course my real application doesn't go from /dev/zero to file but it
still only does sequential access, and it seems that I pay a high price
for the file caching when I'm not using it at all.

Is there a way to turn file caching off, or at least limit its size ?

Thanks,

Laurent Chavet

