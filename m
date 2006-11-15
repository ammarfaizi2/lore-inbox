Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030943AbWKOUB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030943AbWKOUB6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 15:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030948AbWKOUB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 15:01:57 -0500
Received: from smtpout08-04.prod.mesa1.secureserver.net ([64.202.165.12]:1509
	"HELO smtpout08-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1030943AbWKOUB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 15:01:56 -0500
Message-ID: <455B7233.5080000@seclark.us>
Date: Wed, 15 Nov 2006 15:01:55 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>  <20061114.190036.30187059.davem@davemloft.net>  <Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>  <20061114.192117.112621278.davem@davemloft.net>  <s5hbqn99f2v.wl%tiwai@suse.de>  <Pine.LNX.4.64.0611150814000.3349@woody.osdl.org> <1163607889.31358.132.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0611150829460.3349@woody.osdl.org> <455B6BB1.7030009@seclark.us> <455B6F20.6050503@garzik.org>
In-Reply-To: <455B6F20.6050503@garzik.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>Stephen Clark wrote:
>  
>
>>Also, I find it disturbing that we are forcing users to have know about 
>>all these
>>magic options that have to be put on the kernel boot line. My hard drive 
>>on my
>>new laptop would only run at 1.2mbs until I found out I had to use 
>>combined_mode=libata
>>and build a new ramdisk that included ata_piix.
>>    
>>
>
>That's what happens when two drivers want to drive the same hardware. 
>The "slow and safe" default is the only proven-stable option, with the 
>proven-stable PATA driver.  The other two options (drivers/ide for 
>PATA+SATA -> leads to SATA locksup) and (libata for PATA -> ok but 
>breaks existing configs, and less field time) are considered less safe.
>
>  
>
The problem with this approach is the average user will just think linux 
sucks - it is so
slow, they won't know how to investigate or trouble shoot the problem, 
and just go back to winblows.
I've got an ich7 chipset that supports sata and ide. My laptop has only 
ide devices so why
is there a conflict that has to be resolved by combined mode? Why can't 
the sata driver
be smart enough to know there are no sata devices for it to handle?

>Combined mode is ugly no matter how you look at it.  Just turn it off in 
>BIOS (or pressure system vendor for this ability if BIOS lacks it, e.g. 
>some Dell servers)
>
>And throw some annoyance at Intel for creating such a headache.
>
>	Jeff
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



