Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261950AbSKCO0D>; Sun, 3 Nov 2002 09:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261955AbSKCO0D>; Sun, 3 Nov 2002 09:26:03 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:1164 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S261950AbSKCO0B>; Sun, 3 Nov 2002 09:26:01 -0500
Message-ID: <3DC5337C.4090506@quark.didntduck.org>
Date: Sun, 03 Nov 2002 09:32:28 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vasya vasyaev <vasya197@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Machine's high load when HIGHMEM is enabled
References: <20021103141753.50480.qmail@web20503.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vasya vasyaev wrote:
> Hello,
> 
> I have some strange kind of problem:
> When HIGHMEM-enabled kernel is used, there is too high
> CPU load on any task - computer get loaded high while
> it is doing some minor, usual jobs (load average grows
> significantly).

2.4 can only do I/O to and from lowmem.  This means highmem pages have 
to use bounce buffers in lowmem, and th edata is copied to/from highmem 
which is causing the cpu load.  This has been corrected in 2.5, which 
can do I/O to any page the device can DMA from.

--
				Brian Gerst

