Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVATBJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVATBJw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 20:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbVATBJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 20:09:51 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:51525 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S262016AbVATBJq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 20:09:46 -0500
Date: Thu, 20 Jan 2005 03:06:20 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Chris Wright <chrisw@osdl.org>
Cc: Andi Kleen <ak@muc.de>, akpm@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH 1/5] compat_ioctl call seems to miss a security hook
Message-ID: <20050120010620.GB32105@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050118072133.GB76018@muc.de> <20050118103418.GA23099@mellanox.co.il> <20050118072133.GB76018@muc.de> <20050118104515.GA23127@mellanox.co.il> <20050118112220.X24171@build.pdx.osdl.net> <20050120002806.GA16674@mellanox.co.il> <20050119164353.W24171@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119164353.W24171@build.pdx.osdl.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Chris Wright (chrisw@osdl.org) "Re: [PATCH 1/5] compat_ioctl call seems to miss a security hook":
> * Michael S. Tsirkin (mst@mellanox.co.il) wrote:
> > I'm all for it, but the way the patch below works, we could end up
> > calling ->ioctl or ->unlocked_ioctl from the compat 
> > syscall, and we dont want that.
> 
> Hmm, I didn't actually change how those are called.  So if it's an issue,
> then I don't think this patch introduces it.
> 
> thanks,
> -chris

Sorry, you are right, we go to do_ioctl only if there are no
callbacks.
Patch looks good to go to me.
mst
