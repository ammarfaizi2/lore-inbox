Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316681AbSGZBRN>; Thu, 25 Jul 2002 21:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSGZBRN>; Thu, 25 Jul 2002 21:17:13 -0400
Received: from pacific.moreton.com.au ([203.143.238.4]:32498 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S316681AbSGZBRM>; Thu, 25 Jul 2002 21:17:12 -0400
Message-ID: <3D40A3E4.9050703@snapgear.com>
Date: Fri, 26 Jul 2002 11:20:36 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: linux-kernel@vger.kernel.org, David McCullough <davidm@snapgear.com>
Subject: Re: [PATCH]: uClinux (MMU-less) patches against 2.5.28
References: <3D3FA130.6020701@snapgear.com> <9309.1027608767@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

 >David Woodhouse wrote:
 > > gerg@snapgear.com said:
 > >
 > > A new set of uClinux (MMU-less) patches agains 2.5.28. You can get 
it at:
 > >
 > > 
http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.28uc0.patch.gz
 > >
 > >
 > > Perhaps drop drivers/block/blkmem.c or justify reinventing the wheel?
 >
 > Indeed. That blkmem driver is a complete mess.
 > I can't think of any justification for it existing :-)
 > I'll work on cleaning that out.

You may have noticed some MAGIC_ROM_PTR patches in the mtd
driver code in this patch. This is to allow XIP for applications.
We have been support XIP for quite some time on uClinux, it
works really well.

A problem we have experienced with MTD is that the nature of
asynchronous writing to FLASH does not play nice with apps
runing XIP.  Any thoughts on how to deal with this?

(blkmem does synchronous writes so it doesn't suffer any
problem. It just locks everyone out for an in-ordinate amount
of time while it does the FLASH write).

Regards
Greg



------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.snapgear.com


