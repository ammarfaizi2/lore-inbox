Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030362AbVIJDSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbVIJDSL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 23:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbVIJDSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 23:18:11 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:7385 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932601AbVIJDSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 23:18:10 -0400
Message-ID: <4322506A.1010303@eyal.emu.id.au>
Date: Sat, 10 Sep 2005 13:18:02 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nuno Silva <nuno.silva@vgertech.com>
CC: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RAID resync speed
References: <432240E9.9010400@eyal.emu.id.au> <43224ABB.3030002@vgertech.com>
In-Reply-To: <43224ABB.3030002@vgertech.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nuno Silva wrote:
>
> Hi,
>
> Eyal Lebedinsky wrote:
>
>> I noticed that my 3-disk RAID was syncing at about 40MB/s, now that I
>> added a fourth disk it goes at only 20+MB/s. This is on an idle machine.
>
> 3*40=120
>
> 4*20=80

What does this mean? The raid is syncing at 20MB/s, not each disk, so I do
not see what the multiplication is about.

>> Individually, each disk measures 60+MB/s with hdparm.
>
> And concurrent hdparms? Or some dd's concurrently?

I do not see this as relevant, but four concurrent hdparms (each to a
different disk) give about 30MB/s per disk. I expect the controller
to talk to the four disks at their full speed so concurrency should
not be the issue.

>> kernel: 2.6.13 on ia32
>> Controller: Promise SATAII150 TX4
>> Disks: WD 320GB SATA
>>
>> Q: Is this the way the raid code works? The way the disk-io is
>> managed? Or
>> could it be due to the SATA controller?
>
> You can isolate the performance drop with some dd's. Maybe this card is
> in a pci32/33mhz and you're hitting the pci bus' limits? (120~130MB/sec).

'hdparm -T' gives about 1250 MB/sec so this is not the limiting
factor.

> Regards,
> Nuno Silva

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
