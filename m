Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317242AbSFCAdS>; Sun, 2 Jun 2002 20:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317240AbSFCAdR>; Sun, 2 Jun 2002 20:33:17 -0400
Received: from jaded.cynicism.com ([206.129.95.68]:9227 "HELO
	jaded.cynicism.com") by vger.kernel.org with SMTP
	id <S317238AbSFCAdQ>; Sun, 2 Jun 2002 20:33:16 -0400
Date: Sun, 2 Jun 2002 17:33:04 -0700 (PDT)
From: Derek Vadala <derek@cynicism.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Tedd Hansen <tedd@konge.net>, Christian Vik <christian@konge.net>,
        Lars Christian Nygaard <lars@snart.com>
Subject: Re: RAID-6 support in kernel?
In-Reply-To: <Pine.LNX.4.33.0206030044270.27651-100000@mail.pronto.tv>
Message-ID: <Pine.GSO.4.21.0206021721120.15478-100000@gecko.roadtoad.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2002, Roy Sigurd Karlsbakk wrote:

> I am aware of that not all kernel hackers like such configurations, and
> that some will rather see small RAID-configurations connected with VLM.  
> I beleive there is a reason for using RAID-6, and RAID-controller vendors
> (such as Compaq) are already using them, so why shouldn't linux do so
> also? With a high number of cheap IDE drives, the chance of one failing is 
> quite high, so why not RAID-6? At least for a system doing most reads...

See the following thread from March 2002 on linux-raid:
http://groups.google.com/groups?hl=en&lr=&safe=off&th=804941541a023c63&seekm=linux.raid.Pine.LNX.4.44.0203261239110.12942-100000

You can always fake this effect by combining two 8-disk RAID-5s into a
RAID-0. It's not technically RAID-6, but can withstand a 2-disk failure,
although not _any_ 2-disk failure. However, it's my understanding that
RAID-6 cannot withstand _any_ two disk failure either (see the above
thread). 

I also suspect that the use of dual RAID-5s combined with the CPU overhead
of ATA will kill most systems under any kind of load. For that matter, the
2x parity hit from RAID-6 probably wouldn't make you CPU too happy either,
even if there was a kernel driver that implemented it.

---
Derek Vadala, derek@cynicism.com, http://www.cynicism.com/~derek


