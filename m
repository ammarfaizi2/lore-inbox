Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268652AbUJKCov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268652AbUJKCov (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 22:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268658AbUJKCov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 22:44:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:55176 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268652AbUJKCot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 22:44:49 -0400
Date: Sun, 10 Oct 2004 19:44:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
cc: =?ISO-8859-1?Q?S=E9rgio_Monteiro_Basto?= <sergiomb@netcabo.pt>,
       Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: [BKPATCH] LAPIC fix for 2.6
In-Reply-To: <Pine.LNX.4.58L.0410110132170.4217@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.58.0410101941590.3897@ppc970.osdl.org>
References: <1097429707.30734.21.camel@d845pe>  <Pine.LNX.4.58.0410101044200.3897@ppc970.osdl.org>
  <Pine.LNX.4.58L.0410102000160.4217@blysk.ds.pg.gda.pl> <1097443183.26647.31.camel@darkstar>
 <Pine.LNX.4.58L.0410110132170.4217@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Oct 2004, Maciej W. Rozycki wrote:
> 
>  How about only disabling the APIC if power-management is in use?

No. You cannot test for SMM. Full stop. That's the whole _point_ of SMM. 
It's hidden away.

Why do you care? If you have a machine with this problem, just use the
"lapic" command line. We do NOT default to unsafe values.

>  I don't like the idea of "punishing" good hardware, because something 
> behaves ill out there.

We don't punish good hardware.

We punish _bad_ hardware. The kind of hardware that has a BIOS that has 
disabled the local APIC. 

Try to get your BIOS updated if you want to consider your hardware "good". 
And if the hw vendor doesn't have a fixed BIOS, then don't call it good, 
and use "lapic".

		Linus
