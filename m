Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266512AbSKLONf>; Tue, 12 Nov 2002 09:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266581AbSKLONf>; Tue, 12 Nov 2002 09:13:35 -0500
Received: from vitelus.com ([64.81.243.207]:2308 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S266578AbSKLONe>;
	Tue, 12 Nov 2002 09:13:34 -0500
Date: Tue, 12 Nov 2002 06:20:14 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.47{-mm1} with contest
Message-ID: <20021112142014.GC15812@vitelus.com>
References: <1037057498.3dd03dda5a8b9@kolivas.net> <20021112030453.GB15812@vitelus.com> <3DD0E037.1FC50147@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD0E037.1FC50147@digeo.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 03:04:23AM -0800, Andrew Morton wrote:
> It will never be stunningly better than 2.4 for normal workloads on
> normal machines, because 2.4 just ain't that bad.

Actually, I am having serious problems with 2.4 (.20-pre5). Copying a
file from hda to hdc without really doing anything else goes very
slowly and lags the whole system ruthlessly. The load average rises to
about three. Any app which tries to touch the disk will hang for
several seconds. Yes, DMA is on on both drives (udma5), as well as
32-bit I/O and unmaskirq. Bad IDE controller or driver? I don't know.
It's a ServerWorks CSB5. I've been meaning to try 2.5-mm to see if it
improves this.

Another sort of offtopic 2.4 thing: I found an entry like this for every
running process in dmesg:

getty         S 00000013  5096 27557      1               24160 (NOTLB)
Call Trace:    [<c0114d3b>] [<c01be0f9>] [<c01b15a1>] [<c01b106d>] [<c01ad1f5>]
  [<c0136513>] [<c01239f8>] [<c0109107>]

This puzzles me because sysrq is turned OFF. How could this have
happened?
