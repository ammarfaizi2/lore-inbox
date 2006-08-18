Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWHRMnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWHRMnI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 08:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWHRMnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 08:43:08 -0400
Received: from mail.tmr.com ([64.65.253.246]:48026 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S932372AbWHRMnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 08:43:06 -0400
Message-ID: <44E5B672.1010407@tmr.com>
Date: Fri, 18 Aug 2006 08:45:38 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Seewer Philippe <philippe.seewer@bfh.ch>
CC: Jeff Garzik <jeff@garzik.org>, Gabor Gombas <gombasg@sztaki.hu>,
       Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: /dev/sd*
References: <1155144599.5729.226.camel@localhost.localdomain> <20060809212124.GC3691@stusta.de> <1155160903.5729.263.camel@localhost.localdomain> <20060809221857.GG3691@stusta.de> <20060810123643.GC25187@boogie.lpds.sztaki.hu> <44DB289A.4060503@garzik.org> <44E3DFD6.4010504@PicturesInMotion.net> <Pine.LNX.4.61.0608171000220.19847@yvahk01.tjqt.qr> <44E42900.1030905@PicturesInMotion.net> <Pine.LNX.4.61.0608171120260.4252@yvahk01.tjqt.qr> <44E56804.1080906@bfh.ch>
In-Reply-To: <44E56804.1080906@bfh.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seewer Philippe wrote:
> Jan Engelhardt wrote:
>>>> In the process, we can rename the then-"generic disk" (scsi ide whatever) 
>>>> back to "hd*" since that actually expands to Hard Disk.
>>>> (If I would have known a lot earlier about Linux I would have proposed 
>>>> "id*" for the IDE disks.)
>>>>
>>> Actually that does make more sense then using disk. So I guess we're
>>> back to square one. Personally I don't think its that big of a deal, all
>>> you have to do is change fstab and grub or lilo. My main concern is for
>>> the less advanced Linux users.
>> Less advanced users should use the upgrade tools their distribution 
>> provides.
> 
> And personally I think less advanced users will be very happy with
> /dev/disk (or /dev/hd). No more confusion wether to user /dev/hdx or
> /dev/sdx or whatever!
> 
But less clarity about which name goes with which device. I think it's 
desirable to have a way for the user, the non-guru user, to find out 
what meaningless name goes with which actual device. Currently finding 
out what's on a system involves /proc/ide/hd*/model and /proc/scsi/scsi 
to see what's attached and what names are being used.

For discussion I suggest /proc/ata/devices, a single flat file matching 
a name meaningful to open() with a vendor string and whatever other info 
is handy, like serial number and the like. If people are going to use 
ATA that allows them to generate their own tools using familiar methods 
like awk, sed, grep, perl, python or whatever. Having that information 
in an inobvious format will really slow adoption by triggering the "it's 
hard to use" or "I need to use all these new tools" responses.

And those responses are not limited to newbies, experienced users are 
aware of the ratio of learning curve to functionality as well.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
