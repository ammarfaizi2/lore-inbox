Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVFBVrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVFBVrb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 17:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVFBVpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 17:45:04 -0400
Received: from mail.tyan.com ([66.122.195.4]:25355 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261432AbVFBVdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 17:33:12 -0400
Message-ID: <3174569B9743D511922F00A0C94314230A40399F@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.6.12-rc5 is broken in nvidia Ck804 Opteron MB/with dual cor
	 e dual way
Date: Thu, 2 Jun 2005 14:34:24 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you duplicate the timing problem?

YH

> > Also I found the workaround for hang on second node is 
> adding one line 
> > in setup.c
> >         /* Low order bits define the core id (index of core 
> in socket) */
> >         cpu_core_id[cpu] = phys_proc_id[cpu] & ((1 << bits)-1);
> >         /* Convert the APIC ID into the socket ID */
> >         phys_proc_id[cpu] >>= bits;
> > +        printk(KERN_INFO "  CPU %d(%d)  phys_proc_id %d  
> Core %d\n", 
> > +               cpu, c->x86_num_cores, phys_proc_id[cpu], 
> > + cpu_core_id[cpu]);
> 
> That would just change the timing.
> 
> -Andi
> 
