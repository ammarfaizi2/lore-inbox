Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751677AbVLFO7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbVLFO7F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 09:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbVLFO7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 09:59:05 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:65426 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751677AbVLFO7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 09:59:04 -0500
Message-ID: <4395A72E.6030006@tmr.com>
Date: Tue, 06 Dec 2005 09:58:54 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203152339.GK31395@stusta.de> <20051203225020.GF25722@merlin.emma.line.org> <20051204002043.GA1879@kroah.com> <200512040446.32450.luke-jr@utopios.org> <20051204232205.GF8914@kroah.com>
In-Reply-To: <20051204232205.GF8914@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sun, Dec 04, 2005 at 04:46:31AM +0000, Luke-Jr wrote:
> 
>>Well, devfs does have some abilities udev doesn't: hotplug/udev
>>doesn't detect everything, and can result in rarer or non-PnP devices
>>not being automatically available;
> 
> 
> Are you sure about that today?  And udev wasn't created to do everything
> that devfs does.  And devfs can't do everything that udev can (by
> far...)
> 
> 
>>devfs has the effect of trying to load a module when a program looks
>>for the devices it provides-- while it can cause problems, it does
>>have a possibility to work better.
> 
> 
> Sorry, but that model of loading modules is very broken and it is good
> that we don't do that anymore (as you allude to.)
> 
> 
>>Interesting effects of switching my desktop from devfs to udev:
>>1. my DVD burners are left uninitialized until I manually modprobe ide-cd or 
>>(more recently) ide-scsi
> 
> 
> Sounds like a broken distro configuration :)
> 
> 
>>2. my sound card is autodetected and the drivers loaded, but the OSS emulation 
>>modules are omitted; with devfs, they would be autoloaded when an app tried 
>>to use OSS
> 
> 
> Again, broken distro configuration :)

If a new udev config is needed with every new kernel, why isn't it in
the kernel tarball? Is that what you mean by "broken distro
configuration?" The info should be in /proc or /sys and not in an
external config file, particularly if a different versions per-kernel is
needed and people are trying new kernels and perhaps falling back to the
old.

Have "make install" drop the udev config in /boot like the initrd file.
The the boot could create an slink to "/boot/$(uname -r)-udev" or some such.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

