Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268742AbUIQNbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268742AbUIQNbd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 09:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268746AbUIQNbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 09:31:33 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:21226 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S268742AbUIQNbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 09:31:06 -0400
Date: Fri, 17 Sep 2004 15:26:41 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
Message-ID: <20040917132641.GR15426@dualathlon.random>
References: <20040915151815.GA30138@elte.hu> <20040917103945.GA19861@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040917103945.GA19861@elte.hu>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 12:39:45PM +0200, Ingo Molnar wrote:
> task not migrating to another CPU within the BLK critical section?

I very much doubt, I'd expect this to work, but it really should be a
config option if you don't open 2.7. This is the kind of thing that
cannot happen in a 2.6.* release without a config option to leave off in
production IMHO since it can have implications well outside the mainline
kernel (every driver outside the kernel would be affected too).
