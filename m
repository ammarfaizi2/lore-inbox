Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVB0WKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVB0WKH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 17:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVB0WKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 17:10:07 -0500
Received: from mail.suse.de ([195.135.220.2]:35750 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261387AbVB0WKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 17:10:03 -0500
From: Andreas Gruenbacher <agruen@suse.de>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH 1/8] lib/sort: Heapsort implementation of sort()
Date: Sun, 27 Feb 2005 23:10:00 +0100
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <2.416337461@selenic.com> <20050227212536.GG3120@waste.org> <200502272253.23732.agruen@suse.de>
In-Reply-To: <200502272253.23732.agruen@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502272310.01238.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 February 2005 22:53, Andreas Gruenbacher wrote:
> Okay, I didn't notice the off-by-one fix. It's still broken though; see the
> attached user-space test.

Found it. I didn't have the off-by-one fix and the bug triggered; then the 
test case had a useless comparison function:

int cmp(const int *a, const int *b)
{
        return b - a;
}

Works fine now.

Thanks,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH
