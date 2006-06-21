Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbWFUWVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWFUWVm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 18:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWFUWVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 18:21:42 -0400
Received: from cantor.suse.de ([195.135.220.2]:27081 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751493AbWFUWVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 18:21:41 -0400
From: Andi Kleen <ak@suse.de>
To: rohitseth@google.com
Subject: Re: [RFC, patch] i386: vgetcpu(), take 2
Date: Thu, 22 Jun 2006 00:21:21 +0200
User-Agent: KMail/1.9.3
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
References: <200606210329_MC3-1-C305-E008@compuserve.com> <p73zmg6oo5t.fsf@verdi.suse.de> <1150926882.6885.32.camel@galaxy.corp.google.com>
In-Reply-To: <1150926882.6885.32.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606220021.21657.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Can we use similar  mechanism to access pda in vsyscall in x86_64 (by
> storing the address of pda there).  


You mean in the kernel? %gs prefix is a lot faster than this.

Also the limit is only 20bit, not enough for a full address.

For user space it's useful though, but I don't see any immediate uses
other than cpu number and node number. For most purposes glibc TLS
(which uses %fs) is probably sufficient.

-Andi
