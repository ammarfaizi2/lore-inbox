Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266009AbUGZVpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUGZVpY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 17:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266075AbUGZVpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 17:45:22 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:37542 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266009AbUGZVpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 17:45:03 -0400
Message-ID: <41057B58.1040808@comcast.net>
Date: Mon, 26 Jul 2004 17:44:56 -0400
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Jim Gifford <maillist@jg555.com>, "Adam J. Richter" <adam@yggdrasil.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Future devfs plans
References: <200407261445.i6QEjAS04697@freya.yggdrasil.com> <057601c472a3$9df39ac0$d100a8c0@W2RZ8L4S02> <41044DA6.5080501@comcast.net> <20040726180901.GG11817@fs.tum.de>
In-Reply-To: <20040726180901.GG11817@fs.tum.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>On Sun, Jul 25, 2004 at 08:17:42PM -0400, Ed Sweetman wrote:
>  
>
>>...
>>On 
>>top of that, MAKEDEV as distributed at least by debian, doesn't create 
>>alsa devices and there is no script in the kernel source tree that i've 
>>found that allows the device creation.  One would have to go download 
>>the alsa-driver package from the alsa-project website and use the 
>>snddevices.sh script.  Since alsa-driver is integrated with the kernel 
>>now, this device creation script should be included in the kernel source 
>>or if that's not the place for such a file, we'll have to get on 
>>debian's butt to have MAKEDEV updated to actually support it.
>>    
>>
>
>
>
>  apt-get install alsa-base
>
>
>Check
>
>  /var/lib/dpkg/info/alsa-base.postinst
>
>and (surprise, surprise!), you'll note the snddevices script is executed 
>when installing the alsa-base package.
>
>
>cu
>Adrian
>
>  
>
And someone who compiles the kernel for themselves and never needs the 
alsa-base deb wouldn't have any ability to create the devices.  MAKEDEV 
is the proper place to create devices, not a separate snddevices 
script.  This is still a debian bug.
