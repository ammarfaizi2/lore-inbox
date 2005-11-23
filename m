Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030426AbVKWWdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbVKWWdE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030428AbVKWWdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:33:02 -0500
Received: from mail.suse.de ([195.135.220.2]:16031 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030426AbVKWWdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:33:00 -0500
Date: Wed, 23 Nov 2005 23:32:53 +0100
From: Andi Kleen <ak@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051123223253.GX20775@brahms.suse.de>
References: <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051123214344.GU20775@brahms.suse.de> <Pine.LNX.4.64.0511231413530.13959@g5.osdl.org> <20051123222212.GV20775@brahms.suse.de> <4384EC68.1060302@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4384EC68.1060302@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, with VTX or Pacifica virtualization is in ring 3.  The fact that 

Not it's not. The whole point is that there is no "ring compression" 
The guest has all its normal rings, just the hypervisor has additional
"negative" rings.

In the current Xen x86-64 para virtualization setup the guest kernel
is in ring 3, but I hope VT/P. will do away with that because it
causes lots of issues.

> What you really want is one bit for kernel mode (cpl 0-2) and one for 
> user mode (cpl 3).

Yes.

-Andi
