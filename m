Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbVHHO5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbVHHO5p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 10:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbVHHO5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 10:57:45 -0400
Received: from alpha.polcom.net ([217.79.151.115]:60353 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S1750926AbVHHO5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 10:57:44 -0400
Date: Mon, 8 Aug 2005 16:57:37 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Olaf Hering <olh@suse.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, klibc@zytor.com,
       linux-kernel@vger.kernel.org
Subject: Re: [klibc] Re: [PATCH - RFC] Move initramfs configuration to "General
 setup"
In-Reply-To: <20050808143151.GA6332@suse.de>
Message-ID: <Pine.LNX.4.63.0508081654280.29195@alpha.polcom.net>
References: <20050808135936.GA9057@mars.ravnborg.org>
 <Pine.LNX.4.63.0508081610400.29195@alpha.polcom.net> <20050808143151.GA6332@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2005, Olaf Hering wrote:

> On Mon, Aug 08, Grzegorz Kulewski wrote:
>
>>> From my recent experiments it looks like in order to be able to use
>> initramfs not compiled into the kernel image but loaded from separate file
>> by GRUB or LILO one must also build initrd into the kernel.
>
> The file passed from the bootloader to the kernel, which is later
> eventually recognized as an initrd, can be everything. But the kernel
> code to deal with the memory range containing the file is behind
> CONFIG_BLK_DEV_INITRD. The new config options should depend on
> BLK_DEV_INITRD

[ Depend or select? ]

So this code should be separated from initrd and put in some other place 
and depend on initrd || initramfs.

>From what I saw reading the code initrd is much more than this code so why 
keep it together?


Thanks,

Grzegorz Kulewski
