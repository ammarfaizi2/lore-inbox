Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319273AbSH2TAg>; Thu, 29 Aug 2002 15:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319282AbSH2TAg>; Thu, 29 Aug 2002 15:00:36 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:20145 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319273AbSH2TAf>;
	Thu, 29 Aug 2002 15:00:35 -0400
Message-ID: <3D6E6FD1.8040204@us.ibm.com>
Date: Thu, 29 Aug 2002 12:02:41 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020822
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org,
       akpm@zip.com.au, Gerrit Huizenga <gerrit@us.ibm.com>,
       Hans-J Tannenberger <hjt@us.ibm.com>,
       Janet Morgan <janetmor@us.ibm.com>, Mike Anderson <andmike@us.ibm.com>,
       Martin Bligh <mjbligh@us.ibm.com>
Subject: Re: 2.5.32 IO performance issues
References: <Pine.LNX.4.44L.0208291538470.1857-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Thu, 29 Aug 2002, Badari Pulavarty wrote:
>>I am having severe IO performance problems with 2.5.32 (2.5.31 works fine).
>>I was wondering what caused this.
>>
>>As you can see, IO rate went from
>>
>>		384MB/sec with 6% CPU utilization on 2.5.31
>>			to
>>		120MB/sec with 19% CPU utilization on 2.5.32
>>
>>Any idea ?
> 
> 384 MB/s is suspiciously fast.  What kind of disk subsystem
> do you have to achieve that speed ?

Oh, that's nothing! :)

> Hardware: 8x 700MHz P-III, 4 Qlogic FC controllers, 40 disks
> Test: 40 dds on 40 raw devices (40 disks).

One tray of 10 10k RPM disks, per controller.  The controllers are also 
spread across 2 completely separate 64bit/66Mhz PCI busses (not bridged).

   Bus 10, device   8, function  0:
     SCSI storage controller: QLogic Corp. QLA2200 (#2) (rev 5).
       IRQ 23.
       Master Capable.  Latency=96.  Min Gnt=64.
       I/O at 0xb000 [0xb0ff].
       Non-prefetchable 32 bit memory at 0xfe1ff000 [0xfe1fffff].
   Bus 10, device   9, function  0:
     SCSI storage controller: QLogic Corp. QLA2200 (#3) (rev 5).
       IRQ 24.
       Master Capable.  Latency=96.  Min Gnt=64.
       I/O at 0xb100 [0xb1ff].
       Non-prefetchable 32 bit memory at 0xfe1fe000 [0xfe1fefff].
   Bus 13, device   6, function  0:
     SCSI storage controller: QLogic Corp. QLA2200 (#4) (rev 5).
       IRQ 21.
       Master Capable.  Latency=96.  Min Gnt=64.
       I/O at 0xd000 [0xd0ff].
       Non-prefetchable 32 bit memory at 0xfebff000 [0xfebfffff].
   Bus 13, device   7, function  0:
     SCSI storage controller: QLogic Corp. QLA2200 (#5) (rev 5).
       IRQ 22.
       Master Capable.  Latency=96.  Min Gnt=64.
       I/O at 0xd100 [0xd1ff].
       Non-prefetchable 32 bit memory at 0xfebfe000 [0xfebfefff].


-- 
Dave Hansen
haveblue@us.ibm.com

