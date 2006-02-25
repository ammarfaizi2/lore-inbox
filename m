Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932671AbWBYEoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbWBYEoV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 23:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbWBYEoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 23:44:21 -0500
Received: from cantor2.suse.de ([195.135.220.15]:51128 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932671AbWBYEoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 23:44:21 -0500
From: Andi Kleen <ak@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
Date: Sat, 25 Feb 2006 05:43:21 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <1140841250.2587.33.camel@localhost.localdomain>
In-Reply-To: <1140841250.2587.33.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602250543.22421.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 February 2006 05:20, Bryan O'Sullivan wrote:
> On some platforms, a regular wmb() is not sufficient to guarantee that
> PCI writes have been flushed to the bus if write combining is in effect.

On what platforms?
 
> It does so by way of a new header file, <linux/system.h>.  This header
> can be a site for oft-replicated code from <asm-*/system.h>, but isn't
> just yet.

linux/system.h looks unnatural to me.
 
> We also define a version of wc_wmb() with the required semantics
> on x86_64.

Leaving i386 out in the cold?

-Andi

