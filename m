Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265022AbUELAcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265022AbUELAcE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 20:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbUELA2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 20:28:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:62398 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263173AbUELAYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 20:24:47 -0400
Date: Tue, 11 May 2004 17:26:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: marcus@tuells.org, linux-kernel@vger.kernel.org
Subject: Re: Block device swamping disk cache
Message-Id: <20040511172643.36df7c94.akpm@osdl.org>
In-Reply-To: <20040511201936.A19384@infradead.org>
References: <20040511191124.GA16014@bastille.tuells.org>
	<20040511201936.A19384@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, May 11, 2004 at 01:11:24PM -0600, marcus hall wrote:
> > I am having problems writing a filesystem image to a device file.
> > 
> > I am running an arm version of the 2.5.59 kernel.
> 
> I don't think anyone here still remembers stoneage-aera kernels.
> 
> You're better off trying to reproduce it with 2.6.6 I guess.

no, sorry, it'll still happen.  I haven't fixed the ramdisk driver yet.

The problem is that ->memory_backed means both "doesn't contribute
to dirty memory" and also "doesn't need writeback".

These concepts need to be split apart for the ramdisk driver.  I'll do it
for 2.6.7, promise.
