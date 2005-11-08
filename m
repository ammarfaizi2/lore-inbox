Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965160AbVKHNYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbVKHNYg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 08:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbVKHNYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 08:24:36 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:60645 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965160AbVKHNYf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 08:24:35 -0500
Subject: Re: [PATCH 14/21] i386 Apm is on cpu zero only
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zachary Amsden <zach@vmware.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <43709FD7.1030905@vmware.com>
References: <200511080433.jA84Xwm7009921@zach-dev.vmware.com>
	 <20051108073315.GE28201@elte.hu>  <43709FD7.1030905@vmware.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Nov 2005 13:54:51 +0000
Message-Id: <1131458091.25192.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-08 at 04:53 -0800, Zachary Amsden wrote:
> Can't hurt, and APM is largely obsolete because of ACPI, so I'm only 
> concerned with trimming and keeping adequate protection of the kernel 
> from APM code while maintaining correctness.  I don't have a nice set of 
> old machines with enough wacky APM BIOSen to validate that unpinning the 
> CPU is ok.

A large number of SMP machines, probably the majority of APM based ones
require that APM calls occur on CPU#0. As I understand it from a BIOS
engineer involved in debugging that problem Redmond always does APM from
CPU #0 and may even guarantee it.

Alan

