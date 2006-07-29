Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422689AbWG2IAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422689AbWG2IAU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 04:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbWG2IAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 04:00:20 -0400
Received: from server077.de-nserver.de ([62.27.12.245]:49292 "EHLO
	server077.de-nserver.de") by vger.kernel.org with ESMTP
	id S932644AbWG2IAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 04:00:18 -0400
X-User-Auth: Auth by hostmaster@profihost.com through 84.133.217.26
Message-ID: <44CB158B.1050209@profihost.com>
Date: Sat, 29 Jul 2006 10:00:11 +0200
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
References: <44C8A5F1.7060604@profihost.com> <Pine.LNX.4.61.0607281909080.4972@yvahk01.tjqt.qr> <20060729075054.B2222647@wobbly.melbourne.sgi.com> <Pine.LNX.4.61.0607290953480.20234@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0607290953480.20234@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This only happens, if your partition is the root partition of the whole 
system and it is mounted read only on system start up. The pre barrier 
check for normal mount works without any problems.

Stefan

Jan Engelhardt schrieb:
>>>>The crash only occurs if you use quota and IDE without barrier support.
>>>
>>>I don't quite get this. I do use quota, and have barriers turned 
>>>off (either explicitly or because the drive does not support it),
>>>but yet no error message like you posted. Do I just have luck?
>>
>>Heh, no - its more likely you just haven't needed to do a quotacheck
>>on a filesystem thats initially mounted readonly (like root often is).
> 
> 
> Well I "sometimes" do that, i.e. intentionally turning off quota on the 
> running system, to force a recheck on boot. The mount options essentially
> are /bin/mount /dev/hda2 / -o ro,usrquota,grpquota and then /bin/mount / -o 
> remount,rw
> No breakage so far, which is why I wondered. Is it limited to a specific 
> kernel version?
> 
> 
>>I'm guessing you had quota enabled from earlier barrier-unaware kernels
>>and quotacheck only needs to be run during that initial mount.
> 
> 
> 
> Jan Engelhardt
