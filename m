Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbVLMWAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbVLMWAP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbVLMWAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:00:14 -0500
Received: from mail.kroah.org ([69.55.234.183]:18137 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030257AbVLMWAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:00:13 -0500
Date: Tue, 13 Dec 2005 13:59:50 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       davem@davemloft.net, hartge@ds9.argh.org
Subject: [patch 1/2] [SPARC64]: Fix compile error in irq.c
Message-ID: <20051213215950.GB16739@kroah.com>
References: <20051213214109.971735000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sparc64-build-fix.patch"
In-Reply-To: <20051213215936.GA16739@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Sven Hartge <hartge@ds9.argh.org>

irq.c is missing the inclusion of asm/io.h, which causes
readb() and writeb() the be undefined.

Signed-off-by: Sven Hartge <hartge@ds9.argh.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/sparc64/kernel/irq.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.13.4.orig/arch/sparc64/kernel/irq.c
+++ linux-2.6.13.4/arch/sparc64/kernel/irq.c
@@ -27,6 +27,7 @@
 #include <asm/atomic.h>
 #include <asm/system.h>
 #include <asm/irq.h>
+#include <asm/io.h>
 #include <asm/sbus.h>
 #include <asm/iommu.h>
 #include <asm/upa.h>

--
