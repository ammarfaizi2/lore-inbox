Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbUCPAwg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbUCPAlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:41:50 -0500
Received: from alt.aurema.com ([203.217.18.57]:20637 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S262886AbUCPASJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:18:09 -0500
Message-ID: <405647A3.4030202@aurema.com>
Date: Tue, 16 Mar 2004 11:17:39 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grzegorz Kulewski <kangur@polcom.net>
CC: Marek Szuba <scriptkiddie@wp.pl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4, or what I still don't quite like about the new stable
 branch
References: <S263158AbUCMS0h/20040313182637Z+893@vger.kernel.org> <Pine.LNX.4.58.0403131932510.22707@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.58.0403131932510.22707@alpha.polcom.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Kulewski wrote:
>>4. Module autounloading. Is it actually possible? Will it be possible?
>>If not, why? The old method of periodically invoking "modprobe -ras" via
>>cron doesn't seem to accomplish anything and I really liked the idea of
>>keeping only the required modules in memory at any given moment without
>>having to log in as root to unload the unneeded ones - after all, if the
>>autoloader can only add them what's the point of not going the
>>monolithic way? The docs on the new approach towards modules are
>>virtually nonexistent in the kernel source package and while I suppose I
>>could simply write a script which would scan the list of
>>currently-loaded modules for the unused ones and remove them one by one,
>>but this approach feels terribly crude comparing with the elegance of
>>the old solution. I use module-init-tools-3.0, a serious improvement
>>over 0.9.15 if I may say so but, unless I'm thinking about it with
>>completely wrong base assumptions, still far from perfect.
> 
> 
> As far as I know, the new preffered way of handling modules, is to load 
> them when device is detected (hotplug and udev, at boot or later) 
> and (optionally) remove when device is removed, not as in older kernels, 
> when module was added or removed depending on its use. This way (as 
> opposed to monolithic kernel) you can have "generic" kernel by placing 
> everything in modules. And what is the point in unloading not currently 
> needed modules?

It enables you to update a module (e.g. to fix a bug) without having to 
do a reboot.  I think that people trying to use Linux for useful work 
would find this useful.  So unloadable modules is certainly a 
functionality worth aiming for.

> They should not use much resources when not needed...
> And if you want to put your system to sleep, you must put to sleep all 
> devices (in the right order) *including* these not currently used but 
> present in the system. If you will not do this, you can probably get big 
> crash. So you need loaded module, that knows how to put device to sleep.
> 
> 
> Grzegorz Kulewski
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com


