Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264793AbTIDH1r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 03:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264787AbTIDH1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 03:27:38 -0400
Received: from rth.ninka.net ([216.101.162.244]:63688 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264784AbTIDHZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 03:25:49 -0400
Date: Thu, 4 Sep 2003 00:25:41 -0700
From: "David S. Miller" <davem@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: paulus@samba.org, hch@lst.de, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-Id: <20030904002541.12ae4fa5.davem@redhat.com>
In-Reply-To: <20030904071334.GA14426@lst.de>
References: <20030903203231.GA8772@lst.de>
	<16214.34933.827653.37614@nanango.paulus.ozlabs.org>
	<20030904071334.GA14426@lst.de>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003 09:13:34 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Sep 04, 2003 at 10:33:57AM +1000, Paul Mackerras wrote:
> > I don't see why this is a problem.  The change is compatible with the
> > existing uses.  We need to be able to map 36-bit physical addresses on
> > 44x.  What we really need now is 64-bit start/end values in struct
> > resource.
> 
> Then add the phys_addr_t to all places where we deal with physical
> addresses, even if it's typedef'ed to unsigned long on all other
> arches and sane ppcs.

Or do what I do on sparc32, stick the >32bit part in the unused
bits of the resource flags.  It works perfectly fine.
