Return-Path: <linux-kernel-owner+w=401wt.eu-S965079AbWLMTIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbWLMTIB (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965081AbWLMTIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:08:01 -0500
Received: from smtp.osdl.org ([65.172.181.25]:59502 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965079AbWLMTIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:08:00 -0500
Date: Wed, 13 Dec 2006 11:07:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Suleiman Souhlal <ssouhlal@FreeBSD.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
       balbir@in.ibm.com, csturtiv@sgi.com, daw@sgi.com,
       guillaume.thouvenin@bull.net, jlan@sgi.com, nagar@watson.ibm.com,
       tee@sgi.com
Subject: Re: [patch 03/13] io-accounting: write accounting
Message-Id: <20061213110701.37300a1e.akpm@osdl.org>
In-Reply-To: <457FDDCE.7010303@FreeBSD.org>
References: <200612081152.kB8BqQvb019756@shell0.pdx.osdl.net>
	<457FBDBE.10102@FreeBSD.org>
	<20061213005954.e2d32446.akpm@osdl.org>
	<457FD777.9040703@FreeBSD.org>
	<457FDDCE.7010303@FreeBSD.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 03:02:38 -0800
Suleiman Souhlal <ssouhlal@FreeBSD.org> wrote:

> The only I/O non-shared VMAs might cause is from swapping, and I'm not
> sure if the io accounting patches actually care about that.

Yes, the patches do attempt to correctly account for swap IO.  swapin is
accounted in submit_bio() and swapout is, err, not accounted at all.  Drat,
I forgot to retest that.


