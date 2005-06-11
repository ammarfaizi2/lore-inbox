Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVFKXjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVFKXjL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 19:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVFKXjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 19:39:11 -0400
Received: from mailfe04.swip.net ([212.247.154.97]:40076 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261848AbVFKXjH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 19:39:07 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: VmallocTotal meminfo
From: Alexander Nyberg <alexn@telia.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0506112225330.2372@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0506112225330.2372@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 12 Jun 2005 01:39:04 +0200
Message-Id: <1118533144.968.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lör 2005-06-11 klockan 22:27 +0200 skrev Jan Engelhardt:
> Hi,
> 
> 
> /proc/meminfo:
> MemTotal:       256656 kB
> MemFree:         32480 kB
> ...
> LowTotal:       256656 kB
> LowFree:         32480 kB
> SwapTotal:      530136 kB
> SwapFree:       530136 kB
> ...
> VmallocTotal:   778164 kB
> VmallocUsed:     22468 kB
> VmallocChunk:   755404 kB
> 
> What's the VmallocTotal telling me? How is it calculated?
> I ask because running a surprisingly modern Linux on a surprisingly ancient 
> machine results in VmallocTotal being somewhere in the 1-gigabyte range, which 
> can _never_ ever be.

The kernel has one gigabyte to map on x86. In your case 256M is used for
RAM and the most of the rest can go to vmalloc. VmallocTotal merely
indicates the amount of virtual memory that can be used for vmalloc'ed
(non-contigous) mappings. There's not much more fun to do with the
remaining kernel virtual memory so...

There's really not much to it.

