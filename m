Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132101AbRAFPkR>; Sat, 6 Jan 2001 10:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132092AbRAFPj5>; Sat, 6 Jan 2001 10:39:57 -0500
Received: from 33.136.8.rrcentralflorida.cfl.rr.com ([65.33.136.8]:56829 "EHLO
	sasami.kuroyi.net") by vger.kernel.org with ESMTP
	id <S132076AbRAFPjs>; Sat, 6 Jan 2001 10:39:48 -0500
Date: Sat, 6 Jan 2001 10:39:41 -0500
From: Rick Haines <rick@kuroyi.net>
To: Adrian Chung <adrian@enfusion-group.com>
Cc: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>
Subject: Re: Promise Ultra66 DMA problems.
Message-ID: <20010106103941.A3383@sasami.kuroyi.net>
In-Reply-To: <20010105170838.A1674@rogue.enfusion-group.com> <20010106000507.A2278@rogue.enfusion-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010106000507.A2278@rogue.enfusion-group.com>; from adrian@enfusion-group.com on Sat, Jan 06, 2001 at 12:05:07AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2001 at 12:05:07AM -0500, Adrian Chung wrote:
> On Fri, Jan 05, 2001 at 05:08:38PM -0500, Adrian Chung wrote:
> > hde: Maxtor 91024U3, ATA DISK drive
> > hdf: Maxtor 94098U8, ATA DISK drive
> > hdg: QUANTUM FIREBALLP LM15, ATA DISK drive
> > hdh: QUANTUM FIREBALLP LM30, ATA DISK drive
> 
> I initially added only the two quantum drives to the pdc_quirk_list,
> and that had no effect, the machine still hung on boot up at the same
> place.  After this, I added the other two Maxtor's as well, and with
> all four drives in the pdc_quirk_list, the system booted up fine.
> 
> Should I narrow this down further?  Will it be detrimental in any way
> to have all four drives listed in the quirks table if they needn't be?

I have
hde: Maxtor 54098U8, ATA DISK drive
on my promise controller.  Works fine but I don't stress it too much.
I also don't boot off it.
 
cat /proc/ide/pdc:

                                PDC20262 Chipset.
------------------------------- General Status ---------------------------------
Burst Mode                           : enabled
Host Mode                            : Normal
Bus Clocking                         : 33 PCI Internal
IO pad select                        : 4 mA
Status Polling Period                : 1
Interrupt Check Status Polling Delay : 9
--------------- Primary Channel ---------------- Secondary Channel -------------
                enabled                          enabled 
66 Clocking     enabled                          disabled
           Mode PCI                         Mode PCI   
                FIFO Empty                       FIFO Empty  
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    yes              yes             yes               yes
DMA Mode:       UDMA 4           NOTSET          NOTSET            NOTSET
PIO Mode:       PIO 4            NOTSET           NOTSET            NOTSET

-- 
Rick (rick@kuroyi.net)
http://www.kuroyi.net

I think the slogan of the fansubbers puts
it best: "Cheaper than crack, and lots more fun."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
