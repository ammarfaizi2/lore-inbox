Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264648AbUGZARr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264648AbUGZARr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 20:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264647AbUGZARr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 20:17:47 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:62861 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S264648AbUGZARp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 20:17:45 -0400
Message-ID: <41044DA6.5080501@comcast.net>
Date: Sun, 25 Jul 2004 20:17:42 -0400
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jim Gifford <maillist@jg555.com>
CC: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: Future devfs plans
References: <200407261445.i6QEjAS04697@freya.yggdrasil.com> <057601c472a3$9df39ac0$d100a8c0@W2RZ8L4S02>
In-Reply-To: <057601c472a3$9df39ac0$d100a8c0@W2RZ8L4S02>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Gifford wrote:

>----- Original Message ----- 
>From: "Adam J. Richter" <adam@yggdrasil.com>
>To: <linux-kernel@vger.kernel.org>
>Sent: Monday, July 26, 2004 7:45 AM
>Subject: Future devfs plans
>
>
>  
>
>>Do not delete devfs.
>>
>>devfs allows drivers to be loaded when user level programs
>>need them,
>>-
>>    
>>
>So will a proper modprobe.conf file. You don't need devfs for autoloading of
>modules.
>
>  
>


On a different note though, some systems have been made to rely soley on 
devfs, meaning there is no static /dev fs underneath it.  Currently 
there is no documentation in the kernel source for going about migrating 
from a devfs only situation to a static or udev controlled /dev fs.  On 
top of that, MAKEDEV as distributed at least by debian, doesn't create 
alsa devices and there is no script in the kernel source tree that i've 
found that allows the device creation.  One would have to go download 
the alsa-driver package from the alsa-project website and use the 
snddevices.sh script.  Since alsa-driver is integrated with the kernel 
now, this device creation script should be included in the kernel source 
or if that's not the place for such a file, we'll have to get on 
debian's butt to have MAKEDEV updated to actually support it.

