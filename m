Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbVKOIIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbVKOIIX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 03:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbVKOIIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 03:08:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:29097 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751368AbVKOIIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 03:08:23 -0500
Subject: Re: + perfmon2-reserve-system-calls.patch added to -mm tree
From: Arjan van de Ven <arjan@infradead.org>
To: eranian@hpl.hp.com
Cc: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
       linux-kernel@vger.kernel.org, ak@muc.de, benh@kernel.crashing.org,
       paulus@samba.org, stephane.eranian@hp.com, tony.luck@intel.com
In-Reply-To: <20051115080055.GA24236@frankl.hpl.hp.com>
References: <200511142329.jAENTfmS004600@shell0.pdx.osdl.net>
	 <200511150050.27556.arnd@arndb.de> <20051114171226.680cddc8.akpm@osdl.org>
	 <20051115080055.GA24236@frankl.hpl.hp.com>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 09:08:08 +0100
Message-Id: <1132042089.2822.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > d) Some architectures have multiple syscall tables.  Stephane, you
> >    missed arch/ia64/ia32/ia32_entry.S, for example.  But then, that looks
> >    to be seriously out of date anyway.  No idea what's going on there.
> > 
> 
> This one corresponds to the system call table for X86 binaries running
> on Linux/ia64. This is used in combination with the hardware emulation
> in the processor. This is being replaced by full user level translation
> by Intel's IA32el libraries. The x86 binary is translated to IA-64 native
> code in user mode and then it makes IA-64 system calls. As such, the IA-32
> syscall emulation table is becoming obsolete as people upgrade to newer 
> Linux distributions using IA32el. Tony correct me if I missed something.

... which is a binary only, proprietary application.

Either way, either the emulation is in the kernel or it's not. If it's
there (like it is now) it deserves maintenance. If it's not, it should
be removed from the tree, since the only thing it's otherwise good for
is potential security holes.

