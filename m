Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWB1OhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWB1OhQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 09:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbWB1OhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 09:37:16 -0500
Received: from rtr.ca ([64.26.128.89]:33936 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750757AbWB1OhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 09:37:14 -0500
Message-ID: <44046013.7070503@rtr.ca>
Date: Tue, 28 Feb 2006 09:37:07 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: David Greaves <david@dgreaves.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com>
In-Reply-To: <44042863.2050703@dgreaves.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Greaves wrote:
>
> /dev/sda:
..
> 0040 3fff c837 0010 0000 0000 003f 0000
> 0000 0000 4234 3033 3852 5248 2020 2020
> 2020 2020 2020 2020 0003 4000 0004 4241
> 4e43 3139 3830 4d61 7874 6f72 2036 4232
> 3030 4d30 2020 2020 2020 2020 2020 2020
> 2020 2020 2020 2020 2020 2020 2020 8010
> 0000 2f00 4000 0200 0000 0007 3fff 0010
> 003f fc10 00fb 0100 ffff 0fff 0000 0007
> 0003 0078 0078 0078 0078 0000 0000 0000
> 0000 0000 0000 0000 0002 0000 0000 0000
> 00fe 001e 7869 7d09 4043 7869 3c01 4043
> 203f 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 f1b0 1749 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0113 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 0000
> 0000 0000 0000 0000 0000 0000 0000 d3a5
..
hdparm-6.4 says:

         Model Number:       Maxtor 6B200M0
         Serial Number:      B4038RRH
         Firmware Revision:  BANC1980

Commands/features:
         Enabled Supported:
            *    NOP cmd
            *    READ BUFFER cmd
            *    WRITE BUFFER cmd
            *    Look-ahead
            *    Write cache
            *    Power Management feature set
            *    SMART feature set
            *    FLUSH_CACHE_EXT
            *    Mandatory FLUSH_CACHE
            *    Device Configuration Overlay feature set
            *    48-bit Address feature set
                 SET_MAX security extension
                 Advanced Power Management feature set
            *    DOWNLOAD_MICROCODE
            *    WRITE_{DMA|MULTIPLE}_FUA_EXT
            *    SMART self-test
            *    SMART error logging

So, yes, the drive is either lying about "* WRITE_{DMA|MULTIPLE}_FUA_EXT",
or it didn't like the parameters it was given, or the SATA/IDE controller
chip didn't like the command.

Cheers
