Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267685AbSLTBhi>; Thu, 19 Dec 2002 20:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267686AbSLTBhi>; Thu, 19 Dec 2002 20:37:38 -0500
Received: from adsl-b3-74-176.telepac.pt ([213.13.74.176]:19153 "HELO
	puma-vgertech.no-ip.com") by vger.kernel.org with SMTP
	id <S267685AbSLTBhh>; Thu, 19 Dec 2002 20:37:37 -0500
Message-ID: <3E0276B9.40001@vgertech.com>
Date: Fri, 20 Dec 2002 01:47:37 +0000
From: Nuno Silva <nuno.silva@vgertech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021210 Debian/1.2.1-3
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Torben Frey <kernel@mailsammler.de>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Horrible drive performance under concurrent i/o jobs (dlh problem?)
References: <3E01D7D7.2070201@mailsammler.de>
In-Reply-To: <3E01D7D7.2070201@mailsammler.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Torben Frey wrote:

[..snip..]

> watching "vmstat 1" in another window - and this is what surprised me:
> when I stopped the copy job, there were 22 more seconds when data was
> still written to the backup software raid. Is this a hint where the
> problem could be? I have the same "feature" when I write to my 3ware.
> 

[..snip..]

AFAIK, this is because you have some GB of memory (RAM) that are beeing 
used as disk-cache. It took 22 seconds for the cached writes-to-disk 
being flushed to the device.

If 22 seconds is too much for the amount of cached disk-writes is 
another story :)

Maybe 3ware controllers are slow with many disks? Try the same with only 
3 disks to eliminate this variable.

Regards,
Nuno Silva

