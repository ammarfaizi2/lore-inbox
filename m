Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316957AbSF0UWs>; Thu, 27 Jun 2002 16:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316958AbSF0UWr>; Thu, 27 Jun 2002 16:22:47 -0400
Received: from 207-191-215-19.cpe.ats.mcleodusa.net ([207.191.215.19]:36879
	"HELO cedar-astronomers.org") by vger.kernel.org with SMTP
	id <S316957AbSF0UWp>; Thu, 27 Jun 2002 16:22:45 -0400
Date: Thu, 27 Jun 2002 15:44:58 -0500 (CDT)
From: Jason Alexander <linux@cedar-astronomers.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-rc1 proc_get_inode Unresolved in /net/wan/comx.o 
Message-ID: <Pine.LNX.4.44.0206271539190.24838-100000@cedar-astronomers.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm not typically a kernel hacker so if this has been answered someplace 
else I'm sorry.  I'm only doing this to get some ATA100 support for my
ide controller to fix some errors and disk corruption problems.

I did a build today of 2.4.19-rc1 and was moving along event free until I 
got to make modules_install.  I get the following errors.

find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.19-rc1; fi
depmod: *** Unresolved symbols in /lib/modules/2.4.19-rc1/kernel/drivers/net/wan/comx.o
depmod:         proc_get_inode

I did some searching in the archives and this seems to have been a problem 
going back to 2.4.5 but don't see an answer to if this has been fixed.
I assume that since this is in the PCMCIA section of the kernel and I am
running a desktop machine that I can just disable PCMCIA and this might
go away but I have not tried that yet.

What would be the best way to proceed.

Thanks
Jason

