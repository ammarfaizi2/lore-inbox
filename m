Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263310AbSKRRxu>; Mon, 18 Nov 2002 12:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263135AbSKRRxu>; Mon, 18 Nov 2002 12:53:50 -0500
Received: from [66.59.111.190] ([66.59.111.190]:6795 "EHLO sparrow.stearns.org")
	by vger.kernel.org with ESMTP id <S263968AbSKRRxs>;
	Mon, 18 Nov 2002 12:53:48 -0500
Date: Mon, 18 Nov 2002 13:00:38 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: wstearns@sparrow
Reply-To: William Stearns <wstearns@pobox.com>
To: ML-linux-kernel <linux-kernel@vger.kernel.org>
cc: William Stearns <wstearns@pobox.com>
Subject: 2.4.20-pre11: swap_dup/swap_free: Bad swap file/offset entry
Message-ID: <Pine.LNX.4.44.0211181220050.17833-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, all,
	I'm running 2.4.20-pre11 on an SMP Athlon system.  System details 
are at:

http://www.stearns.org/slartibartfast/cpuinfo
http://www.stearns.org/slartibartfast/dma
http://www.stearns.org/slartibartfast/dmesg.2.4.20-pre11
http://www.stearns.org/slartibartfast/fstab
http://www.stearns.org/slartibartfast/interrupts
http://www.stearns.org/slartibartfast/iomem
http://www.stearns.org/slartibartfast/ioports
http://www.stearns.org/slartibartfast/lspci-vvv
http://www.stearns.org/slartibartfast/meminfo
http://www.stearns.org/slartibartfast/

        (30 second summary; Dual AMD Athlon(tm) MP 1900+'s, 2G registered 
ECC ram, 360G raid array on a 3ware raid card (raid 5 across 4 120G ide's, 
dual 3C980-TX onboard nics, noapic, rack mounted.)

	In addition to ps hangs that I've posted to this list before (Nov 
11th, Subject: "2.4.20-pre11 crash: kernel NULL pointer dereference in 
proc_pid_stat."), I've found a problem with swap errors showing up in the 
log:

      1	swap_dup: Bad sËfile entry f4afc554
     22	swap_dup: Bad swap file entry c0027e3c
      3	swap_dup: Bad swap file entry c04ee768
      1	swap_dup: Bad swap file entry c091971c
      3	swap_dup: Bad swap file entry c0b0412c
      2	swap_dup: Bad swap file entry c0bb971c
      2	swap_dup: Bad swap file entry c0df4b44
      1	swap_dup: Bad swap file entry c2d37508
     22	swap_dup: Bad swap file entry c2e2c97c
[snip]
      8	swap_dup: Bad swap file entry f6ee3554
     19	swap_dup: Bad swap file entry f717fb44
      4	swap_dup: Bad swap file entry f742412c
     16	swap_free: Bad swap file entry c0027e3c
      1	swap_free: Bad swap file entry c003784c
      3	swap_free: Bad swap file entry c04ee768
      1	swap_free: Bad swap file entry c055f768
      1	swap_free: Bad swap file entry c05df12c
      1	swap_free: Bad swap file entry c091971c
      1	swap_free: Bad swap file entry c09c2178
      1	swap_free: Bad swap file entry c0a0d210
      1	swap_free: Bad swap file entry c0a90f20
      4	swap_free: Bad swap file entry c0b0412c
      2	swap_free: Bad swap file entry c0bb971c
[snip]
     19	swap_free: Bad swap file entry f4afc554
      1	swap_free: Bad swap file entry f52c8424
      5	swap_free: Bad swap file entry f5419178
     20	swap_free: Bad swap file entry f587a71c
      2	swap_free: Bad swap file entry f5c37d58
     28	swap_free: Bad swap file entry f6b9225c
      1	swap_free: Bad swap file entry f6e57c28
      7	swap_free: Bad swap file entry f6ee3554
     17	swap_free: Bad swap file entry f717fb44
      1	swap_free: Bad swap file entry f7187930
      4	swap_free: Bad swap file entry f742412c
      1	swap_free: Bad swap offset entry c60ce800
      3	swap_free: Bad swap offset entry d089b800
      2	swap_free: Bad swap offset entry dc936800
      1	swap_free: Bad swap offset entry e6bd9800
      1	swap_free: Bad swap offset entry eb5b0800
      6	swap_free: Bad swap offset entry ec6cf800

	These showed up before userspace died (again :-) yesterday.  The 
system successfully passed 7 passes of memtest86 a few weeks back.
	Cheers,
	- Bill

---------------------------------------------------------------------------
        perl -le '$_="6110>374086;2064208213:90<307;55";tr[0->][ LEOR!AUBGNSTY];print'
(Courtesy of George Bakos)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, named2hosts, 
and ipfwadm2ipchains are at:                        http://www.stearns.org
--------------------------------------------------------------------------


