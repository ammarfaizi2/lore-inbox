Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262461AbUKVXpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbUKVXpN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 18:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUKVXor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 18:44:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:62660 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262461AbUKVXj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 18:39:29 -0500
Date: Mon, 22 Nov 2004 15:43:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: hirofumi@mail.parknet.co.jp, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] problem of cont_prepare_write()
Message-Id: <20041122154325.4d8e53ef.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.60.0411222324150.27573@hermes-1.csi.cam.ac.uk>
References: <877joexjk5.fsf@devron.myhome.or.jp>
	<20041122024654.37eb5f3d.akpm@osdl.org>
	<1101121403.18623.10.camel@imp.csi.cam.ac.uk>
	<20041122135354.38feab51.akpm@osdl.org>
	<Pine.LNX.4.60.0411222324150.27573@hermes-1.csi.cam.ac.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk> wrote:
>
> I always have a flush_dcache_page(page) between the memset() and 
> the SetPageUptodate() so I don't need the barrier, right?  Or does the 
> flush_dcache_page() not imply ordering?

err, flush_dcache_page() might indeed provide a write barrier on all
architectures which need write barriers.  Then again it might not ;) It's
not intended that this be the case.
