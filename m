Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281795AbRLQSMh>; Mon, 17 Dec 2001 13:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281811AbRLQSMT>; Mon, 17 Dec 2001 13:12:19 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:6931 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S281795AbRLQSL6>; Mon, 17 Dec 2001 13:11:58 -0500
Date: Mon, 17 Dec 2001 10:05:42 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Andrey Nekrasov <andy@spylog.ru>
cc: Hubert Mantel <mantel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: amber/mars & ext3
In-Reply-To: <20011217161538.GA17099@spylog.ru>
Message-ID: <Pine.LNX.4.10.10112171004270.17715-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


How about I provide you the final patch for a domain validated driver.
This will then allow one to isolate and point back up the path to the real
problem.

Regards,

On Mon, 17 Dec 2001, Andrey Nekrasov wrote:

> Hello.
> 
> 1. /dev/ide/host0/bus1/target0/lun0/part1 on /b1 type ext3
> (rw,noatime,errors=remount-ro)
> 
> 2. dmesg
> 
> ...
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> EXT3-fs error (device ide1(22,1)): ext3_readdir: directory #2 contains a hole at
> offset 0
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> EXT3-fs error (device ide1(22,1)): ext3_readdir: directory #2 contains a hole at
> offset 0
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> EXT3-fs error (device ide1(22,1)): ext3_readdir: directory #2 contains a hole at
> offset 0
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> EXT3-fs error (device ide1(22,1)): ext3_readdir: directory #2 contains a hole at
> offset 0
> end_request: I/O error, dev 16:01 (hdc), sector 4160
> ...
> 
> 2. 
> 
> 2.4.16.SuSE-0
> 
> 3. 
> 
> /dev/ide/host0/bus1/target0/lun0/part1
>                        70G   55G   16G  77% /b1
> 4.
> 
> amber:/b1 # ls -la /b1
> total 0
> amber:/b1 #
> 
> -- 
> bye.
> Andrey Nekrasov, SpyLOG.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

