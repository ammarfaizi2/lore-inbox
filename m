Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262195AbSIZFyt>; Thu, 26 Sep 2002 01:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262197AbSIZFyt>; Thu, 26 Sep 2002 01:54:49 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:39908 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S262195AbSIZFyr>; Thu, 26 Sep 2002 01:54:47 -0400
Message-ID: <3D92A304.2000301@snapgear.com>
Date: Thu, 26 Sep 2002 16:02:44 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: linux-2.5.38uc2 (MMUless support)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

I have generated a new uClinux patch, linux-2.5.38uc2.
Lots of fixups and cleanups in this one. You can get
the big "all-in-one" patch at the usual place:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.38uc2.patch.gz


And the smaller self contained patches as:

. Motorola 5272 ethernet driver
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.38uc2-fec.patch.gz

. Motorola 68328 and ColdFire serial drivers
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.38uc2-serial.patch.gz

. Motorola 68328 framebuffer
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.38uc2-fb.patch.gz

. uClinux FLAT file format exe loader
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.38uc2-binflat.patch.gz

. MMU-less support
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.38uc2-mmnommu.patch.gz

. Motorola embedded m68k/ColdFire architecture support
   (support for 68328, 68360, 5206, 5206e, 5249, 5272, 5307, 5407)
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.38uc2-m68knommu.patch.gz


Changelog:

1. fixup compile problems with 68328 targets
    (changes to entry.S, config.c, ints.c)
2. fix up Rules.make for 68328 targets
3. moved serial drivers into drivers/serial
4. cleaned ethernet driver
5. remove local MIN/MAX functions

Lots of changes under the hood. Still more to do though.
On the todo list currently is:

1. clean out use of inflate2.c in binfmt_flat.c loader
2. switch over to new serial driver architecture
3. merge mmnommu and mm directories
4. clean up 68360 support

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

