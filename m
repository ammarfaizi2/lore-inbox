Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262948AbVAFUv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbVAFUv4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 15:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVAFUtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 15:49:05 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:52098 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263032AbVAFUoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 15:44:38 -0500
Date: Thu, 6 Jan 2005 21:44:31 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andi Kleen <ak@suse.de>, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net, vandrove@vc.cvut.cz,
       mst@mellanox.co.il, akpm@osdl.org, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [PATCH] macros to detect existance of unlocked_ioctl and ioctl_compat
Message-ID: <20050106204431.GH28889@wotan.suse.de>
References: <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il> <20050106145356.GA18725@infradead.org> <20050106163559.GG5772@vana.vc.cvut.cz> <20050106165715.GH1830@wotan.suse.de> <20050106172613.GI5772@vana.vc.cvut.cz> <20050106175342.GA28889@wotan.suse.de> <20050106193520.GA5481@kroah.com> <20050106195144.GE28889@wotan.suse.de> <20050106115959.45d793e1.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106115959.45d793e1.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 11:59:59AM -0800, David S. Miller wrote:
> On Thu, 6 Jan 2005 20:51:44 +0100
> Andi Kleen <ak@suse.de> wrote:
> 
> > DaveM can probably give you more details since he tried unsucessfully
> > to make it work. I think the problem is that there is no enough
> > information for the compat layer to convert everything.
> 
> When the usbfs async stuff writes back the status, we are no
> longer within the original syscall/ioctl execution any more,
> therefore we don't know if we're doing this for a compat task
> or not.

[...]

Thanks Dave for the update. I misremembered and I don't think
I can fix this up for x86-64.  We'll need a new interface of some sort.

-Andi
