Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWH3S1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWH3S1A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 14:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWH3S07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 14:26:59 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:32194 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1751199AbWH3S07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 14:26:59 -0400
Date: Wed, 30 Aug 2006 11:20:53 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Sven Luther <sven.luther@wanadoo.fr>
cc: Olaf Hering <olaf@aepfle.de>, Michael Buesch <mb@bu3sch.de>,
       Greg KH <greg@kroah.com>, Oleg Verych <olecom@flower.upol.cz>,
       James Bottomley <James.Bottomley@steeleye.com>,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
In-Reply-To: <20060830181310.GA11213@powerlinux.fr>
Message-ID: <Pine.LNX.4.63.0608301119170.31356@qynat.qvtvafvgr.pbz>
References: <1156802900.3465.30.camel@mulgrave.il.steeleye.com> 
 <Pine.LNX.4.63.0608290844240.30381@qynat.qvtvafvgr.pbz>  <20060829183208.GA11468@kroah.com>
 <200608292104.24645.mb@bu3sch.de>  <20060829201314.GA28680@aepfle.de> 
 <Pine.LNX.4.63.0608291341060.30381@qynat.qvtvafvgr.pbz>  <20060830054433.GA31375@aepfle.de>
  <Pine.LNX.4.63.0608301048180.31356@qynat.qvtvafvgr.pbz>
 <20060830181310.GA11213@powerlinux.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2006, Sven Luther wrote:

> On Wed, Aug 30, 2006 at 10:52:02AM -0700, David Lang wrote:
>> On Wed, 30 Aug 2006, Olaf Hering wrote:
>>
>>>> you are assuming that
>>>>
>>>> 1. modules are enabled and ipw2200 is compiled as a module
>>>
>>> No, why?
>>
>> becouse if the ipw isn't compiled as a module then it's initialized
>> (without firmware) before the initramfs or initrd is run. if it could be
>> initialized later without being a module then it could be initialized as
>> part of the normal system
>
> Euh, ...
>
> I wonder why you need to initialize the ipw2200 module so early ? It was my
> understanding that the initramfs thingy was run very early in the process, and
> i had even thought of moving fbdev modules into it.
>
> Do you really need to bring up ipw2200 so early ? It is some kind of wireless
> device, right ?

if modules are not in use the device is initialized when the kernel starts up. 
this is before any userspace starts.

> As for initramfs, you can just cat it behind the kernel, and it should work
> just fine, or at least this is how it was supposed to work.

yes, if I want to set one up.

other then this new requirement to have the ipw2200 driver as a module I have no 
reason to use one. normal userspace is good enough for me.

David Lang

> Friendly,
>
> Sven Luther
>
