Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319081AbSHFMQK>; Tue, 6 Aug 2002 08:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319082AbSHFMQK>; Tue, 6 Aug 2002 08:16:10 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:19474 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S319081AbSHFMQJ>;
	Tue, 6 Aug 2002 08:16:09 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andries Brouwer <aebr@win.tue.nl>
Date: Tue, 6 Aug 2002 14:19:29 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] 2.5.30 IDE 112
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, martin@dalecki.de
X-mailer: Pegasus Mail v3.50
Message-ID: <13C83160220@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  6 Aug 02 at 12:27, Andries Brouwer wrote:
> On Tue, Aug 06, 2002 at 10:50:42AM +0200, Marcin Dalecki wrote:
> > - Just removaing dead obscure xlate_1024 code.
> 
> Command line options must be added to ask for what this
> xlate_1024 code did earlier. So, some fragments of what you remove
> in this patch will have to come back in some form.

FYI I had to use hda=cyls,255,63 to repartition my HDD. BIOS refused
to report proper size (120GB) when partition table was empty, or when
it contained partitions created for xxx/16/63 geometry. It reported
size ~600MB, and actively refused to allow access above this limit...

With removed (either completely, or just disabling as it is now) xlate_1024 
code please talk to [cs]fdisk maintainer (and other) to print big fat
warning and to allow specify BIOS heads/sectors, otherwise partitioning
of empty disk in the way compatible with non-Linux OSes (Netware, Windows)
is not an easy task.
                                                        Petr Vandrovec
                                                        
# lilo
Warning: Int 0x13 function 8 and function 0x48 return different
head/sector geometries for BIOS drive 0x81
    fn 08: 788 cylinders, 255 heads, 63 sectors
    fn 48: 13424 cylinders, 15 heads, 63 sectors
Warning: Kernel & BIOS return differing head/sector geometries for device 0x80
    Kernel: 35973 cylinders, 16 heads, 63 sectors
      BIOS: 1023 cylinders, 255 heads, 63 sectors
