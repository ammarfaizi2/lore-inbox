Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262857AbVAQUBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262857AbVAQUBk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 15:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbVAQUBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 15:01:40 -0500
Received: from [195.23.16.24] ([195.23.16.24]:33764 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262857AbVAQUBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 15:01:25 -0500
Message-ID: <41EC1993.2030105@grupopie.com>
Date: Mon, 17 Jan 2005 20:01:23 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Park <opengeometry@yahoo.ca>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Thomas Zehetbauer <thomasz@hostmaster.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: usb-storage on SMP?
References: <1105982247.21895.26.camel@hostmaster.org> <200501171826.33496.rjw@sisk.pl> <20050117194615.GA2028@node1.opengeometry.net>
In-Reply-To: <20050117194615.GA2028@node1.opengeometry.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Park wrote:
> On Mon, Jan 17, 2005 at 06:26:33PM +0100, Rafael J. Wysocki wrote:
> 
>>On Monday, 17 of January 2005 18:17, Thomas Zehetbauer wrote:
>>
>>>Hi,
>>>
>>>can anyone confirm that writing to usb-storage devices is working on SMP
>>>systems?
>>
>>Generally, it is.  Recently, I've written some stuff to a USB pendrive (using
>>2.6.10-ac7 or -ac9).
> 
> 
> Same here with Abit VP6 dual-P3 and 2.6.10.  It shows up as /dev/sda,
> and I can do anything that I would do with normal harddisk.
> 
> But, I still can't boot from it. :/  I can now mount it as root
> filesystem, but I can't load the kernel from USB key drive.

huh?? Who's mounting the root filesystem, then :) ?

If you mean that you can't get the BIOS to load the kernel for you, and 
you're loading the kernel from a floppy or something, you should know 
that some BIOS are pretty selective about what they consider a valid 
boot partition.

I recommend that you use fdisk to set up one partition as FAT16 type 
(even if you use another filesystem later), and make the partition 
active. You might need to write a proper MBR on the pen also (IIRC LILO 
as an option to do this).

You might also need to pass a special "disk=/dev/sda bios=0x80" (or 
something like that) option in your lilo.conf file, but that depends how 
far in the boot process you're hanging.

-- 
Paulo Marques - www.grupopie.com

"A journey of a thousand miles begins with a single step."
Lao-tzu, The Way of Lao-tzu

