Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751587AbVLFDuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbVLFDuw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 22:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbVLFDuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 22:50:51 -0500
Received: from rtr.ca ([64.26.128.89]:61824 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751587AbVLFDuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 22:50:51 -0500
Message-ID: <43950A99.5040907@rtr.ca>
Date: Mon, 05 Dec 2005 22:50:49 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Andy Isaacson <adi@hexapodia.org>
Cc: Pavel Machek <pavel@suse.cz>, Nigel Cunningham <ncunningham@cyclades.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
References: <20051205081935.GI22168@hexapodia.org> <20051205121728.GF5509@elf.ucw.cz> <1133791084.3872.53.camel@laptop.cunninghams> <200512052328.01999.rjw@sisk.pl> <1133831242.6360.15.camel@localhost> <20051206013759.GI1770@elf.ucw.cz> <20051206014720.GN22168@hexapodia.org>
In-Reply-To: <20051206014720.GN22168@hexapodia.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson wrote:
>
>>/dev/hda:
>> Timing buffered disk reads:  108 MB in  3.01 seconds =  35.85 MB/sec
> 
> That's quite a bit better than mine, and I am pretty sure I am the same
> vintage or newer (purchased this summer), but I'm getting barely half
> that speed:
>  Timing buffered disk reads:   58 MB in  3.10 seconds =  18.70 MB/sec
> 
> How can I find out what disk is in this beast and try to track down some
> of my missing performance? 

hdparm -I /dev/hda  (or cat /proc/ide/hda/model)

The FUJITSU MHV2100AH in my Dell i9300 gives 57.5 MB/sec with hdparm.
Note that hdparm does not read in the most efficient manner
(so the drive is likely even faster than that),
and writing to drives is normally slower than reading.

Cheers

