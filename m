Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262690AbSJBXaf>; Wed, 2 Oct 2002 19:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262691AbSJBXaf>; Wed, 2 Oct 2002 19:30:35 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:31482 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S262690AbSJBXae>; Wed, 2 Oct 2002 19:30:34 -0400
Message-ID: <3D9B8363.6030806@snapgear.com>
Date: Thu, 03 Oct 2002 09:38:11 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@redhat.com>
Subject: Re: Linux 2.5.40-ac1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan,

> Linux 2.5.40-ac1
[snip]
> o	Merge most of ucLinux stuff			(Greg Ungerer)

Woohoo!


> 	| It needs putting somewhere so we can pick over the
> 	| hard bits left
> 	| Q: Wouldn't drivers/char/mem-nommu.c be better

OK, that is easy to do...


> 	| Q: How to do the procfs stuff tidily

Yes. I need to spend some time on this one. Just lots
of little differences...


> 	| Q: Wouldn't it be nicer to move all mm or mmnommu specific ksyms
> 	|    int the relevant mm/*.c file area instead of kernel/ksyms

OK, I have a new patch today that cleans all this up.
I made all the existing ksysms symbols present. It turns out
many where already there in my more recent patches anyway.
A couple needed to be stubbed. The next patch has no diffs
to ksyms at all.


> 	| Q: Why ifdef out overcommit -  its even easier to account on 
> 	|    MMUless and useful info

I was looking over this yesterday too. Should be able to clean this
up a bit.

What do you think about the separate mm/mmnommu directories
at the top level?  Should the mmnommu be merged into mm?

Do you want me to CC you when I put new patches up?

Thanks
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

