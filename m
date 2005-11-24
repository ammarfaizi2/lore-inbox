Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbVKXTPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVKXTPH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 14:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbVKXTPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 14:15:07 -0500
Received: from mx1.suse.de ([195.135.220.2]:7350 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750709AbVKXTPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 14:15:04 -0500
Date: Thu, 24 Nov 2005 20:14:46 +0100
From: Andi Kleen <ak@suse.de>
To: thockin@hockin.org
Cc: Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Gerd Knorr <kraxel@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051124191445.GR20775@brahms.suse.de>
References: <20051124131310.GE20775@brahms.suse.de> <m1zmnugom7.fsf@ebiederm.dsl.xmission.com> <20051124133907.GG20775@brahms.suse.de> <1132842847.13095.105.camel@localhost.localdomain> <20051124142200.GH20775@brahms.suse.de> <1132845324.13095.112.camel@localhost.localdomain> <20051124145518.GI20775@brahms.suse.de> <m1psoqgk18.fsf@ebiederm.dsl.xmission.com> <20051124153635.GJ20775@brahms.suse.de> <20051124191207.GB2468@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051124191207.GB2468@hockin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm curious about that too.  Even with k8 you can get down to a
> chip-select, but that doesn't necessarily map to a DIMM in any useful way,
> unless you have some mobo knowledge.  Are we going to need a new BIOS

Yeah that's my problem.

It's not theoretical. We had cases where someone had to go 
through 10+ DIMMs on a big machine in try and error to find
out which one is wrong. Very bad situation.

[Double plus bad if it wasn't actually any of the DIMMs that were
bad, but one of the VRMs on a big Opteron - it causes all the same
symptoms as a bad DIMM :/]

> table to map chip-selects onto DIMMs? :)

I proposed something like that - best with an ASCII string
("First DIMM on the top left corner") But getting such stuff into BIOS 
is difficult and long winded.

-Andi
