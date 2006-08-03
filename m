Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbWHCTkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWHCTkd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 15:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbWHCTkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 15:40:32 -0400
Received: from ccerelbas02.cce.hp.com ([161.114.21.105]:44243 "EHLO
	ccerelbas02.cce.hp.com") by vger.kernel.org with ESMTP
	id S1030213AbWHCTkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 15:40:31 -0400
Date: Thu, 3 Aug 2006 12:40:19 -0700
To: Dave Jones <davej@redhat.com>
Cc: netdev@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       davem@davemloft.net, linville@tuxdriver.com
Subject: Re: orinoco driver causes *lots* of lockdep spew
Message-ID: <20060803194019.GA12152@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <1154607380.2965.25.camel@laptopd505.fenrus.org> <E1G8der-0001fm-00@gondolin.me.apana.org.au> <20060803141153.GB20405@infradead.org> <20060803185800.GB12062@bougret.hpl.hp.com> <20060803185958.GC11577@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803185958.GC11577@redhat.com>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 02:59:58PM -0400, Dave Jones wrote:
> On Thu, Aug 03, 2006 at 11:58:00AM -0700, Jean Tourrilhes wrote:
>  > On Thu, Aug 03, 2006 at 03:11:53PM +0100, Christoph Hellwig wrote:
>  > > On Thu, Aug 03, 2006 at 11:54:41PM +1000, Herbert Xu wrote:
>  > > > Arjan van de Ven <arjan@infradead.org> wrote:
>  > > > > 
>  > > > > this is another one of those nasty buggers;
>  > > > 
>  > > > Good catch.  It's really time that we fix this properly rather than
>  > > > adding more kludges to the core code.
>  > > > 
>  > > > Dave, once this goes in you can revert the previous netlink workaround
>  > > > that added the _bh suffix.
>  > > > 
>  > > > [WIRELESS]: Send wireless netlink events with a clean slate
>  > > 
>  > > Could we please just get rid of the wireless extensions over netlink code
>  > > again?  It doesn't help to solve anything and just creates a bigger mess
>  > > to untangle when switching to a fully fledged wireless stack.
>  > 
>  > 	That's not going to happen any time soon, NetworkManager
>  > depends on Wireless Events, as well as many other apps. And there is
>  > not many mechanisms you can use in the kernel to generate events from
>  > driver to userspace.
> 
> It seemed to cope pretty well before we had this ?

	Wireless Events were introduced in kernel 2.4.20 and 2.5.7,
which means 2002. NetworkManager and WPA Supplicant were based from
the very start on the availability of Wireless Events.
	You are confusing different things...

> 		Dave

	Have fun...

	Jean

P.S. : By the way, don't ask me why it took four years for this bug to
get discovered...
