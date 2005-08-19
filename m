Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbVHSH1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbVHSH1I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 03:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbVHSH1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 03:27:08 -0400
Received: from ozlabs.org ([203.10.76.45]:45961 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964882AbVHSH1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 03:27:07 -0400
Subject: Re: [PATCH/RFT 4/5] CLOCK-Pro page replacement
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: davem@davemloft.net, riel@redhat.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050819001030.52ec1364.akpm@osdl.org>
References: <20050817173818.098462b5.akpm@osdl.org>
	 <20050817.194822.92757361.davem@davemloft.net>
	 <20050817210532.54ace193.akpm@osdl.org>
	 <20050817.214845.120320066.davem@davemloft.net>
	 <1124435027.23757.0.camel@localhost.localdomain>
	 <20050819001030.52ec1364.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 19 Aug 2005 17:27:06 +1000
Message-Id: <1124436426.23757.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-19 at 00:10 -0700, Andrew Morton wrote:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> > I believe we just ignored sparc64.  That usually works for solving these
> > kind of bugs. 8)
> 
> heh.  iirc, it was demonstrable on x86 also.

No.  gcc-2.95 on Sparc64 put uninititialized vars into the bss, ignoring
the __attribute__((section(".data.percpu"))) directive.  x86 certainly
doesn't have this, I just tested it w/2.95.

Really, it's Sparc64 + gcc-2.95.  Send an urgent telegram to the user
telling them to upgrade.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

