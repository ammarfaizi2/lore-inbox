Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUBFTA5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 14:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265611AbUBFTA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 14:00:57 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:60087
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S264246AbUBFTAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 14:00:55 -0500
Message-ID: <4023E4DB.5020801@tmr.com>
Date: Fri, 06 Feb 2004 14:02:51 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Johannes Stezenbach <js@convergence.de>
CC: Mike Black <mblack@csi-inc.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Hotswap IDE
References: <000701c3ebe6$ac5b35d0$c8de11cc@black> <20040205233934.GC10450@convergence.de>
In-Reply-To: <20040205233934.GC10450@convergence.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Stezenbach wrote:
> Mike Black wrote:
> 
>>I use a removable IDE chassis to allow me to mirror my primary drive for offsite storage.
>>I'd like to hotswap the IDE but can't seem to get the drive to allow DMA access after restarting it.
>>A reboot is necessary for DMA access.
>>I'm using idectl from hdparm-5.4 which generates the following hdparm commands:
>>/sbin/hdparm -U 1 /dev/hda
>>/sbin/hdparm -R 0x170 0 0 /dev/hda
> 
> 
> I haven't tried myself, but Alan Cox did:
> 
> Linux 2.4.22-rc2-ac3
>  o       Finish off the core IDE hotplug support         (me)
>          | If your hardware supports it you can now
>          | hdparm -b0 /dev/hdc  change drive hdparm -b1 /dev/hdc
> 
> Maybe that works better than -U/-R ?

I suspect that both might not be a bad thing, set the bus down and 
unregister, then set the bus up and register. Order may be important!

Let me know if you try this, I have been contemplating using a hotswap 
drive for data transfer.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
