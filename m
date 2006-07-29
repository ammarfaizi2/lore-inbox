Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422700AbWG2IcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422700AbWG2IcM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 04:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422702AbWG2IcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 04:32:12 -0400
Received: from server077.de-nserver.de ([62.27.12.245]:22754 "EHLO
	server077.de-nserver.de") by vger.kernel.org with ESMTP
	id S1422700AbWG2IcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 04:32:11 -0400
X-User-Auth: Auth by hostmaster@profihost.com through 84.133.217.26
Message-ID: <44CB1D07.8010104@profihost.com>
Date: Sat, 29 Jul 2006 10:32:07 +0200
From: ProfiHost - Stefan Priebe <s.priebe@profihost.com>
Organization: ProfiHost
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Nathan Scott <nathans@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: XFS / Quota Bug in  2.6.17.x and 2.6.18x
References: <44C8A5F1.7060604@profihost.com> <Pine.LNX.4.61.0607281909080.4972@yvahk01.tjqt.qr> <20060729075054.B2222647@wobbly.melbourne.sgi.com> <Pine.LNX.4.61.0607290953480.20234@yvahk01.tjqt.qr> <44CB158B.1050209@profihost.com> <Pine.LNX.4.61.0607291001370.20234@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0607291001370.20234@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

 >>The pre barrier check for normal mount works without any problems.
 > Dang, I forgot that hda is a little older and does not support
 > barriers. /me slaps himself.
That matches for me too. My drives are also too old to support barriers. 
It occours on about 35 servers - so not all filesystems could be damaged.

So please recheck the following:

1.) You need a Kernel, where barriers are on by default:
so something like: 2.6.16.2x or 2.6.17.x
I'm not shure of the minimal version for the 2.6.16.x Kernel tree.

2.) that hda2 is / on your system

3.) you boot your system with kernel option rootflags=quota

4.) do not use mount, to deactivate quota - use quotaoff / command

5.) then reboot your system...


Stefan

Jan Engelhardt schrieb:
>>This only happens, if your partition is the root partition of the whole system
>>
> 
> It is..
> 
> 
>>and it is mounted read only on system start up.
>>
> 
> It is...
> 
> 
>>The pre barrier check for normal mount works without any problems.
> Dang, I forgot that hda is a little older and does not support barriers. 
> /me slaps himself.
> 
> 
> 
> Jan Engelhardt
