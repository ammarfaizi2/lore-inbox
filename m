Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWDMIxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWDMIxN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 04:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWDMIxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 04:53:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20200 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751168AbWDMIxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 04:53:12 -0400
Date: Thu, 13 Apr 2006 01:52:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Chinner <dgc@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: shrink_dcache_sb scalability problem.
Message-Id: <20060413015257.5b9d0972.akpm@osdl.org>
In-Reply-To: <20060413082210.GM1484909@melbourne.sgi.com>
References: <20060413082210.GM1484909@melbourne.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Chinner <dgc@sgi.com> wrote:
>
> After recently upgrading a build machine to 2.6.16, we started
>  seeing 10-50s pauses where the machine would appear to hang.

This sounds like the recent thread "Avoid excessive time spend on
concurrent slab shrinking" over on linux-mm.  Have you read through that?

http://marc.theaimsgroup.com/?l=linux-mm&r=1&b=200603&w=2
http://marc.theaimsgroup.com/?l=linux-mm&r=3&b=200604&w=2

It ended up somewaht inconclusive, but it looks like we do have a bit of a
problem, but it got exacerbated by an XFS slowness.

