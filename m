Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbTERUEb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 16:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbTERUEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 16:04:31 -0400
Received: from palrel13.hp.com ([156.153.255.238]:13707 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262185AbTERUEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 16:04:30 -0400
Date: Sun, 18 May 2003 13:17:18 -0700
From: Grant Grundler <iod00d@hp.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, "David S. Miller" <davem@redhat.com>,
       Jes Sorensen <jes@wildopensource.com>, torvalds@transmeta.com,
       cngam@sgi.com, jeremy@sgi.com,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-ia64@linuxia64.org,
       wildos@sgi.com
Subject: Re: [Linux-ia64] Re: [patch] support 64 bit pci_alloc_consistent
Message-ID: <20030518201718.GB13855@cup.hp.com>
References: <16071.1892.811622.257847@trained-monkey.org> <1053250142.1300.8.camel@laptop.fenrus.com> <20030518.023533.98888328.davem@redhat.com> <20030518094341.A1709@devserv.devel.redhat.com> <20030518172203.GA13855@cup.hp.com> <1053280195.10810.61.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053280195.10810.61.camel@mulgrave>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 18, 2003 at 12:49:49PM -0500, James Bottomley wrote:
> In that case, the platform returns zero to "this much" being less than
> the full 64 bits implying there's no mask the platform and driver can
> agree on.

My point was it's better if the driver always check the return
value regardless of which interface is ultimately agreed upon.
(in reference to whether "no one cares a flying fish".)

If one accepts that requirement, the only improvement in Arjen's proposal
is the platform DMA support can guess what might be better and make that
the "effective" mask.  The driver still needs to check the effective mask.
I happen to agree with davem : redefining this interface in 2.5 for
a trivial improvement doesn't seem reasonable at this point.

a swimming fish,
grant
