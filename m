Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267494AbUH3Ina@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267494AbUH3Ina (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 04:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267497AbUH3Ina
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 04:43:30 -0400
Received: from codepoet.org ([166.70.99.138]:61104 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S267494AbUH3In2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 04:43:28 -0400
Date: Mon, 30 Aug 2004 02:43:27 -0600
From: Erik Andersen <andersen@codepoet.org>
To: William Lee Irwin III <wli@holomorphy.com>,
       "David S. Miller" <davem@davemloft.net>, mmazur@kernel.pl,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.8.1
Message-ID: <20040830084327.GB12963@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@davemloft.net>, mmazur@kernel.pl,
	linux-kernel@vger.kernel.org
References: <200408292232.14446.mmazur@kernel.pl> <20040830062856.GA10475@codepoet.org> <20040830002422.4b634c6c.davem@davemloft.net> <20040830074835.GA12963@codepoet.org> <20040830080757.GD5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040830080757.GD5492@holomorphy.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Aug 30, 2004 at 01:07:57AM -0700, William Lee Irwin III wrote:
> On Mon Aug 30, 2004 at 12:24:22AM -0700, David S. Miller wrote:
> >> It has never been a constant, and any portable piece of
> >> software needs to evaluate it not at compile time.
> >> When I first did the sparc64 port, the biggest source of
> >> portability problems was of the "uses PAGE_SIZE in some way"
> >> nature.
> >> This is a positive change, we should break the build of these
> >> apps and thus get them fixed.
> 
> On Mon, Aug 30, 2004 at 01:48:35AM -0600, Erik Andersen wrote:
> > There is no question that using PAGE_SIZE should be considered
> > harmful.  But this particular change to the linux-libc-headers
> > makes it easy for the common case (bog standard x86) folk to keep
> > using a fixed PAGE_SIZE value, and keep writing crap code which
> > is now _guaranteed_ to blow chunks on mips, x86_64, etc.
> > I think outright removal of PAGE_SIZE from user space may be a
> > much better choice, with some sortof #error perhaps...  Wouldn't
> > it be better for the whole world if people would get errors like
> >     foo.c:10:2: #error "Don't use PAGE_SIZE, use sysconf(_SC_PAGESIZE)"
> > making people actually fix their code?
> 
> In general people #define PAGE_SIZE (getpagesize()) or some such.

Then perhaps the right thing is for linux-libc-headers to always
provide such a define for PAGE_SIZE for _all_ architectures, not
just for those that happen to have variable PAGE_SIZE values.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
