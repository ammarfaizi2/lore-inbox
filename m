Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759096AbWLAFlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759096AbWLAFlv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 00:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759095AbWLAFlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 00:41:51 -0500
Received: from smtp.osdl.org ([65.172.181.25]:37528 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1758196AbWLAFlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 00:41:50 -0500
Date: Thu, 30 Nov 2006 21:38:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: dreier@cisco.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 0 of 2] Add memcpy_cachebypass, a memcpy that doesn't
 cache reads
Message-Id: <20061130213820.5ed22d81.akpm@osdl.org>
In-Reply-To: <patchbomb.1164843307@eng-12.pathscale.com>
References: <patchbomb.1164843307@eng-12.pathscale.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 15:35:07 -0700
"Bryan O'Sullivan" <bos@pathscale.com> wrote:

> These patches add a memcpy that doesn't cache reads, and use it in the
> ipath driver's OpenIB receive path.
> 
> This version incorporates a few changes asked for last time around by DaveM.

Everybody seems to be hiding.

The name memcpy_cachebypass() doesn't tell us whether it bypasses caching
on the source, the dest or both.  It'd be nice if it did.

<tries to remember what copy_user_zeroing_intel_nocache() does>
