Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWBMPtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWBMPtw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 10:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWBMPtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 10:49:51 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:4626 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1750745AbWBMPtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 10:49:50 -0500
Message-ID: <43F0AA61.1000607@cfl.rr.com>
Date: Mon, 13 Feb 2006 10:48:49 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: iSteve <isteve@rulez.cz>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Peter Osterlund <petero2@telia.com>
Subject: Re: Packet writing issue on 2.6.15.1
References: <20060211103520.455746f6@silver> <m3r76a875w.fsf@telia.com> <20060211124818.063074cc@silver> <m3bqxd999u.fsf@telia.com> <20060211170813.3fb47a03@silver> <43EE446C.8010402@cfl.rr.com> <20060211211440.3b9a4bf9@silver> <43EE8B20.7000602@cfl.rr.com> <2006021 <20060213160024.5e01fa46@silver>
In-Reply-To: <20060213160024.5e01fa46@silver>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Feb 2006 15:50:37.0603 (UTC) FILETIME=[3BBC0730:01C630B5]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14265.000
X-TM-AS-Result: No--7.000000-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

iSteve wrote:
> I tried that. Mostly, writing failed. At cdrwtool's end, it looked like this:
> using device /dev/cdrw
> fixed packets
> setting speed to 10
> write file /root/udftest.img
> 4690KB internal buffer
> setting write speed to 10x
> writing at lba = 0, blocks = 32
> wait_cmd: Input/output error
> Command failed: 2a 00 00 00 00 00 00 00 20 00 00 00 - sense 05.24.00
>
> At kernel's end:
> cdrom: This disc doesn't have any tracks I recognize!
>
> Once I, somehow, managed to write it. However, writing ISO9660 (yes, I know
> that iso9660 doesn't support read/write; I use it for test though and I need
> it working), attempt to read it returned this:
>
> attempt to access beyond end of device
> hdc: rw=0, want=68, limit=4
> isofs_fill_super: bread failed, dev=hdc, iso_blknum=16, block=16
>   

The media must be formatted first before you can write to it.  It looks 
like you just tried to write to an unformatted disc.  Use cdrwtool -q 
first to format it, then cdrwtool -f foo.img to write out your image. 


