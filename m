Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbRBWUAc>; Fri, 23 Feb 2001 15:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129193AbRBWUAW>; Fri, 23 Feb 2001 15:00:22 -0500
Received: from quicksilver.ukc.ac.uk ([129.12.21.11]:22451 "EHLO
	quicksilver.ukc.ac.uk") by vger.kernel.org with ESMTP
	id <S129134AbRBWUAI>; Fri, 23 Feb 2001 15:00:08 -0500
To: linux-kernel@vger.kernel.org
Subject: VM balancing problems under 2.4.2-ac1
From: Adam Sampson <azz@gnu.org>
Organization: The Campaign For The Writing Of "a lot" As Two Words
Content-Type: text/plain; charset=US-ASCII
Date: 23 Feb 2001 20:00:01 +0000
Message-ID: <87vgq1p3um.fsf@cartman.azz.net>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Carlsbad Caverns)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hiya.

The VM balancing updates in the recent ac kernels seem to have caused
some interesting performance problems on my desktop machine. I've got
160Mb of RAM, and 2.4.2-ac1 appears to be using excessively large
amounts of it for buffers and cache while pushing stuff out to
swap. This means that Mozilla, for instance, runs significantly worse
than under 2.4.0, since bits of it are being swapped in and out.

After the machine had been sitting for a while not doing very much:
   procs                      memory    swap          io     system
     cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in   cs
us  sy  id
 1  0  0  97184   2116  12844 111768   5   6    15    11  154  791
29   4  67

After some heavy reiserfs disk IO (deleting lots of small files):
   procs                      memory    swap          io     system
     cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs
us  sy  id
 1  0  0 102620   1796  85836  43880 100   0    25     0  190   587
12   3  85

-- 

Adam Sampson
azz@gnu.org
