Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbVINUOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbVINUOM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 16:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbVINUOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 16:14:11 -0400
Received: from smtpout.mac.com ([17.250.248.47]:27344 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932543AbVINUOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 16:14:10 -0400
In-Reply-To: <20050914200123.GC15017@mikebell.org>
References: <20050911114435.5990.qmail@science.horizon.com> <808CC4DC-15F3-4F6E-A9C6-6CBEC3D5415F@mac.com> <20050914200123.GC15017@mikebell.org>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EE790043-4D94-4B5D-B8C9-E4C1718291E7@mac.com>
Cc: linux@horizon.com, linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13
Date: Wed, 14 Sep 2005 16:13:45 -0400
To: Mike Bell <mike@mikebell.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 14, 2005, at 16:01:24, Mike Bell wrote:
> On Sun, Sep 11, 2005 at 11:43:02AM -0400, Kyle Moffett wrote:
>> That sounds like _exactly_ the case where the Debian folks could  
>> maintain the out-of-tree ndevfs patch for a while until they got  
>> their installer floppies and such migrated to udev.
>
> Then you know nothing about the subject at hand. Moving from devfs  
> to ndevfs is dramatically /harder/ than moving from devfs to udev.  
> ndevfs is not devfs compatible in any way, shape or form.

The debian installer has devfs paths coded into it, ok, sure.  The  
reason it used devfs was so it didn't need extra userspace stuff to  
create device nodes.  It seems like the installer could be reasonably  
easily converted to use different path names without changing any  
_real_ code at all, and from there all you need to do is add the  
ndevfs patch to the kernel.  It's probably about as difficult to add  
the udev userspace stuff at the right point in the boot process (you  
still need to change all the pathnames), as it is to add the ndevfs  
patch to the kernel.  On the other hand, the latter _might_ result in  
a smaller floppy image, which is what the Debian developers really  
wanted/needed.  I suppose it would be nice if the busybox people  
added basic udev-type functionality, but it's not really all that  
necessary.

Cheers,
Kyle Moffett

--
I lost interest in "blade servers" when I found they didn't throw  
knives at people who weren't supposed to be in your machine room.
   -- Anthony de Boer


