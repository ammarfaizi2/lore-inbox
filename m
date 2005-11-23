Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932579AbVKWWSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbVKWWSP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbVKWWSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:18:15 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:11486 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932579AbVKWWSN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:18:13 -0500
Subject: Re: [patch] SMP alternatives
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@suse.de>,
       Gerd Knorr <kraxel@suse.de>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org>
	 <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de>
	 <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de>
	 <437A0649.7010702@suse.de> <437B5A83.8090808@suse.de>
	 <438359D7.7090308@suse.de> <p7364qjjhqx.fsf@verdi.suse.de>
	 <1132764133.7268.51.camel@localhost.localdomain>
	 <20051123163906.GF20775@brahms.suse.de>
	 <1132766489.7268.71.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org>
	 <4384AECC.1030403@zytor.com>
	 <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org>
	 <1132782245.13095.4.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 23 Nov 2005 22:50:22 +0000
Message-Id: <1132786222.13095.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-11-23 at 13:36 -0800, Linus Torvalds wrote:
> > have to add PAT support which we need to do anyway we would get a world
> > where on uniprocessor lock prefix only works on addresse targets we want
> > it to - ie pci_alloc_consistent() pages.
> 
> No. That would be wrong.
> 
> The thing is, "lock" is useless EVEN ON SMP in user space 99% of the time.

Now I see what you are aiming at, yes that makes vast amounts of sense
and since AMD have the "no lock effect" bit for general case maybe they
can


