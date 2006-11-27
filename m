Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757139AbWK0Gvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757139AbWK0Gvz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 01:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757140AbWK0Gvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 01:51:55 -0500
Received: from herkules.vianova.fi ([194.100.28.129]:32642 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S1757139AbWK0Gvy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 01:51:54 -0500
Date: Mon, 27 Nov 2006 08:51:51 +0200
From: Ville Herva <vherva@vianova.fi>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc7: ide_cd problems
Message-ID: <20061127065151.GB9923@vianova.fi>
Reply-To: vherva@vianova.fi
References: <20061125194534.GE9995@vianova.fi> <456A54CE.4090306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456A54CE.4090306@gmail.com>
X-Operating-System: Linux herkules.vianova.fi 2.4.32-rc1
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 12:00:30PM +0900, you [Tejun Heo] wrote:
> Ville Herva wrote:
> >When ripping a cd with grip, I noticed the drive was not in DMA mode. I did
> >hdparm -d1 /dev/hdi. The grip process (it uses libcdda_paranoia.so and
> >libcdda_interface.so) hung, and attempt to kill it with -KILL failed.
> >Eventually it died but remained as zombie:
> 
> Known problem but probably won't get fixed.  

Fair enough.

> Just use hdparm only when the drive is idle. Put it somewhere in the boot
> script.

I already did, but DMA had dropped off in the meanwhile. 

It did burn a dvd without a hitch with DMA=1, though.

> Hmm... IDE should enable DMA automatically for most cases.  Can you post 
> full dmesg?

Will do. I'll just have to boot first.

It's currently unavailable, as the 

[2416661.676213] attempt to access beyond end of device
[2416661.676216] loop0: rw=0, want=1401620, limit=946048

messages from loop (/dev/hdi is limited to 946048 block as I described) have
filled dmesg.

Thanks.



-- v -- 

v@iki.fi

