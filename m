Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129229AbQKFLvq>; Mon, 6 Nov 2000 06:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129297AbQKFLvg>; Mon, 6 Nov 2000 06:51:36 -0500
Received: from jeetkunedo.penguinfarm.com ([12.32.79.65]:38592 "HELO
	jeetkunedo.penguinfarm.com") by vger.kernel.org with SMTP
	id <S129229AbQKFLvV>; Mon, 6 Nov 2000 06:51:21 -0500
From: Jason Straight <junfan@penguinfarm.com>
Date: Mon, 6 Nov 2000 06:51:24 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
In-Reply-To: <3A05CC59.7B0566C7@netidea.com>
In-Reply-To: <3A05CC59.7B0566C7@netidea.com>
Subject: Re: Kernel 2.4.0test10 crash (RAID+SMP)
MIME-Version: 1.0
Message-Id: <00110606512400.07791@jeetkunedo.penguinfarm.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It may be a filesystem problem, I had a problem like this with a 200GB raid 0 
array using reiserfs, it went down 3 times in 2 days. I switched to ext2 on 
md0 and everything has been fine now for weeks.




On Sunday 05 November 2000 16:08, ryan wrote:

> > Hi,
>
> I tried 2.4.0test10, but I get a kernel oops quite often.  I have
> configured my kernel for raid and smp ... autodetected raid, in the
> kernel everything, so no raid modules necessary.  But when I go to boot,
> it starts to reconstruct the raid array and fsck the /dev/md0 and
> eventually it just crashes on me.  Kernel oops. A message like:
>
> "Detected LOCKUP on CPU0"
> or sometimes its CPU1...
>
> If I dont use raid its cool, if I remove smp its also cool.  So the
> particular combination of raid+smp seems to be the problem.
>
> My hardware is :
> Asus P2B-D, 2 PII-400
> 128 mb ram in 2 * 64 dimms (pc100)
> Matrox G400 singlehead.
> Enqsonique ENS1371
> Realtek 8029 Ethernet card (ne2k-pci )
>
>
> I have included my config that causes this problem.
>
> Incidently mga DRI doesnt work either in either SMP or non-SMP
> kernels... it just locks up the console, the system is still running.
> maybe I'm missing something?
>
> My software resembes Debian woody,
> gcc --version:
> 2.95.2
>
>
> Hope this helps.
>
> -ryan
> (PS: my raid array is from a 2.2.16 patched with the latest raid patches
> for that kernel... debian raidtools2 uses this patch, so its the "latest
> one".  I'm not sure how relevant this is)

----------------------------------------
Content-Type: text/plain; charset="us-ascii"; name="ryan.config"
Content-Transfer-Encoding: 7bit
Content-Description: 
----------------------------------------

-- 
Jason Straight - NMO.net Senior Network Tech
Penguinfarm.com - Personal Page
http://www.penguinfarm.com/
ICQ 1796276
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
