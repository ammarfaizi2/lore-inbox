Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317520AbSHCLlv>; Sat, 3 Aug 2002 07:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317536AbSHCLlv>; Sat, 3 Aug 2002 07:41:51 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:1496 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S317520AbSHCLlu>; Sat, 3 Aug 2002 07:41:50 -0400
Message-ID: <3D4BC243.90700@Synopsys.COM>
Date: Sat, 03 Aug 2002 13:45:07 +0200
From: Harald Dunkel <harri@synopsys.COM>
Reply-To: harri@synopsys.COM
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.4.19
References: <Pine.LNX.4.44.0208022113570.3863-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I've got billions of undefined symbols during 'make modules_install'.

:
cd /lib/modules/2.4.19; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.19; fi
depmod: *** Unresolved symbols in /lib/modules/2.4.19/kernel/drivers/cdrom/cdrom.o
depmod:         register_sysctl_table_Rab92f33e
depmod:         kmalloc_R93d4cfe6
depmod:         __generic_copy_to_user_Rd523fdd3
depmod:         __generic_copy_from_user_R116166aa
:

Is this due to gcc 2.95.4? Can anybody reproduce this? I'm
running Debian (Sid, i386).


Regards

Harri

