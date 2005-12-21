Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbVLUXPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbVLUXPc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 18:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbVLUXPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 18:15:32 -0500
Received: from fmr17.intel.com ([134.134.136.16]:20901 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S964950AbVLUXPb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 18:15:31 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 01/02] RT: add back plist docs
Date: Wed, 21 Dec 2005 15:15:09 -0800
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A050C2B9B@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 01/02] RT: add back plist docs
thread-index: AcYGeXLmKiirqEgUTRejbiVV/6WdtQACj6IQ
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Daniel Walker" <dwalker@mvista.com>, <mingo@elte.hu>
Cc: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>, <oleg@tv-sign.ru>
X-OriginalArrivalTime: 21 Dec 2005 23:15:11.0782 (UTC) FILETIME=[647A3C60:01C60684]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Daniel Walker [mailto:dwalker@mvista.com]
>...
>--- linux-2.6.14.orig/include/linux/plist.h
>+++ linux-2.6.14/include/linux/plist.h
>@@ -1,3 +1,79 @@
>+...
>+ * This is a priority-sorted list of nodes; each node has a >= 0
>+ * priority from 0 (highest) to INT_MAX (lowest). The list itself has
>+ * a priority too (the highest of all the nodes), stored in the head
>+ * of the list (that is a node itself).

I don't have access to the real source now, but if the prio
type is an int, we maybe should change that to 'INT_MIN(highest)
to INT_MAX(lowest)', or make the prio an unsigned and range it 
0 to UINT_MAX.

>+ * Addition is O(K), removal is O(1), change of priority of a node is
>+ * O(K) and K is the number of RT priority levels used in the system.
>+ * (1 <= K <= 99)

This comment about K is kind of misleading; if I use the plist for 
things other than scheduling chores, K changes. I'd cite that as an
example, something like:

  ...K is the number of priority levels used. For example, when
  using this list type for real-time task queuing, 1 <= K <= 99.

Thanks,

-- Inaky 

