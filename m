Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316243AbSFJVFc>; Mon, 10 Jun 2002 17:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316250AbSFJVFb>; Mon, 10 Jun 2002 17:05:31 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:15273 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S316532AbSFJVEN>; Mon, 10 Jun 2002 17:04:13 -0400
Message-ID: <3D051326.1020107@oracle.com>
Date: Mon, 10 Jun 2002 22:59:18 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020606
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>
CC: Peter Osterlund <petero2@telia.com>, Tobias Diedrich <ranma@gmx.at>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <Pine.LNX.4.33.0206100817090.654-100000@geena.pdx.osdl.net>
Content-Type: multipart/mixed;
 boundary="------------070004020603050506000300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------070004020603050506000300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Patrick Mochel wrote:
> On 9 Jun 2002, Peter Osterlund wrote:
> 
> 
>>Tobias Diedrich <ranma@gmx.at> writes:
>>
>>
>>>Peter Osterlund wrote:
>>>
>>>>Alessandro Suardi <alessandro.suardi@oracle.com> writes:
>>>>
>>>>
>>>>>In 2.5.19 I got an oops on boot (kindly fixed by Peter's patch),
>>>>>  in 2.5.20 no oopsen but eth0 isn't seen anymore by the kernel:
>>>>
>>>>Same problem here. My network card isn't seen either by the kernel in
>>>>2.5.20. If it's still broken in 2.5.21, maybe I'll try to fix it.
>>>
>>>This oneliner fixes it for me, but I don't know if that's the right fix:
>>
>>Thanks, it fixes my problem too. (This patch is still needed in
>>2.5.21.) However, in 2.5.21 I get an oops at shutdown in
>>device_detach. This happens both with and without your patch:
> 
> 
> Sorry about the delay. Could you please try this patch and let me know if 
> it helps? It attempts to treat cardbus more like PCI, and let the PCI 
> helpers do the probing. 
> 
> Note that it's based on the assumption that there is a cardbus bridge for 
> each cardbus slot. This appears to be true on all systems I've seen, but 
> it may not hold for all systems. If other people are feeling adventurous, 
> please give this a try and let me know if it works. 
> 
> You can pull from bk://ldm.bkbits.net/linux-2.5-cardbus
> 
> Thanks,
> 
> 	-pat
> 
> ChangeSet@1.494, 2002-06-10 08:35:32-07:00, mochel@osdl.org
>   Treat cardbus more like PCI: let the PCI helpers do more WRT probing
> 
>  drivers/pci/hotplug.c    |    2 
>  drivers/pcmcia/cardbus.c |  114 ++++++++++++++++-------------------------------
>  2 files changed, 40 insertions, 76 deletions

[snipped patch]

Still no go, and the card functions are misdetected - cardmgr
  attempts to load memory_cs. Full dmesg and /var/log/messages
  for this boot in the attached .tar.gz file.


Thanks,


--alessandro

  "the hands that build / can also pull down
    even the hands of love"
                             (U2, "Exit")

--------------070004020603050506000300
Content-Type: application/x-gzip;
 name="bootmsgs.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="bootmsgs.tar.gz"

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
t3M7t3M7t3M7t3M7t5Pa/wMqa4sPAHgAAA==
--------------070004020603050506000300--

