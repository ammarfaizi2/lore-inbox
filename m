Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274789AbRKMP4I>; Tue, 13 Nov 2001 10:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273902AbRKMPz6>; Tue, 13 Nov 2001 10:55:58 -0500
Received: from rain.CC.Lehigh.EDU ([128.180.39.20]:62178 "EHLO
	rain.CC.Lehigh.EDU") by vger.kernel.org with ESMTP
	id <S273854AbRKMPz5>; Tue, 13 Nov 2001 10:55:57 -0500
Message-ID: <3BF14253.1060008@Lehigh.EDU>
Date: Tue, 13 Nov 2001 10:54:59 -0500
From: Jim Eshleman <jce0@Lehigh.EDU>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jim Eshleman <jce0@Lehigh.EDU>
CC: Jason Allen <jallen@fnal.gov>, linux-kernel@vger.kernel.org,
        linux-xfs@oss.sgi.com
Subject: Re: 2.4.13 Mem Related Hangs
In-Reply-To: <3BE6C909.6070308@Lehigh.EDU>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   FWIW me too, on an 8-way 8.5GB (64GB HIGHMEM enabled) IBM Netfinity 
> x370 (8500R) which functions as a production mail server.  I currently 
> run 2.4.9 with XFS and it stays up for about a week under heavy load. 
> 2.4.13 lasted about 4 hours under light load until all memory was 
> consumed by cache then it became unresponsive.
> 
>   2.4.13 on a 2-way 1GB (64GB HIGHMEM enabled) Netfinity x350 test box 
> with the same kernel config and XFS works fine even under stress, so 
> perhaps our problem is similar to the discussion on l-k "Google's mm 
> problems"...


   Update: I'm unable to make 2.4.14 fail on the test box (running 
Cerberus, bonnie++ against two XFS volumes, and LTP simultaneously) but 
it melts-down just as 2.4.13 does on the big production box.  A short 
time after all memory is eaten by file cache, and under light load, the 
machine becomes unresponsive.  It took about five minutes to login at 
the console.  No error messages on the console or in syslog.  Here's 
some info, it's obvious in the vmstat output where the melt-down occurs:

   kernel config: http://www.lehigh.edu/~jce0/2.4.14-config
   bootup messages: http://www.lehigh.edu/~jce0/2.4.14-messages
   vmstat 60 output: http://www.lehigh.edu/~jce0/2.4.14-vmstat
   ver_linux output: http://www.lehigh.edu/~jce0/ver_linux.out

   This is linus 2.4.14 patched with linux-2.4.14-xfs-2001-11-06.patch 
and LVM 0.9.1_beta6, compiled with egcs-2.91.66.  It's a RH 7.1 system.

   I know Andrea and Marcelo? were testing and fixing some HIGHMEM 
things.  Were there any patches and did they make it into the Linus tree?

   Any assistance greatly appreciated.

Jim


