Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267078AbSLDUj0>; Wed, 4 Dec 2002 15:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267079AbSLDUj0>; Wed, 4 Dec 2002 15:39:26 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:55557 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S267078AbSLDUjZ>; Wed, 4 Dec 2002 15:39:25 -0500
Date: Wed, 4 Dec 2002 21:46:54 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: Is this patch okay?
Message-ID: <Pine.LNX.4.44.0212042140540.4031-100000@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i downloaded 2.5.50, started compiling it, and it bailed out with an error
in drivers/pci/quirks.c, that sis_apic_bug is not defined.
I did a quick grep around the source and found a file to include.

Basically, this is what i did.

*** linux-2.5.50.old/drivers/pci/quirks.c       Wed Nov 27 23:35:48 2002
--- linux-2.5.50/drivers/pci/quirks.c   Wed Dec  4 21:40:44 2002
***************
*** 18,23 ****
--- 18,24 ----
  #include <linux/pci.h>
  #include <linux/init.h>
  #include <linux/delay.h>
+ #include <asm/io_apic.h>

  #undef DEBUG

Is it okay to include it like that?
Or should it be fixed some other way? I am just getting around the kernel,
though the kernel has one my small patch, i am definitelly no guru.

I guess that some people have already noticed that, so if this has been
resolved, please ignore the patch.
I would appreciate any answer anyway.

Best Regards,
Maciej Soltysiak


