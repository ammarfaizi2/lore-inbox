Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267646AbSLFWnB>; Fri, 6 Dec 2002 17:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267650AbSLFWnB>; Fri, 6 Dec 2002 17:43:01 -0500
Received: from packet.digeo.com ([12.110.80.53]:21704 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267646AbSLFWnA>;
	Fri, 6 Dec 2002 17:43:00 -0500
Message-ID: <3DF129B6.E6F66A5@digeo.com>
Date: Fri, 06 Dec 2002 14:50:30 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.50 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: inkognito.anonym@uni.de, linux-kernel@vger.kernel.org
Subject: Re: [2.5.50] IDE error messages appearing after upgrade
References: <10525789281.20021206212219@uni.de> from "Tobias Rittweiler" at Dec 06, 2002 09:22:19 PM <200212062109.gB6L9GWe000553@darkstar.example.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Dec 2002 22:50:30.0114 (UTC) FILETIME=[E0656420:01C29D79]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> 
> ...
> > Dec  6 21:00:24 brood kernel: end_request: I/O error, dev hdc, sector 0
> > Dec  6 21:00:24 brood kernel: hdc: ATAPI 40X DVD-ROM drive, 512kB Cache
> > Dec  6 21:00:24 brood kernel: Uniform CD-ROM driver Revision: 3.12
> > Dec  6 21:00:24 brood kernel: end_request: I/O error, dev hdc, sector 0
> > Dec  6 21:00:24 brood kernel: end_request: I/O error, dev hdd, sector 0
> > Dec  6 21:00:24 brood kernel: end_request: I/O error, dev hdd, sector 0
> 
> Not sure about these, though.  I suspect that commands that only
> relate to disk devices are being sent to your CD-ROM drives, but
> somebody else will probably confirm/deny that.

It is a new message which was added.  They come out when anyone
tries to read from a CDROM drive which is empty.

Recent KDE setups have some gizmo which polls the CDROM once
per second for insertions.  With recent 2.5 kernels, this
results in the above message being sent to logs a couple of
hundred times a minute.

The new printk needs to be removed - I have raised this with
Jens and he agreed.
