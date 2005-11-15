Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbVKOQZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbVKOQZv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbVKOQZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:25:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45259 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964833AbVKOQZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:25:50 -0500
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Zachary Amsden <zach@vmware.com>,
       Gerd Knorr <kraxel@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20051115161949.GC1749@redhat.com>
References: <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org>
	 <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de>
	 <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de>
	 <437A0649.7010702@suse.de> <437A0710.4020107@vmware.com>
	 <1132070764.2822.27.camel@laptopd505.fenrus.org>
	 <20051115161041.GA1749@redhat.com> <437A0965.7020909@zytor.com>
	 <20051115161949.GC1749@redhat.com>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 17:25:32 +0100
Message-Id: <1132071933.2822.30.camel@laptopd505.fenrus.org>
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

On Tue, 2005-11-15 at 11:19 -0500, Dave Jones wrote:
> On Tue, Nov 15, 2005 at 08:14:29AM -0800, H. Peter Anvin wrote:
>  > Dave Jones wrote:
>  > >On Tue, Nov 15, 2005 at 05:06:03PM +0100, Arjan van de Ven wrote:
>  > > 
>  > > > > You still need to preserve the originals so that you can patch in 
>  > > both > > directions.  
>  > > > 
>  > > > why do you insist on both directions? That still sounds like real
>  > > > overkill to me.
>  > >
>  > >cpu hotplug going from UP to SMP ? :)
>  > >
>  > 
>  > If you have CPU hotplug enabled, you can run SMP code!
> 
> Sure, but if you boot with 1 CPU, spinlocks get nop'd to emulate UP,
> and on a 'installed a new cpu' hotplug event, they all come back.

the good news is that all hotplugable x86 cpus will have HT or dual core
support.. so you always work in pairs of 2


