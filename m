Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965328AbVKBWkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965328AbVKBWkG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965330AbVKBWkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:40:06 -0500
Received: from mail.avalus.com ([195.82.114.197]:34521 "EHLO shed.alex.org.uk")
	by vger.kernel.org with ESMTP id S965328AbVKBWkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:40:04 -0500
Date: Wed, 02 Nov 2005 22:39:52 +0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: "Jeff V. Merkey" <jmerkey@utah-nac.org>,
       Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Florian Weimer <fw@deneb.enyo.de>,
       Lawrence Walton <lawrence@the-penguin.otak.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: 3ware 9550SX problems - mke2fs incredibly slow writing last
 third of inode tables
Message-ID: <2EA1793C77A53E11C0C68B58@[192.168.100.25]>
In-Reply-To: <4367F226.4040302@utah-nac.org>
References: <BEDEA151E8B1D6CEDD295442@[192.168.100.25]>
 	<87oe54cza8.fsf@mid.deneb.enyo.de>
 	<20051101170413.GA11640@the-penguin.otak.com>
 <87wtjs8f54.fsf@mid.deneb.enyo.de>
 <B4CA35A2CFBAF97FCE2856B0@[192.168.100.25]> <4367F226.4040302@utah-nac.org>
X-Mailer: Mulberry/4.0.4 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On 01 November 2005 15:54 -0700 "Jeff V. Merkey" <jmerkey@utah-nac.org> 
wrote:

> I see this problem if you have the array configured for RAID 5 and you
> have not pushed the F8 key during array config after setting up
> the array. Try rebooting, setting the Raid 5 for INIT (Press F8) and it
> goes away, but the whole array will reinit itself. There seems to be
> some sort of problem in their RAID 5 logic and you can setup a RAID 5
> stripe set, but init doesn't finish or gets in a wierd state during
> reboot. It seems confined to 9500 series controllers, but I have also
> seen this behavior on the 8000 series drivers as well. I don't know
> if you are using RAID 5 , but I have seen this problem on RAID 5 configs
> only.

I don't know when it's meant to reinit itself, but F8 does exit here,
and an immediate exit to boot up. The manual describes some RAID configs
need initialization in BIOS, but some (allegedly) initialize as the
OS loads. Then it contradicts itself and says RAID-5 is ready for
use w/o initialization. Whatever, it does nothing on boot, until a
mkfs, and then the world grinds very slowly.

--
Alex Bligh
