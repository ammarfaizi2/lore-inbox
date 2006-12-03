Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936615AbWLCChj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936615AbWLCChj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 21:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936616AbWLCChj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 21:37:39 -0500
Received: from pat.uio.no ([129.240.10.15]:23941 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S936615AbWLCChi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 21:37:38 -0500
Subject: Re: Mounting NFS root FS
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Willy Tarreau <w@1wt.eu>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       William Estrada <MrUmunhum@popdial.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20061202225528.GA27342@1wt.eu>
References: <4571CE06.4040800@popdial.com>
	 <Pine.LNX.4.61.0612022006170.25553@yvahk01.tjqt.qr>
	 <20061202211522.GB24090@1wt.eu>
	 <Pine.LNX.4.61.0612022253280.25553@yvahk01.tjqt.qr>
	 <20061202225528.GA27342@1wt.eu>
Content-Type: text/plain
Date: Sat, 02 Dec 2006 21:37:18 -0500
Message-Id: <1165113438.5698.5.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.735, required 12,
	autolearn=disabled, AWL 2.13, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-02 at 23:55 +0100, Willy Tarreau wrote:
> I'm not saying initramfs is not powerful, and indeed your example is
> the common way of parsing cmdline for me too. What I'm saying is that
> before nfsroot stops being supported, we'll need a working replacement
> (and not "### further parse $arg"), if possible within the kernel tree
> so that people who used to build kernels to boot such machines will
> still be able to build kernels for them, even if this implies using
> an initramfs with some tools in it.
> 
> The real danger of removing support for in-kernel features like this
> is to leave people with no solution at all (because they don't know
> how to proceed), and their workarounds are often worse than the
> problem that we tried to fix in the first place.

It hasn't been removed yet. However most distributions choose not to
enable it because that would force them to compile the NFS client into
the main kernel instead of leaving it as a module.

As for the initramfs support, hpa has assured me that his klibc
distribution already has a full solution for NFS mounting on current
kernels.

Trond

