Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263525AbTHXNI5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 09:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263575AbTHXNI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 09:08:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19393 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263569AbTHXNIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 09:08:45 -0400
Date: Sun, 24 Aug 2003 06:00:57 -0700
From: "David S. Miller" <davem@redhat.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: jes@trained-monkey.org, alan@lxorguk.ukuu.org.uk, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
Message-Id: <20030824060057.7b4c0190.davem@redhat.com>
In-Reply-To: <m3n0dz5kfg.fsf@defiant.pm.waw.pl>
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030818111522.A12835@devserv.devel.redhat.com>
	<m33cfyt3x6.fsf@trained-monkey.org>
	<1061298438.30566.29.camel@dhcp23.swansea.linux.org.uk>
	<20030819095547.2bf549e3.davem@redhat.com>
	<m34r0dwfrr.fsf@defiant.pm.waw.pl>
	<m38ypl29i4.fsf@defiant.pm.waw.pl>
	<m3isoo2taz.fsf@trained-monkey.org>
	<m3n0dz5kfg.fsf@defiant.pm.waw.pl>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Aug 2003 14:06:43 +0200
Krzysztof Halasa <khc@pm.waw.pl> wrote:

> The code has to get the mask anyway, either from
> pci_dev->(consistent_)dma_mask or from its arguments.

But it does not have to verify the mask each and every mapping call
currently.  We'll need to do that with your suggested changes.

Nobody is going to agree to any of your proposals at the rate you're
currently going.

> I don't know if there is at least one platform which does it according
> to the docs.

Effectively, the correct effects are obtained on i386, Alpha,
IA64, and sparc for all drivers in the tree.  I can say this because
nobody tries to do anything interesting with consistent_dma_mask
yet, and that is why nobody has any incentive to "fix" it as you
keep complaining we need to do.

See, to show something is broken, you have to show a device that
will break currently.  The consistent_dma_mask is only modified
by tg3, and it does so in such a way that all platforms work properly.
