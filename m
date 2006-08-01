Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWHAOmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWHAOmK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 10:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWHAOmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 10:42:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46807 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751315AbWHAOmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 10:42:08 -0400
Date: Tue, 1 Aug 2006 07:41:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>,
       Jan Beulich <jbeulich@novell.com>
Cc: ak@suse.de, mingo@elte.hu, arjan@infradead.org, Matt_Domsch@dell.com,
       davem@davemloft.net, yoshfuji@linux-ipv6.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [IPV6]: Audit all ip6_dst_lookup/ip6_dst_store calls
Message-Id: <20060801074133.b5b96f11.akpm@osdl.org>
In-Reply-To: <20060731090433.GA25192@gondor.apana.org.au>
References: <20060728194531.GA17744@lists.us.dell.com>
	<20060729043325.GA7035@gondor.apana.org.au>
	<20060730.154416.121293840.davem@davemloft.net>
	<20060731033210.GD31083@humbolt.us.dell.com>
	<20060731090433.GA25192@gondor.apana.org.au>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 19:04:33 +1000
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> 2) There is something broken in the x86_64 unwind code which is causing
> it to panic just about everytime somebody calls dump_stack().
> 
> Andi, this is the second time I've seen a report where an otherwise
> harmless dump_stack call (the other one was caused by a WARN_ON) gets
> turned into a panic by the stack unwind code on x86_64.  This particular
> report is with 2.6.18-rc3 so it looks like whatever bug is causing it
> hasn't been fixed yet.
> 
> Could you please have a look at it? Thanks.

Jan thinks this might have been fixed by a patch which he sent Andi a
couple of days ago.  Andi has sent that patch to Linus but I'm not sure
which patch it was and I'm not sure whether it has been merged into
mainline.

But yes, -rc3 unwind has problems.
