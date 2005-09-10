Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030541AbVIJHCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030541AbVIJHCa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 03:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030543AbVIJHCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 03:02:30 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:54467 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030541AbVIJHC3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 03:02:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=W7o3NlY3tqMlQKaYVbCeU3SM3C2QWS34KdP7VCUHgfPecL16p5nT41csIySMPLA8ptNgbC7zMo30i4fEtozsSsDNOl/psXmwYJhorsaZBvNgbJ07bgiqPdlewbz86jMPVjdfdx6JjZgnaRFil/emdGwM1GFhvlWthg2rl3vQywI=
Message-ID: <4322850B.4060801@gmail.com>
Date: Sat, 10 Sep 2005 09:02:35 +0200
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050823)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm2
References: <20050908053042.6e05882f.akpm@osdl.org>	<432072C5.8020200@gmail.com> <20050908123930.5a28f3ff.akpm@osdl.org>
In-Reply-To: <20050908123930.5a28f3ff.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

>There are changes to both sata_nv and to md in 2.6.13-mm2.  To isolate them
>
>it would be great of you could apply 
>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm2/broken-out/linus.patch
>
I applied and tested it with 2.6.13 vanilla kernel + linux.patch as suggested, but so far no problem as with 2.6.13-mm2.

I also played with the git-snapshots 2.6.13-git[1-9] no problem here. I think the problem is

somewhere else we have to pay attention, too. MD Raidlevels [0,1] failed to start with 2.6.13-mm2.

Raid0 config:

2x 20GB Partitiontype 0xFD "Linux Raid autodetect"

64k Chunksize, persistent superblock.

little output from mdadm

/dev/md2:

        Version : 00.90.02

  Creation Time : Sun Jun 26 19:14:45 2005

     Raid Level : raid0

     Array Size : 40001536 (38.15 GiB 40.96 GB)

   Raid Devices : 2

  Total Devices : 2

Preferred Minor : 2

    Persistence : Superblock is persistent

    Update Time : Sun Jun 26 19:14:45 2005

          State : clean

 Active Devices : 2

Working Devices : 2

 Failed Devices : 0

  Spare Devices : 0

     Chunk Size : 64K

           UUID : c53fa0d8:9d85875b:efb82dde:11c6617c

         Events : 0.1

    Number   Major   Minor   RaidDevice State

       0       8       23        0      active sync   /dev/sdb7

       1       8        6        1      active sync   /dev/sda6

    

Raid1 config.

2x 15GB Partitiontype 0xFD "Linux Raid autodetect"

        chunksize 128k.


I have no idea where I should look, to resolve this behavior.


>to 2.6.13 and see if the problem still happens.  That will separate out the
>md changes which are still in -mm.
>
>Thanks.
>
>  
>
As for all the time, I'm willing to test to glue the problem out.

Thanks

Best regards

--
Michael Thonke
