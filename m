Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268342AbUJTItn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268342AbUJTItn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 04:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270026AbUJTIrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 04:47:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:31902 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S270067AbUJTIoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 04:44:13 -0400
Subject: New consolidate irqs vs . probe_irq_*()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Anton Blanchard <anton@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20041020083358.GB23396@elte.hu>
References: <16758.3807.954319.110353@cargo.ozlabs.ibm.com>
	 <20041020083358.GB23396@elte.hu>
Content-Type: text/plain
Message-Id: <1098261745.6263.9.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 18:42:26 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo, while we are at it,

Do you have any objection if I send a patch making the whole probe_irq_*
stuff optional on a CONFIG_ option ? (turning it into nops like we used
to have on ppc until now, if the option isn't set).

I really don't want to mess with that racy mecanism that makes sense for
ISA only afaik, and it seems some drivers are trying to use it now that
it's there (/me looks toward yenta_socket) and I'm afraid of the
consequences since I cannot see how that thing can work properly in the
first place ;)

Ben.


