Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276470AbRJKObJ>; Thu, 11 Oct 2001 10:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276451AbRJKOa7>; Thu, 11 Oct 2001 10:30:59 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:31386 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S276457AbRJKOao>; Thu, 11 Oct 2001 10:30:44 -0400
Date: Thu, 11 Oct 2001 16:31:05 +0200
From: Cliff Albert <cliff@oisec.net>
To: "Oleg A. Yurlov" <kris@spylog.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.11aa1 and AIC7XXX
Message-ID: <20011011163105.A18508@oisec.net>
Mail-Followup-To: "Oleg A. Yurlov" <kris@spylog.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <13522687985.20011011173954@spylog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13522687985.20011011173954@spylog.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2001 at 05:39:54PM +0400, Oleg A. Yurlov wrote:

> Oct 10 20:35:31 samson kernel: (scsi0:A:2:0): Locking max tag count at 128
> Oct 10 21:06:31 samson kernel: (scsi1:A:0:0): Locking max tag count at 64                                                           
> Oct 11 05:33:09 samson kernel: (scsi0:A:3:0): Locking max tag count at 128       
> 
>         Hardware   -  SMP 2 CPU, 1GB RAM, M/B Intel L440GX, 5 SCSI HDD, Software
> RAID5 (3 disks) and RAID1.
> 
>         I found in dmesg:
> 
>  *** Possibly defective BIOS detected (irqtable)
>  *** Many BIOSes matching this signature have incorrect IRQ routing tables.
>  *** If you see IRQ problems, in paticular SCSI resets and hangs at boot
>  *** contact your vendor and ask about updates.
>  *** Building an SMP kernel may evade the bug some of the time.
> Starting kswapd
> 
>         It's  normal or not ? What I can do to fix problem with locking max tag
> count ?

Looks normal, it's that the new aic7xxx driver utilizes a maximum tag queue depth of 255 tags. Your devices are supporting only a maximum tag count of 128, 64 and 128 so it's perfectly normal. Also these 'error' messages should only appear once and no more (until a reboot)

-- 
Cliff Albert		| RIPE:	     CA3348-RIPE | www.oisec.net
cliff@oisec.net		| 6BONE:     CA2-6BONE	 | icq 18461740
