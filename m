Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293092AbSCWNUd>; Sat, 23 Mar 2002 08:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293071AbSCWNUP>; Sat, 23 Mar 2002 08:20:15 -0500
Received: from [195.63.194.11] ([195.63.194.11]:29970 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S293060AbSCWNUB>; Sat, 23 Mar 2002 08:20:01 -0500
Message-ID: <3C9C80AA.1080800@evision-ventures.com>
Date: Sat, 23 Mar 2002 14:18:34 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Patch to split kmalloc in sd.c in 2.4.18+
In-Reply-To: <20020322215809.A17173@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> Hello:
> 
> One problem I see when trying to use a box with 128 SCSI disks
> is that sd_mod sometimes refuses to load. Earlier kernels simply
> oopsed when it happened, but that is fixed in 2.4.18. The root
> of the evil is the enormous array sd[] that sd_init allocates.
> Alan suggested to split the allocation, which is what I did.
> 
> Arjan said that it may be easier to use vmalloc, and sure it is.
> However, I heard that vmalloc space is not too big, so it may
> make sense to conserve it (especially on non-x86 32-bitters).

kmalloc is spare - the vmalloc space is *HUUUUUGE*.
(The v stands for virtual as in virtual memmory...)

