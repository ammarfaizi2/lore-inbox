Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267424AbUIATlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267424AbUIATlr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 15:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267446AbUIATlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 15:41:46 -0400
Received: from psems1.agilysys.com ([199.33.129.48]:4112 "HELO psems1.pios.com")
	by vger.kernel.org with SMTP id S267424AbUIATl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 15:41:27 -0400
Subject: Re: Kernel or Grub bug.
From: "Wise, Jeremey" <jeremey.wise@agilysys.com>
To: Oliver Hunt <oliverhunt@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4699bb7b04090109415f64fea1@mail.gmail.com>
References: <1094008341.4704.32.camel@wizej.agilysys.com>
	 <200408312358.08153.dsteven3@maine.rr.com>
	 <1094041227.4635.7.camel@wizej.agilysys.com>
	 <200409011135.36537.dsteven3@maine.rr.com>
	 <1094055985.4635.44.camel@wizej.agilysys.com>
	 <4699bb7b04090109415f64fea1@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 01 Sep 2004 15:40:12 -0400
Message-Id: <1094067612.15795.19.camel@wizej.agilysys.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 04:41 +1200, Oliver Hunt wrote:
> If the reiserfs module is compiled as, well, a module, rather than
> built in to the kernel you won't be able to boot.
> 
> To load modules kernel needs access to modules, but as these reside on
> a reiserfs partition it needs to load the reiserfs module... hence it
> isn't possible to do that.
> 
> Note:  If you've other filesystems you can load them as modules, the
> important one is your root file system needs to be mounable without
> modules.
Maybe I am a bit confused here but I take the above statement to mean
one of two options

1) If I choose to compile the required file system modules "reiserfs"
monolithicaly into my 2.8.1 kernel I can NOT also allow the kernel to
see a module in initrd for reiserfs.ko? If this is what you mean .. my
question is why would the kernel even care? The mount request would be
called and the proper module (reiserfs) would be present to parse said
request. Please correct
2) If I choose to compile the kernel with reiserfs as a modules (ie not
monolithicaly  in the kernel) then I will have issues as the kernel has
to have the driver reiserfs to mount the root file system to be able to
load /lib/modules/..../reiserfs.ko. If this is what you meant then
again, I am a bit confused. I thought that was the whole point of the
initrd image in that those modules (RAID, FC, USB, Network
etc....)required to get the OS to the state that it has a / they must be
compiled in the initrd which is called and referaned in grub or lilo.
Again, please correct me if I am wrong.


-- 
Thanks,

Jeremey Wise
jeremey.wise@agilysys.com

All opinions or information expressed here are personal in nature and do
not reflect the official position of Agilysys Inc.
