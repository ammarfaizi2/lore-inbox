Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVKMVBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVKMVBP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 16:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbVKMVBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 16:01:14 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:14552 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750701AbVKMVBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 16:01:14 -0500
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.64.0511131130370.3263@g5.osdl.org>
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>
	 <p734q6g4xuc.fsf@verdi.suse.de>
	 <1131902775.25311.16.camel@localhost.localdomain>
	 <200511132000.45836.ak@suse.de>
	 <1131910902.25311.21.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0511131130370.3263@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 13 Nov 2005 21:32:10 +0000
Message-Id: <1131917530.25311.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-11-13 at 11:36 -0800, Linus Torvalds wrote:
> The thing is, we wouldn't ever remove _all_ lock prefixes. Only the ones 
> that already depend on SMP.
> 
> So the memory barriers etc that have lock prefixes even on UP would be 
> totally untouched.

That much makes sense. Having some magic MSR reloaded to turn lock
effects off is a bit more of a problem for ECC scrubbing however.

