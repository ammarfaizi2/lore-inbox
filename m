Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbTJPEvz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 00:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbTJPEvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 00:51:55 -0400
Received: from rth.ninka.net ([216.101.162.244]:55682 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S262690AbTJPEvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 00:51:54 -0400
Date: Wed, 15 Oct 2003 21:51:34 -0700
From: "David S. Miller" <davem@redhat.com>
To: <mika.penttila@kolumbus.fi>
Cc: herbert@gondor.apana.org.au, torvalds@osdl.org, hch@infradead.org,
       axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [SCSI] Set max_phys_segments to sg_tablesize
Message-Id: <20031015215134.6f5a0479.davem@redhat.com>
In-Reply-To: <20031015123722.CSSJ7495.fep07-app.kolumbus.fi@mta.imail.kolumbus.fi>
References: <20031015123722.CSSJ7495.fep07-app.kolumbus.fi@mta.imail.kolumbus.fi>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Oct 2003 15:37:22 +0300
<mika.penttila@kolumbus.fi> wrote:

> >It does matter if the driver can't cope with it.
> 
> But this fix may hurt performance with well behaving drivers in
> iommu systems. It's better to fix the broken drivers I think. 

That's absolutely correct.

If you add Herbert's change, you will effectively turn off all
of the IOMMU coalescing benefits we designed into the block layer.
Please don't apply it, fix the broken drivers instead.
