Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265325AbTFZC1E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 22:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265330AbTFZC1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 22:27:04 -0400
Received: from ajax.cs.uga.edu ([128.192.251.3]:62183 "EHLO ajax.cs.uga.edu")
	by vger.kernel.org with ESMTP id S265325AbTFZC1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 22:27:02 -0400
Date: Wed, 25 Jun 2003 22:47:07 -0400
From: Ed L Cashin <ecashin@uga.edu>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: compile error in drivers/perfctr/x86.c (Re: 2..5.73-osdl2)
Message-ID: <20030625224707.A15559@atlas.cs.uga.edu>
References: <20030625174048.221471a0.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030625174048.221471a0.shemminger@osdl.org>; from shemminger@osdl.org on Wed, Jun 25, 2003 at 05:40:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 05:40:48PM -0700, Stephen Hemminger wrote:
> http://developer.osdl.org/shemminger/patches/patch-2.5.73-osdl2.bz2

Hi.  I'm getting a compile error:

  CC      drivers/perfctr/x86_setup.o
  CC      drivers/perfctr/x86.o
drivers/perfctr/x86.c: In function `unregister_nmi_pmdev':
drivers/perfctr/x86.c:1484: `nmi_pmdev' undeclared (first use in this function)
drivers/perfctr/x86.c:1484: (Each undeclared identifier is reported only once
drivers/perfctr/x86.c:1484: for each function it appears in.)
drivers/perfctr/x86.c:1485: warning: implicit declaration of function `apic_pm_unregister'
drivers/perfctr/x86.c: In function `x86_pm_init':
drivers/perfctr/x86.c:1500: warning: implicit declaration of function `apic_pm_register'
drivers/perfctr/x86.c:1500: warning: assignment makes pointer from integer without a cast
make[2]: *** [drivers/perfctr/x86.o] Error 1
make[1]: *** [drivers/perfctr] Error 2
make: *** [drivers] Error 2

Here is .config and ver_linux output:

  http://www.cs.uga.edu/~cashin/temp/2.5.73-osdl2-error.txt

-- 
--Ed L Cashin            |   PGP public key:
  ecashin@uga.edu        |   http://noserose.net/e/pgp/
