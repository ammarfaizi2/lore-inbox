Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVGYTgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVGYTgd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 15:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVGYTeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 15:34:21 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:40160 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261484AbVGYTeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 15:34:12 -0400
Date: Mon, 25 Jul 2005 23:33:51 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Eric Leblond <eleblond@inl.fr>
Cc: Patrick McHardy <kaber@trash.net>, Andrew Morton <akpm@osdl.org>,
       Harald Welte <laforge@netfilter.org>, netdev@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: Netlink connector
Message-ID: <20050725193351.GB30567@2ka.mipt.ru>
References: <20050723125427.GA11177@rama> <20050723091455.GA12015@2ka.mipt.ru> <20050724.191756.105797967.davem@davemloft.net> <Lynx.SEL.4.62.0507250154000.21934@thoron.boston.redhat.com> <20050725070603.GA28023@2ka.mipt.ru> <42E4F800.1010908@trash.net> <1122302623.29940.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1122302623.29940.20.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 25 Jul 2005 23:33:52 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 04:43:43PM +0200, Eric Leblond (eleblond@inl.fr) wrote:
> Le lundi 25 juillet 2005 à 16:32 +0200, Patrick McHardy a écrit :
> > Evgeniy Polyakov wrote:
> > > On Mon, Jul 25, 2005 at 02:02:10AM -0400, James Morris (jmorris@redhat.com) wrote:
> > If I understand correctly it tries to workaround some netlink
> > limitations (limited number of netlink families and multicast groups)
> > by sending everything to userspace and demultiplexing it there.
> > Same in the other direction, an additional layer on top of netlink
> > does basically the same thing netlink already does. This looks like
> > a step in the wrong direction to me, netlink should instead be fixed
> > to support what is needed.
> 
> I totally agree with you, it could be great to fix netlink to support
> multiple queue.
> I like to be able to use projects like snort-inline or nufw together.
> This will make Netfilter really stronger.
> Furthermore, there's a repetition of filtering capabilities with such a
> solution. Netfilter has to filter to send to netlink and this is the
> same with the queue dispatcher. I think this introduce too much
> complexity.

Netlink is transport protocol - no need to add complexity into it, 
it must be as simple as possible and thus extensible.
Multiple queues and filtering should be created on different layer, like
it is done for TCP/IP and other protocols.
I'm not advertising, but connector is exactly the place where 
it can be implemented.

> my 0.02$
> 
> BR,
> -- 
> Éric Leblond, eleblond@inl.fr
> Téléphone : 01 44 89 46 40, Fax : 01 44 89 45 01
> INL, http://www.inl.fr
> 

-- 
	Evgeniy Polyakov
