Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbTEGC3j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 22:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbTEGC3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 22:29:39 -0400
Received: from cbshost-12-155-143-237.sbcox.net ([12.155.143.237]:30933 "EHLO
	sb-lnx3.rinconnetworks.com") by vger.kernel.org with ESMTP
	id S262703AbTEGC3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 22:29:37 -0400
Date: Tue, 6 May 2003 19:46:47 -0700
From: Paul van Gool <paul.vangool@rinconnetworks.com>
To: linux-kernel@vger.kernel.org
Subject: Typo in arch/sh/kernel/io_7751se.c
Message-ID: <20030507024647.GA6303@rinconnetworks.com>
Reply-To: paul.vangool@rinconnetworks.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

not sure who to send it to. So as suggested in REPORTING-BUGS, I'm sending
it to this mailing list.

While building a kernel for an SH7751 SolutionEngine, I ran into a link
problem using a non-PCI configuration. I tracked the problem back to
arch/sh/kernel/io_7751se.c. On line 304, I see:

#if defined(CONFIG_PCI)
#define CHECK_SH7751_PCIIO(port) \
  ((port >= PCIBIOS_MIN_IO) && (port < (PCIBIOS_MIN_IO + SH7751_PCI_IO_SIZE)))
#else
#define CHECK_SH_7751_PCIIO(port) (0)
#endif

The problem is with the 5th line. It should be:

#define CHECK_SH7751_PCIIO(port) (0)

I removed the '_' between SH and 7751.

If I need to send this somewhere else, please tell me where.

Thanks.

Paul
-- 
Paul van Gool                                               Rincon Networks
paul.vangool@rinconnetworks.com                              (805)-705-1442
