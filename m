Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266239AbUBDFsu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 00:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUBDFsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 00:48:50 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:15783 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266239AbUBDFso
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 00:48:44 -0500
Message-ID: <402087B3.1080302@cyberone.com.au>
Date: Wed, 04 Feb 2004 16:48:35 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Philip Martin <philip@codematters.co.uk>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
References: <87oesieb75.fsf@codematters.co.uk>	<20040202194626.191cbb95.akpm@osdl.org>	<87llnk2js9.fsf@codematters.co.uk>	<20040203132913.6145f4e6.akpm@osdl.org> <87znbzg78o.fsf@codematters.co.uk>
In-Reply-To: <87znbzg78o.fsf@codematters.co.uk>
Content-Type: multipart/mixed;
 boundary="------------040305010402090206050407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040305010402090206050407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Philip Martin wrote:

>Andrew Morton <akpm@osdl.org> writes:
>
>
>>>2.6.1
>>>
>>Odd.  Are you really sure that it was the correct System.map?
>>
>
>I think so. I always build kernels using Debian's kernel-package so
>both vmlinuz and System.map get placed into a .deb package as
>vmlinuz-2.6.1 and System.map-2.6.1.
>
>$ ls -l /boot/Sys*
>-rw-r--r--    1 root     root       492205 Dec  1 19:27 /boot/System.map-2.4.23
>-rw-r--r--    1 root     root       492205 Jan  5 21:21 /boot/System.map-2.4.24
>-rw-r--r--    1 root     root       715800 Feb  1 21:02 /boot/System.map-2.6.1
>
>$ ls -l /boot/vm*
>-rw-r--r--    1 root     root       880826 Dec  1 19:27 /boot/vmlinuz-2.4.23
>-rw-r--r--    1 root     root       880822 Jan  5 21:21 /boot/vmlinuz-2.4.24
>-rw-r--r--    1 root     root      1095040 Feb  1 21:02 /boot/vmlinuz-2.6.1
>
>Hmm, I see that my 2.6.1 image is 25% bigger than 2.4.24, I'd not
>noticed that before.
>
>

That's progress for you...

>I have just tried another 2.6 profile run and got similar results.
>
>248.88user 122.00system 3:41.18elapsed 167%CPU (0avgtext+0avgdata 0maxresident)k
>0inputs+0outputs (453major+3770323minor)pagefaults 0swaps
>
>

Thanks for your patience. What are you building, by the way? It
slipped my mind.

You could try an experimental VM patch out if you're feeling brave.
Don't know if it will do you any good or not. You'll have to use
this patch against the 2.6.2-rc3-mm1 kernel.

What I really want to know though, is why it appears like 2.6 is
doing twice as much writeout even at the same vm thresholds as 2.4.

Nick


--------------040305010402090206050407
Content-Type: application/x-tar;
 name="vm-swap-3.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="vm-swap-3.gz"

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
JgZtCW1gAAA=
--------------040305010402090206050407--
