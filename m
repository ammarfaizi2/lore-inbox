Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270510AbTHRGhQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 02:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271278AbTHRGhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 02:37:16 -0400
Received: from rth.ninka.net ([216.101.162.244]:44420 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S270510AbTHRGhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 02:37:15 -0400
Date: Sun, 17 Aug 2003 23:37:05 -0700
From: "David S. Miller" <davem@redhat.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
Message-Id: <20030817233705.0bea9736.davem@redhat.com>
In-Reply-To: <m3oeynykuu.fsf@defiant.pm.waw.pl>
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Aug 2003 00:34:17 +0200
Krzysztof Halasa <khc@pm.waw.pl> wrote:

> The consistent_dma_mask (and set_... function) is presumably a hack
> which is currently not used by anything (at least in the official tree).
> It's unneeded (it can be easily done in a driver, should a need arrive,
> without polluting the PCI subsystem) and is not supported by "DMA" API.

ia64 does in fact need consistent_dma_mask.

> It isn't even implemented on most platforms - only x86_64 and ia64 have
> support for it, while on the remaining archs using it according to the
> docs (with non-default value) could mean Oops or something like that.

The platforms where it isn't implemented simply support
it identically to how they support the normal dma_mask.

Please read the threads in the archives that caused
consistent_dma_mask to be added to the tree in the first
place before you go around removing it.

Thanks.
