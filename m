Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUDKLhX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 07:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbUDKLhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 07:37:23 -0400
Received: from sigma.informatik.hu-berlin.de ([141.20.20.51]:41635 "EHLO
	sigma.informatik.hu-berlin.de") by vger.kernel.org with ESMTP
	id S262176AbUDKLhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 07:37:22 -0400
From: Axel Weiss <aweiss@informatik.hu-berlin.de>
Organization: Humboldt-Universitaet zu Berlin
To: linux-kernel@vger.kernel.org
Subject: 2.6.5 - incomplete headers?
Date: Sun, 11 Apr 2004 13:27:19 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404111327.19744.aweiss@informatik.hu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm going to bring my device drivers[1] from 2.4 to 2.6 and have successfully 
installed kernel-2.6.5 for my athlon-PC.

Compiling (unmodified) 2.4-sources of my modules stops, missing irq_vectors.h.

What do I have to do to successfully include <linux/interrupt.h> from inside a 
kernel module? Or is ther a completely different strategy for ISRs in 2.6? 
(Where is the starting point to read, in this case?)

FYI:

$ uname -r
2.6.5

$ gcc -c -Wall -I/lib/modules/`uname -r`/build/include -DMODULE -D__KERNEL__ 
-DHARMONIE_DEBUG harmonie_io.c
In file included from /lib/modules/2.6.5/build/include/linux/irq.h:20,
                 from /lib/modules/2.6.5/build/include/asm/hardirq.h:6,
                 from /lib/modules/2.6.5/build/include/linux/interrupt.h:11,
                 from harmonie_io.c:44:
/lib/modules/2.6.5/build/include/asm/irq.h:16:25: irq_vectors.h: No such file 
or directory

Regards,
Axel Weiss

[1] device drivers for some dsp-cards, can be found at http://sourceforge.net/
projects/freesp/

