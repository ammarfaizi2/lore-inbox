Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbTICO3z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 10:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTICO3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 10:29:55 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:23767 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262471AbTICO2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 10:28:45 -0400
Date: Wed, 3 Sep 2003 16:27:59 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6: CPU dependent inline in 8250 serial drivers
Message-ID: <20030903142758.GA23729@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

drivers/serial/8250.h in 2.6 contains the following:

<--  snip  -->

...
#if defined(__i386__) && (defined(CONFIG_M386) || defined(CONFIG_M486))
#define SERIAL_INLINE
#endif
  
#ifdef SERIAL_INLINE
#define _INLINE_ inline
#else
#define _INLINE_
#endif
...

<--  snip  -->

Why should these functions be inlined only for 386 and 486 CPUs but not 
for more recent CPUs or other architectures?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

