Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030402AbWBHBX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030402AbWBHBX0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 20:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030404AbWBHBX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 20:23:26 -0500
Received: from penta.pentaserver.com ([66.45.247.194]:37281 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1030402AbWBHBXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 20:23:25 -0500
Message-ID: <43E94492.3020705@gmail.com>
Date: Wed, 08 Feb 2006 05:08:34 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Edgar Toernig <froese@gmx.de>
CC: mchehab@infradead.org, linux-kernel@vger.kernel.org,
       linux-dvb-maintainer@linuxtv.org, Manu Abraham <manu@linuxtv.org>
Subject: Re: [PATCH 04/16] Fix [Bug 5895] to correct snd_87x autodetect
References: <20060207153248.PS50860900000@infradead.org>	<20060207153330.PS44220900004@infradead.org> <20060208012434.10d927c4.froese@gmx.de>
In-Reply-To: <20060208012434.10d927c4.froese@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - gmail.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edgar Toernig wrote:
> mchehab@infradead.org wrote:
>   
>> --- a/drivers/media/dvb/bt8xx/bt878.c
>> +++ b/drivers/media/dvb/bt8xx/bt878.c
>> @@ -381,6 +381,23 @@ bt878_device_control(struct bt878 *bt, u
>>  
>>  EXPORT_SYMBOL(bt878_device_control);
>>  
>> +
>> +struct cards card_list[] __devinitdata = {
>> +
>> +	{ 0x01010071, BTTV_BOARD_NEBULA_DIGITV,	"Nebula Electronics DigiTV" },
>> +	{ 0x07611461, BTTV_BOARD_AVDVBT_761,	"AverMedia AverTV DVB-T 761" },
>> [...]
>>     
>
> I'm not very familiar with the pci configuration logic but
> what's the point of this list and the BTTV_BOARD_xxx defines?
> The defines are never used and the list is only used to let
> the probe routine fail when the device is not in the list.
>   

Yes, that's the idea. The naming is for identification in the failed case.

> Anyway, the bttv driver already has this information in his card
> list (field has_dvb).  As long as the bt878 isn't stand alone
> and requires the bttv driver wouldn't it be better to query its
> table?
>
>   

This is only the interim fix for bug [5895] prior to the merge, as was 
discussed on the linux-dvb and video4linux mailing lists.
Thread: [linux-dvb] Re: [Fwd: [Bug 5895] With DVB drivers enabled 
snd_87x    (ALSA)    don't detect Broooktree audio]

> Even if this table is kept, it should be static
>   

Ack'd.


Thanks,
Manu

