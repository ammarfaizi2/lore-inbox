Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266464AbSL2Fv1>; Sun, 29 Dec 2002 00:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266473AbSL2Fv1>; Sun, 29 Dec 2002 00:51:27 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:13262 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S266464AbSL2Fv0>; Sun, 29 Dec 2002 00:51:26 -0500
Message-ID: <3E0E9229.6070404@kegel.com>
Date: Sat, 28 Dec 2002 22:11:53 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows 98)
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Andrew McGregor <andrew@indranet.co.nz>
CC: linux-kernel@vger.kernel.org
Subject: Re: FAQ: how to boot with root=LABEL=/
References: <3E0DF78D.6060205@kegel.com> <57400000.1041112349@localhost.localdomain>
In-Reply-To: <57400000.1041112349@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll just pass the device for now, but I appreciate the
explanation, and maybe it'll help the next fellow who runs into this.
- Dan

Andrew McGregor wrote:
> You need to build an initrd for that to work.  That is actually handled 
> by the scripts in the initrd, so without those...
> 
> One workaround to get the ramdisk without having to use modules goes 
> like this:
> 
> Do a make modules_install anyway.  That sets up the directory layout in 
> /lib/modules, without which mkinitrd fails.  Remove any modules that get 
> installed (2.4 makefiles will probably build and install modules even if 
> CONFIG_MODULES is not set).
> 
> Then build the kernel and do a make install, and the /sbin/installkernel 
> script will do the right thing.
> 
> Not tested, but given my understanding of how RH8 boots, should work.
> 
> Or else just pass the device.
> 
> Andrew
> 
> --On Saturday, December 28, 2002 11:12:13 -0800 Dan Kegel 
> <dank@kegel.com> wrote:
> 
>> I'm trying to configure a minimal 2.4.17 to boot
>> on my redhat 8 box.  No modules, no sound, nothing fancy at all.
>>
>> One problem I'm having is it only works if I boot with root=/dev/hda9
>> instead of red hat's usual root=LABEL=/
>> I thought I had configured in the proper partition support.
>>
>> Can anyone point out what's missing from my .config (or from 2.4.17)
>> to allow booting with root=LABEL=/ ?

-- 
Dan Kegel
Linux User #78045
http://www.kegel.com

