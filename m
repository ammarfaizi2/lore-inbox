Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbULAVQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbULAVQy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 16:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbULAVQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 16:16:54 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:51370 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261450AbULAVQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 16:16:52 -0500
Date: Wed, 1 Dec 2004 22:16:38 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: tglx@linutronix.de
Cc: akpm@osdl.org, marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041201211638.GB4530@dualathlon.random>
References: <20041201104820.1.patchmail@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041201104820.1.patchmail@tglx>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2004 at 10:49:03AM +0100, tglx@linutronix.de wrote:
> It gets invoked multiple times [..]

You didn't move the invocation in page_alloc.c which is the major bug I
can see (besides the other hacks in oom_kill.c). I'd try fixing the
major bug first.
