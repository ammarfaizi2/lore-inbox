Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272235AbTHRSpC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 14:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272236AbTHRSpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 14:45:02 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:10459 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S272235AbTHRSo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 14:44:59 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030817233705.0bea9736.davem@redhat.com>
	<m3r83jyw2k.fsf@defiant.pm.waw.pl>
	<20030818054341.2ef07799.davem@redhat.com>
	<m365kvufjx.fsf@defiant.pm.waw.pl>
	<20030818094955.3aa5c1c2.davem@redhat.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 18 Aug 2003 20:21:48 +0200
In-Reply-To: <20030818094955.3aa5c1c2.davem@redhat.com>
Message-ID: <m3d6f2kern.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> > No. The documentation states that consistent_dma_mask (and not dma_mask)
> > will be used when doing pci_alloc_consistent().
> 
> Then the platforms need to implement the code.

There is no problem with that, i.e. the changes are trivial (except
for pci_map_*, but that's another story).

I don't know if it wouldn't break something, though. x86-64 and ia64
are much less tested than i386 and the change would alter i386
behaviour to that of x86-64/ia64.

Again: which driver uses the consistent_dma_mask and where I can find it?
-- 
Krzysztof Halasa
Network Administrator
