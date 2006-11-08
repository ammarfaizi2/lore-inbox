Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965920AbWKHPkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965920AbWKHPkW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 10:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965921AbWKHPkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 10:40:21 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51399 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965920AbWKHPkT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 10:40:19 -0500
Subject: S2RAM and PCI quirks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Nov 2006 15:45:05 +0000
Message-Id: <1163000705.23956.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm tracing down a case where suspend to ram/resume from RAM causes
horrible corruption but not immediately. From a PCI dump it appears that
we are not running the PCI quirks again on the S2RAM resume. Is this
actually the case or am I missing something scanning through the code.
If it is the case then we have multiple corruptors lurking because the
PCI config restore doesn't cover the special registers that need poking
in some cases.

Alan

