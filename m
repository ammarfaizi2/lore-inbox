Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbVIOJu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbVIOJu5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 05:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbVIOJu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 05:50:57 -0400
Received: from pat.uio.no ([129.240.130.16]:48796 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932425AbVIOJu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 05:50:56 -0400
Subject: Re: Bug#328135: kernel-image-2.6.11-1-686-smp: nfs reading process
	stuck in disk wait
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Horms <horms@debian.org>
Cc: Marc Horowitz <marc@mit.edu>, 328135@bugs.debian.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050915092246.GE25382@verge.net.au>
References: <20050913194707.8C8C28E6F0@ayer.connecterra.net>
	 <20050914025150.GR27828@verge.net.au>
	 <1126742335.8807.74.camel@lade.trondhjem.org>
	 <t533bo75e6t.fsf@central-air-conditioning.toybox.cambridge.ma.us>
	 <1126773168.12556.13.camel@lade.trondhjem.org>
	 <20050915092246.GE25382@verge.net.au>
Content-Type: text/plain
Date: Thu, 15 Sep 2005 10:44:39 +0100
Message-Id: <1126777479.12556.55.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.718, required 12,
	autolearn=disabled, AWL 0.63, RCVD_IN_NJABL_DUL 1.66,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 15.09.2005 Klokka 18:22 (+0900) skreiv Horms:
> I take it from your initial remarks that the use of sync_page()
> in the VSF has changed recently. And in any case, it would
> be worth testing 2.6.12 or 2.6.13 before investigating any further
> as in your oppinion the problem is not NFS related, but related
> to somthing that NFS coincidently triggers (but could just as
> easily triggered by anything else).

Right. What I'm saying is that NFS has no special hooks inside
lock_page(), so this is 100% generic VFS code.

Cheers,
  Trond

