Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130021AbRBGTEN>; Wed, 7 Feb 2001 14:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130093AbRBGTED>; Wed, 7 Feb 2001 14:04:03 -0500
Received: from wiz.cath.vt.edu ([128.173.51.243]:43790 "EHLO wiz.cath.vt.edu")
	by vger.kernel.org with ESMTP id <S130021AbRBGTDs>;
	Wed, 7 Feb 2001 14:03:48 -0500
From: Len Hatfield <lhat@wiz.cath.vt.edu>
Message-Id: <200102071900.f17J0IR24989@wiz.cath.vt.edu>
Subject: IRQ Routing Troubles with 2.4.1?
To: linux-kernel@vger.kernel.org
Date: Wed, 7 Feb 2001 14:00:18 -0500 (EST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks:

We've been running successfully Slackware 7.1 (kernel 2.2.16) on
a new Penguin Computing server (PIII uniprocessor with two 18gb
Hitachi drives and the Adaptec 7896/7 onboard scsi controller).

In attempting to upgrade to kernel 2.4.1, we began to get
strange bugs apparently from the aic7xxx drivers, which seemed
to develop endless timeout loops.  At the same time, as the
various boot messages went by, there was often a notice that two
devices were assigned to IRQ 11, 00:0c.0 and 00:0c.1, which
corresponded to the addresses for the two hard drives. 
These troubles appeared with the vanilla 2.4.0 kernel, and
remained in place through appying Alan Cox's patches to 2.4.0
and 2.4.1.  We're currently running 2.4.1-ac3.

After prolonged experimentation under the expert guidance of
Doug Ledford, I tried turning on the APIC and IO-APIC options in
menuconfig (under Processor).  This eliminated the problem
immediately.

Doug suggested I post this information to linux-kernel in case
this might point to something being amiss in the "IRQ routing".

As I'm not subscribed to the list, please CC any replies or queries to
me at lhat@wiz.cath.vt.edu.

Thanks!
 
-- 

					...Len Hatfield
					   Virginia Tech
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
