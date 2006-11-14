Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965767AbWKNNkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965767AbWKNNkx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 08:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965757AbWKNNkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 08:40:53 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:51367 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S965767AbWKNNkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 08:40:52 -0500
From: Arnaud Giersch <arnaud.giersch@free.fr>
To: philb@gnu.org, tim@cyberelk.net, andrea@suse.de
Cc: linux-parport@lists.infradead.org, trivial@kernel.org,
       linux-kernel@vger.kernel.org
Subject: [TRIVIAL] parport: fix compilation failure
Date: Tue, 14 Nov 2006 14:40:48 +0100
Message-ID: <87k61y9me7.fsf@groumpf.homeip.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix compilation failure.

Signed-off-by: Arnaud Giersch <arnaud.giersch@free.fr>

---

 drivers/parport/parport_ip32.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/parport/parport_ip32.c b/drivers/parport/parport_ip32.c
index e3e1927..ec44efd 100644
--- a/drivers/parport/parport_ip32.c
+++ b/drivers/parport/parport_ip32.c
@@ -780,7 +780,7 @@ static irqreturn_t parport_ip32_interrup
 	enum parport_ip32_irq_mode irq_mode = priv->irq_mode;
 	switch (irq_mode) {
 	case PARPORT_IP32_IRQ_FWD:
-		parport_generic_irq(irq, p, regs);
+		parport_generic_irq(irq, p);
 		break;
 	case PARPORT_IP32_IRQ_HERE:
 		parport_ip32_wakeup(p);
