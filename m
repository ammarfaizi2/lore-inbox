Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287388AbSA0Ams>; Sat, 26 Jan 2002 19:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287401AbSA0Ame>; Sat, 26 Jan 2002 19:42:34 -0500
Received: from ns.suse.de ([213.95.15.193]:55822 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287388AbSA0AmR>;
	Sat, 26 Jan 2002 19:42:17 -0500
Date: Sun, 27 Jan 2002 01:42:16 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Jim McDonald <Jim@mcdee.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <andre@linuxdiskcert.org>
Subject: Re: IO Throughput Problem with 2.5.2-dj6 and HPT370 RAID Controller
In-Reply-To: <1012084624.1504.216.camel@lapcat>
Message-ID: <Pine.LNX.4.33.0201270139510.12210-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Jan 2002, Jim McDonald wrote:

> Which shows a couple of things: first, that the single-drive performance
> of 2.5.2-dj6 seems to be really low, and second that running both disks
> at the same time results in each disk itself transferring data faster
> than when they were running alone!

I'm not sure about the cause of the performance drop, but one thing
I did notice that maybe Andre can shed some insight on..

> Boot log from 2.4.17:
> hda: 53369568 sectors (27325 MB) w/2048KiB Cache, CHS=3322/255/63, UDMA(66)
> hdc: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=79408/16/63, UDMA(33)
> hde: 120069936 sectors (61476 MB) w/2048KiB Cache, CHS=119117/16/63, UDMA(100)
> hdg: 120069936 sectors (61476 MB) w/2048KiB Cache, CHS=119117/16/63, UDMA(100)
>
> Boot log from 2.5.2-dj6:
> hda: 53369568 sectors (27325 MB) w/2048KiB Cache, CHS=3322/255/63, UDMA(66)
> hdc: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=79408/16/63, UDMA(33)
> hde: 120069936 sectors (61476 MB) w/2048KiB Cache, CHS=119117/255/63, UDMA(100)
> hdg: 120069936 sectors (61476 MB) w/2048KiB Cache, CHS=119117/255/63, UDMA(100)

Note that the drives that are now reported as slower have slightly
different geometry. Andre ?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

