Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269396AbUJLA40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269396AbUJLA40 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 20:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269342AbUJLAyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 20:54:41 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:27373 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S269403AbUJLAuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:50:14 -0400
Date: Tue, 12 Oct 2004 02:51:05 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Hui Huang <Hui.Huang@Sun.COM>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: heap-stack-gap for 2.6
Message-ID: <20041012005105.GC17372@dualathlon.random>
References: <20040925162252.GN3309@dualathlon.random> <415903E4.1030808@sun.com> <20040928141914.GE2412@dualathlon.random> <415A7564.2090909@sun.com> <20040929142325.GK4084@dualathlon.random> <415B30A9.5030103@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415B30A9.5030103@sun.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 03:01:13PM -0700, Hui Huang wrote:
> >	if (likely(per_process_setting < 0))
> >		return global_sysctl;
> >	else
> >		return per_process_setting;
> 
> 
> Sounds good.

here we go, please review (the overflow checks are the only ones really
worth reviewing since they're exploitable if not correct):

	http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.9-rc4/heap-stack-gap

Andrew, could you merge it in mainline after 2.6.9 is out?

Thanks!
