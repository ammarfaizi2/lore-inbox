Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267870AbUHPSpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267870AbUHPSpT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 14:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267863AbUHPSpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 14:45:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31467 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267859AbUHPSn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 14:43:56 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16672.65520.41118.283666@segfault.boston.redhat.com>
Date: Mon, 16 Aug 2004 14:41:52 -0400
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, Stelian Pop <stelian@popies.net>,
       jgarzik@pobox.com
Subject: Re: [patch] fix netconsole hang with alt-sysrq-t
In-Reply-To: <20040813002931.GH16310@waste.org>
References: <16659.56343.686372.724218@segfault.boston.redhat.com>
	<20040806195237.GC16310@waste.org>
	<16659.58271.979999.616045@segfault.boston.redhat.com>
	<20040806202649.GE16310@waste.org>
	<16667.55966.317888.504243@segfault.boston.redhat.com>
	<20040813002931.GH16310@waste.org>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: [patch] fix netconsole hang with alt-sysrq-t; Matt Mackall <mpm@selenic.com> adds:

mpm> On Thu, Aug 12, 2004 at 05:01:18PM -0400, Jeff Moyer wrote:
>> ==> Regarding Re: [patch] fix netconsole hang with alt-sysrq-t; Matt
>> Mackall <mpm@selenic.com> adds:
>> 
mpm> On Fri, Aug 06, 2004 at 04:01:35PM -0400, Jeff Moyer wrote:
>> >> ==> Regarding Re: [patch] fix netconsole hang with alt-sysrq-t; Matt
>> >> Mackall <mpm@selenic.com> adds:
>> >> 
mpm> On Fri, Aug 06, 2004 at 03:29:27PM -0400, Jeff Moyer wrote:
>> >> >> Hi, Matt,
>> >> >> 
>> >> >> Here's the patch.  Sorry it took me so long, been busy with other
>> >> work.  >> Two things which need perhaps more thinking, can
>> netpoll_poll >> be called >> recursively (it didn't look like it to me)
>> >> 
mpm> It can if the poll function does a printk or the like and wants to
mpm> recurse via netconsole. We could short-circuit that with an in_netpoll
mpm> flag, but let's worry about that separately.

mpm> We've got about 5 different issues in this thread/patch, and they need
mpm> to be broken up. I was going to do this, but I'm moving to another
mpm> city in 4 days. Jeff, if you'd be so kind (otherwise I'll get to it in
mpm> about a week and a half):

I'm all for splitting out patches.  However, I think this is a bit too fine
grained.  I'll separate out what makes sense to me.  If you want it split
out further, let me know and I'll see what I can do.  I'll send out the
patches in a short while.

-Jeff
