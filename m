Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbTFJIT1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 04:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbTFJIT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 04:19:27 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:51415 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S262451AbTFJIT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 04:19:27 -0400
Subject: IDE IRQ probe brokenness.
From: David Woodhouse <dwmw2@infradead.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1055233984.29633.56.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Tue, 10 Jun 2003 09:33:04 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have on my desk a machine where all PCI interrupts are routed to 
IRQ 0.

The IDE code doesn't seem very happy with it -- it seems to think that
hwif->irq == 0 means that no IRQ has been set. It should be using -1 for
that instead.

This error is in both 2.4 and 2.5.

-- 
dwmw2

