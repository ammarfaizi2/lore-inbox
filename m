Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261715AbSJCQiW>; Thu, 3 Oct 2002 12:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261727AbSJCQiV>; Thu, 3 Oct 2002 12:38:21 -0400
Received: from vger.timpanogas.org ([216.250.140.154]:38617 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S261715AbSJCQiU>; Thu, 3 Oct 2002 12:38:20 -0400
Date: Thu, 3 Oct 2002 10:36:24 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Ken Savage <kens1835@shaw.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3ware Escalade 7500 init problems on 2.4.19
Message-ID: <20021003103624.B22409@vger.timpanogas.org>
References: <200210020859.54621.kens1835@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210020859.54621.kens1835@shaw.ca>; from kens1835@shaw.ca on Wed, Oct 02, 2002 at 08:59:54AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



You need to set the system to IO-APIC mode if you are running
a UP system.  I have seen this problem when the unit is mapped
to the 8259 PIC.  You will note the IRQ setting was 11, not 20X,
etc.  

Jeff

On Wed, Oct 02, 2002 at 08:59:54AM -0700, Ken Savage wrote:
> Hi there..
> 
> Just received a 3ware 7500-8 RAID card and am trying to get it installed
> on a dual Athlon system with 4GB of RAM, running 2.4.19.
> 
> SCSI support and SCSI disk support are enabled.
> Low level support for 3w-xxxx is enabled.
> The RAID has been flashed to the latest hardware revision.
> 
> Kernel loads up fine, and gets to initializing the card, where it waits
> for a while as it attempts to init and reinit, etc, the card.  Ultimately,
> it simply resets the card and takes the card offline.  'dmesg' reports
> the following in the kernel log:
> 
> scsi0 : Found a 3ware Storage Controller at 0xc400, IRQ: 11, P-chip: 1.3
> scsi0 : 3ware Storage Controller
> 3w-xxxx: scsi0: Unit #0: Command (0xf4d53800) timed out, resetting card.
> 3w-xxxx: scsi0: Unit #0: Command (0xf4d53800) timed out, resetting card.
> 3w-xxxx: scsi0: Reset succeeded.
> 3w-xxxx: scsi0: Unit #0: Command (0xf4d53800) timed out, resetting card.
> scsi: device set offline - not ready or command retry failed after host reset: 
> host 0 channel 0 id 0 lun 0
> 
> 
> Any ideas what the problem might be?
> 
> Ken Savage  kens1835@shaw.ca
> AllResearch.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
