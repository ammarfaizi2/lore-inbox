Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262602AbSKDTVa>; Mon, 4 Nov 2002 14:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262625AbSKDTVa>; Mon, 4 Nov 2002 14:21:30 -0500
Received: from packet.digeo.com ([12.110.80.53]:61420 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262602AbSKDTV3>;
	Mon, 4 Nov 2002 14:21:29 -0500
Message-ID: <3DC6CA38.1B027BD7@digeo.com>
Date: Mon, 04 Nov 2002 11:27:52 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vasya vasyaev <vasya197@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Machine's high load when HIGHMEM is enabled
References: <3DC5337C.4090506@quark.didntduck.org> <20021104185435.11019.qmail@web20504.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Nov 2002 19:27:55.0045 (UTC) FILETIME=[46310D50:01C28438]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vasya vasyaev wrote:
> 
> Hello,
> 
> First of all - thanks to these people, who responded
> to my question.
> 
> I have some news...
> 
> I've tried kernels:
> 2.4.19 - the same result
> 2.5.44 - the same result
> 2.5.45 - the same result
> 
> If I take 1 Gb of memory away, then computer works
> much better, faster (something like without enabled
> HIGHMEM at all).
> The same effect takes place if I say mem=1024M while
> physically box has 2Gb of RAM - everything is fine!
> But if I start HIGHMEM enabled kernel on this box (2Gb
> RAM), then it works too slowly...
> 

Please ensure that the mtrr driver is enabled in kernel config,
boot with mem=2G and send the output of `cat /proc/mtrr'.

Also, `dmesg | head -120' would be interesting.
