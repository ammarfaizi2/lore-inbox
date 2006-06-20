Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWFTWaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWFTWaG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWFTW33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:29:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39133 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751340AbWFTW3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:29:07 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <discuss@x86-64.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andi Kleen <ak@suse.de>,
       "Natalie Protasevich" <Natalie.Protasevich@UNISYS.com>,
       "Len Brown" <len.brown@intel.com>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>,
       "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>,
       Mark Maule <maule@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Roland Dreier <rdreier@cisco.com>, Tony Luck <tony.luck@intel.com>,
       "Eric W. Biederman" <ebiederman@lnxi.com>
Subject: [PATCH 25/25] irq: Document what an IRQ is.
Reply-To: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 20 Jun 2006 16:28:38 -0600
Message-Id: <11508425271395-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.0.gc07e
In-Reply-To: <1150842527127-git-send-email-ebiederm@xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com> <11508425183073-git-send-email-ebiederm@xmission.com> <11508425191381-git-send-email-ebiederm@xmission.com> <11508425192220-git-send-email-ebiederm@xmission.com> <11508425191063-git-send-email-ebiederm@xmission.com> <1150842520235-git-send-email-ebiederm@xmission.com> <11508425201406-git-send-email-ebiederm@xmission.com> <1150842520775-git-send-email-ebiederm@xmission.com> <11508425213394-git-send-email-ebiederm@xmission.com> <115084252131-git-send-email-ebiederm@xmission.com> <11508425213795-git-send-email-ebiederm@xmission.com> <11508425222427-git-send-email-ebiederm@xmission.com> <11508425221394-git-send-email-ebiederm@xmission.com> <11508425223015-git-send-email-ebiederm@xmission.com> <1150842523493-git-send-email-ebiederm@xmission.com> <11508425231168-git-send-email-ebiederm@xmission.com> <1150842524863-git-send-email-ebiederm@xmission.com> <1150842524755-git-send-email-ebiederm@xmission.com> <115084252460-git-send-!
 email-ebiederm@xmission.com> <11508425251099-git-send-email-ebiederm@xmission.com> <11508425253581-git-send-email-ebiederm@xmission.com> <11508425254020-git-send-email-ebiederm@xmission.com> <11508425262259-git-send-email-ebiederm@xmission.com> <11508425263761-git-send-email-ebiederm@xmission.com> <1150842527127-git-send-email-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederman@lnxi.com>

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 Documentation/IRQ.txt |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/Documentation/IRQ.txt b/Documentation/IRQ.txt
new file mode 100644
index 0000000..237235d
--- /dev/null
+++ b/Documentation/IRQ.txt
@@ -0,0 +1,22 @@
+What is an IRQ?
+
+An IRQ is an interrupt request from a device.  
+Currently they can come in over a pin, or over a packet.
+Several devices may be connected to the same pin thus
+sharing an IRQ.
+
+An IRQ number is a kernel identifier used to talk about a hardware
+interrupt source.  Typically this is an index into the global irq_desc
+array, but except for what linux/interrupt.h implements the details
+are architecture specific.
+
+An IRQ number is an enumeration of the possible interrupt sources on a
+machine.  Typically what is enumerated is the number of input pins on
+all of the interrupt controller in the system.  In the case of ISA
+what is enumerated are the 16 input pins on the two i8259 interrupt
+controllers.
+
+Architectures can assign additional meaning to the IRQ numbers, and
+are encouraged to in the case  where there is any manual configuration
+of the hardware involved.  The ISA IRQs are a classic example of
+assigning this kind of additional meaning.
-- 
1.4.0.gc07e

