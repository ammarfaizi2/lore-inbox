Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292836AbSB0RtL>; Wed, 27 Feb 2002 12:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292837AbSB0RtA>; Wed, 27 Feb 2002 12:49:00 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:27127 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S292836AbSB0Rsp>;
	Wed, 27 Feb 2002 12:48:45 -0500
Date: Wed, 27 Feb 2002 10:48:25 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org, Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: 3Ware Hard Bus Hang 2.4.18 > 220 MB/S
Message-ID: <20020227104825.P12832@lynx.adilger.int>
Mail-Followup-To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
	linux-kernel@vger.kernel.org,
	Daniel Phillips <phillips@bonn-fries.net>
In-Reply-To: <20020227102545.B31524@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020227102545.B31524@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Wed, Feb 27, 2002 at 10:25:45AM -0700
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 27, 2002  10:25 -0700, Jeff V. Merkey wrote:
> Running 4 3Ware 7810 Adapters with the updated 48 bit LBA firmware
> for the 78110, and attached to 8 Maxtor 160 GB hard disks on each card
> (32 drives total) striping Raid 0m across 5.6 terabytes of disk, I am
> seeing about 216-224 MB/S total throughput on writes to local 
> arrays on 2.4.18.  

Have you done any kind of variations on this configuration to see when
or where the maximum throughput happens?  Daniel and I were speculating
about where the 3ware limits are.  Specs say 100MB/s per adapter (for
both 6000 and 7000 series), you would probably hit max bandwidth with
2 adapters.  The drives themselves are not a limiting factor, unless
you are down to striping across only 2 drives instead of all 8.  I take
it you are using the hardware RAID instead of software MD RAID?

> The system is also running an Intel Gigabit Ethernet Card at 
> 116-122 MB/S with full network traffic and writing this traffic to 
> the 3Ware arrays.  All this hardware is running on a Serverworks 
> HE chipset with a SuperMicro motherboard and dual 933 Mhz PIII
> processors.

Does this board have multiple PCI busses?  Is the GigE card on a
different bus than the 3ware cards?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

