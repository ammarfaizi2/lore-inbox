Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWDMNuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWDMNuS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 09:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWDMNuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 09:50:17 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:17177
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S964936AbWDMNuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 09:50:16 -0400
Message-Id: <443E734F.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Thu, 13 Apr 2006 15:50:39 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [i386, x86-64] ioapic_register_intr() and assign_irq_vector()
	questions
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since ioapic_register_intr() ties, for the PCI case, the interrupt gate for vector to interrupt[vector], doesn't this,
since do_IRQ() derives the IRQ from the value loaded in the handler at that address (which is the value of vector), mean
that here irq == vector in all cases? If so, why does this function need an if/else (the 'else' case would then be good
for both cases)?

Looking at the call paths assign_irq_vector() can get called from, I would think this function, namely as it's using
static variables, lacks synchronization - is there any (hidden) reason this is not needed here?

Thanks, Jan
