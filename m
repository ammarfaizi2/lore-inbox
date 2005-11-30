Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbVK3EQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbVK3EQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 23:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbVK3EQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 23:16:29 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:54180 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750890AbVK3EQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 23:16:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qtg+sN80Mr5jUTaqvETYnP46P9Y/ata7KUbShVEtcDJz9DBPETXX6Nzv5yw1TDmj32qJMiZgB1M+x0af6hB5sAoxOsH0y/gf3gG+xQAHnWHBzYub9AtpfQjbh/lGrE8Vn516z5Hz1UoboFZeCnaljy+60DxWDgw9YhiXgm5MMTY=
Message-ID: <438D2792.9050105@gmail.com>
Date: Wed, 30 Nov 2005 13:16:18 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ethan Chen <thanatoz@ucla.edu>
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>,
       Linux-ide <linux-ide@vger.kernel.org>
Subject: Re: SIL_QUIRK_MOD15WRITE workaround problem on 2.6.14
References: <438BD351.60902@ucla.edu>
In-Reply-To: <438BD351.60902@ucla.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[CC'ing Jeff, Carlos & linux-ide]

Ethan Chen wrote:
> I've got a dual Opteron 242 machine here with 2x Seagate ST3200822AS 
> SATA drives attached to a Silicon Image SI3114 controller, and after 
> upgrading to 2.6.14 from 2.6.13, it seems the SIL_QUIRK_MOD15WRITE 
> workaround for the sata_sil driver isn't being applied anymore. This 
> caused me trouble in the past before my drive was added to the 
> blacklist, and this message that comes up when writing (~4GBfiles to 
> test) files, right before the computer locks up, is the same as before:
> kernel: ata1: command 0x35 timeout, stat 0xd8 host_stat 0x61
> In the dmesg, the 'Applying Seagate errata fix' message doesn't appear 
> anymore as well.
> Finally, without the fix, write speeds are much higher as well, before 
> it locks up.

Hello, Ethan.

Sometime ago, Silicon Image has confirmed that 3114's and 3512's are not 
affected by the m15w problem - only 3112's are affected.  So, a patch 
has made into the tree before 2.6.14 to apply the m15w quirk selectively.

Can you post 'lspci -nv' result?

-- 
tejun
