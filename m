Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131563AbRAGXKf>; Sun, 7 Jan 2001 18:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132405AbRAGXKZ>; Sun, 7 Jan 2001 18:10:25 -0500
Received: from snark.wizard.com ([209.170.216.3]:59910 "EHLO snark.wizard.com")
	by vger.kernel.org with ESMTP id <S131563AbRAGXKV>;
	Sun, 7 Jan 2001 18:10:21 -0500
Date: Sun, 7 Jan 2001 15:02:40 -0800
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FW: compile problem in 2.4.0-ac3
Message-ID: <20010107150240.A7070@wizard.com>
In-Reply-To: <20010107043225.A4452@wizard.com> <32477.978872228@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
In-Reply-To: <32477.978872228@ocs3.ocs-net>; from kaos@ocs.com.au on Sun, Jan 07, 2001 at 11:57:08PM +1100
X-Operating-System: Linux/2.4.0-ac2 (i586)
X-uptime: 1:48pm  up 10:10,  4 users,  load average: 0.00, 0.00, 0.00
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-PGP-Keys: see http://www.omnilinx.net/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 11:57:08PM +1100, Keith Owens wrote:
> On Sun, 7 Jan 2001 04:32:25 -0800, 
> A Guy Called Tyketto <tyketto@wizard.com> wrote:
> >make[3]: Entering directory `/usr/src/linux/drivers/acpi'
> >gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 
> >-fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 
> >-march=k6
> >-I./include -D_LINUX  -DEXPORT_SYMTAB -c acpi_ksyms.c
> >acpi_ksyms.c:25: linuxpi.h: No such file or directory
> 
> Line 25 in patch-2.4.0-ac3.bz2 says
> 
> #include <linux/acpi.h>
> 
> You have corrupted your source.

        This is what I get for trying this at 4am in the morning! *g*

        This isn't happening to acpi_ksyms.c, but actually 
drivers/acpi/ksyms.c (the assume -R bit, I mean). I still get the above error 
with. I'm still seeing 

#include <linuxpi.h>

        at line 25 of acpi_ksyms.c. This is also the same line, in 
patch-2.4.0-ac2 (counted the lines of each). Neither patches compile from this.
I've gone through the -ac2 patch, and there's only 2 places where <linuxpi.h> 
is located: added to the newly-created acpi_ksyms.c from the patch, and being 
backed out of drivers/acpi/ksyms.c. Other than that, there is no mention of it 
in the source. Only saying no to CONFIG_ACPI gets around it.

                                                        BL.
--
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
