Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319079AbSHFMYX>; Tue, 6 Aug 2002 08:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319082AbSHFMYX>; Tue, 6 Aug 2002 08:24:23 -0400
Received: from [195.63.194.11] ([195.63.194.11]:58119 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S319079AbSHFMYW>; Tue, 6 Aug 2002 08:24:22 -0400
Message-ID: <3D4FBFA4.3030809@evision.ag>
Date: Tue, 06 Aug 2002 14:23:00 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: Andries Brouwer <aebr@win.tue.nl>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, martin@dalecki.de
Subject: Re: [PATCH] 2.5.30 IDE 112
References: <13C83160220@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Petr Vandrovec napisa?:
> On  6 Aug 02 at 12:27, Andries Brouwer wrote:
> 
>>On Tue, Aug 06, 2002 at 10:50:42AM +0200, Marcin Dalecki wrote:
>>
>>>- Just removaing dead obscure xlate_1024 code.
>>
>>Command line options must be added to ask for what this
>>xlate_1024 code did earlier. So, some fragments of what you remove
>>in this patch will have to come back in some form.
> 
> 
> FYI I had to use hda=cyls,255,63 to repartition my HDD. BIOS refused
> to report proper size (120GB) when partition table was empty, or when
> it contained partitions created for xxx/16/63 geometry. It reported
> size ~600MB, and actively refused to allow access above this limit...
> 
> With removed (either completely, or just disabling as it is now) xlate_1024 
> code please talk to [cs]fdisk maintainer (and other) to print big fat
> warning and to allow specify BIOS heads/sectors, otherwise partitioning
> of empty disk in the way compatible with non-Linux OSes (Netware, Windows)
> is not an easy task.

Sidenote 1. - they can do the recalculation done by xlate_1024 themself 
of  course.

Sidenote 2. - Linux is thinking xxx/16/63 is the best way to deal with 
big disks. Phenix BIOS docu says xxxx/255/63 is the way to go.


