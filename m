Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbVLFMTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbVLFMTe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 07:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbVLFMTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 07:19:33 -0500
Received: from pat.uio.no ([129.240.130.16]:22432 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964960AbVLFMTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 07:19:32 -0500
Subject: Re: nfs unhappiness with memory pressure
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, theonetruekenny@yahoo.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <439524E2.7050500@yahoo.com.au>
References: <20051205210442.17357.qmail@web34106.mail.mud.yahoo.com>
	 <1133822367.8003.5.camel@lade.trondhjem.org>
	 <20051206143641.3feadaea.akpm@osdl.org>
	 <1133844026.8007.36.camel@lade.trondhjem.org>
	 <439524E2.7050500@yahoo.com.au>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 07:18:12 -0500
Message-Id: <1133871493.8020.4.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.074, required 12,
	autolearn=disabled, AWL 1.74, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-06 at 16:42 +1100, Nick Piggin wrote:

> writepage should as well, then it would have a better chance
> of just doing the right thing.

writepage triggers a stable write of the page (i.e. the page is written
directly to disk) if asked to reclaim it.

If the VM wants the unstable writes from the mapping to be committed, it
should call writepages.

Cheers,
  Trond

