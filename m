Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbVKXTIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbVKXTIF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 14:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbVKXTIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 14:08:04 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:147 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1751378AbVKXTIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 14:08:01 -0500
Date: Thu, 24 Nov 2005 11:09:08 -0800
From: thockin@hockin.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Gerd Knorr <kraxel@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051124190908.GA2468@hockin.org>
References: <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <20051123165923.GJ20775@brahms.suse.de> <1132783243.13095.17.camel@localhost.localdomain> <20051124131310.GE20775@brahms.suse.de> <m1zmnugom7.fsf@ebiederm.dsl.xmission.com> <20051124133907.GG20775@brahms.suse.de> <1132842847.13095.105.camel@localhost.localdomain> <20051124142200.GH20775@brahms.suse.de> <1132845324.13095.112.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132845324.13095.112.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2005 at 03:15:24PM +0000, Alan Cox wrote:
> The Intel I have looked at generates MCE if the L2/L1/bus parity errors
> but not on a RAM ECC error as that is memory controller not CPU level.
> That usually asserts NMI. Same for most older chips PIII/AMD Athlon etc

Some BIOSes route that into SMI.  The BIOS can then log the error and tell
the OS via the nmi_now bit.  Uggh.
