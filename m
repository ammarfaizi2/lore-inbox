Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266760AbSKLXTG>; Tue, 12 Nov 2002 18:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266709AbSKLXTG>; Tue, 12 Nov 2002 18:19:06 -0500
Received: from air-2.osdl.org ([65.172.181.6]:47538 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266760AbSKLXTE>;
	Tue, 12 Nov 2002 18:19:04 -0500
Message-Id: <200211122325.gACNPhr08344@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: James Stevenson <james@stev.org>
cc: Per Andreas Buer <perbu@linpro.no>, linux-kernel@vger.kernel.org,
       cliffw@osdl.org
Subject: Re: iostats broken for devices with major number > DK_MAX_DISK (16) 
In-Reply-To: Message from James Stevenson <james@stev.org> 
   of "12 Nov 2002 23:01:03 GMT." <1037142064.1570.0.camel@god.stev.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 12 Nov 2002 15:25:43 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2002-11-12 at 20:35, Per Andreas Buer wrote:
> > Hi,
> > 
> > sorry for the intrusion. I noticed iostats didn't display statistics for
> > devices on Mylex RAID constrollers. Det statistics are completely
> > missing in /proc/stat. The reason seems to be an assumption that disks
> > have major numbers which are below 16
> > (http://lxr.linux.no/source/include/linux/kernel_stat.h#L15) which is
> > used by http://lxr.linux.no/source/fs/proc/proc_misc.c#L344.
> > 
> > Devices on Mylex-controllers have major number 48. Would it break
> > anything if DK_MAX_MAJOR if set higher (e.g. 64)?
> > 
> > AFAIK this goes for both 2.4 and the 2.5 series.
> 
> i have been runing with 2.4.x kernel with this number
> set higher i have still yet to see any problem with it
> other than using more memory.
> 
We've had the same problem, and we've been running with DK_MAX_MAJOR == 64, 
using megaraid and acceleraid 2000 controllers. 
Haven't seen any problems 
cliffw
OSDL
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


