Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264344AbUEXQRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264344AbUEXQRl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 12:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbUEXQRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 12:17:41 -0400
Received: from waste.org ([209.173.204.2]:25261 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264344AbUEXQRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 12:17:40 -0400
Date: Mon, 24 May 2004 11:17:33 -0500
From: Matt Mackall <mpm@selenic.com>
To: Roland Dreier <roland@topspin.com>
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5
Message-ID: <20040524161733.GX5414@waste.org>
References: <20040522013636.61efef73.akpm@osdl.org> <m165aorm70.fsf@ebiederm.dsl.xmission.com> <20040522180837.3d3cc8a9.akpm@osdl.org> <527jv4ymd4.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <527jv4ymd4.fsf@topspin.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2004 at 06:15:51PM -0700, Roland Dreier wrote:
>     Andrew> I don't think we can expect all architectures to be able
>     Andrew> to implement atomic 64-bit IO's, can we?
> 
>     Andrew> ergo, drivers which want to use readq and writeq should
>     Andrew> provide the appropriate locking.
> 
> Perhaps we should have ARCH_HAS_ATOMIC_WRITEQ or something so that
> drivers don't add the overhead of locking on architectures where it's
> not necessary?

Or perhaps we just need a lockless __readq/__writeq for drivers that
know better.

-- 
Mathematics is the supreme nostalgia of our time.
