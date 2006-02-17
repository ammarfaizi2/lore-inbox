Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751856AbWBQWVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbWBQWVi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 17:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbWBQWVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 17:21:37 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:59759 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751856AbWBQWVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 17:21:36 -0500
Message-ID: <43F64C2F.7040200@cfl.rr.com>
Date: Fri, 17 Feb 2006 17:20:31 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: C/H/S from user space
References: <Pine.LNX.4.61.0602171157140.8950@chaos.analogic.com> <43F617FA.2030609@wolfmountaingroup.com> <Pine.LNX.4.61.0602171452520.4290@chaos.analogic.com> <43F63A59.6090401@cfl.rr.com> <Pine.LNX.4.61.0602171609480.4549@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0602171609480.4549@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Feb 2006 22:22:59.0852 (UTC) FILETIME=[B5A924C0:01C63410]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14274.000
X-TM-AS-Result: No--11.790000-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> Who is YOU??? I would certainly be requesting the right sectors
> if I (or anybody else who knows what they are doing), wrote
> the boot code. The boot loader knows about OFFSETS into the
> device where it's going to get its data, which eventually
> becomes a whole operating system. It doesn't give a *uck about
> anything else. There is a table of OFFSETS, obtained from
> the file-system, of the correct pieces of files (since there
> will not be a file-system until the machine is booted). This
> table of offsets needs to be read somewhere in the first 63
> sectors (32256 bytes). These offsets contain the junk to
> be loaded into memory.
> 

We weren't talking about a boot loader you would write, or lilo even, we 
were talking about windows's boot loader, which, to the best of my 
knowledge, directly passes the CHS address of the starting sector of the 
partition stored in the MBR to int 13.  That CHS address is calculated 
by fdisk based on the geometry it believes the disk has and is written 
to the MBR when you partition the disk.  The last time I checked a dos 
MBR, the boot code there didn't recompute the CHS address at runtime 
based on the LBA and current geometry according to the bios, so it has 
to be written correctly in the first place by fdisk, which requires that 
fdisk know the bios geometry.

> The boot-code, the code that executes in the 16-bit environment,
> converts those offsets (after getting data from the DPB) into
> the respective junk to put into the registers as I explained
> over and over and over again.

Maybe I'm just dense, but that's not what I heard you explaining.  Is it 
your position then, that the MS DOS/WIN MBR does actually recompute the 
CHS address at boot time based on the geometry the bios currently 
reports, and the LBA in the partition table, rather than use the CHS 
address stored in the partition table and precomputed by fdisk?

If that is the case, then fdisk can use whatever geometry it chooses and 
everything will be fine, so why does the kernel have to carry around 
some geometry instead of just letting fdisk make one up when it is run?

> 
> You refuse to learn. Please go away.
> 

That is uncalled for.  I don't understand why you have shown a bad 
attitude this whole time.

