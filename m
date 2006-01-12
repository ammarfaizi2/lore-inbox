Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbWALB2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbWALB2B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 20:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWALB2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 20:28:01 -0500
Received: from ns2.suse.de ([195.135.220.15]:18856 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964950AbWALB17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 20:27:59 -0500
From: Andi Kleen <ak@suse.de>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 2 of 2] __raw_memcpy_toio32 for x86_64
Date: Thu, 12 Jan 2006 02:27:44 +0100
User-Agent: KMail/1.8.2
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <f03a807a80b8bc45bf91.1137025776@eng-12.pathscale.com> <200601120156.11529.ak@suse.de> <adaace2i6lr.fsf@cisco.com>
In-Reply-To: <adaace2i6lr.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601120227.45209.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 January 2006 02:21, Roland Dreier wrote:

>     Andi> movsq? I thought you wanted 32bit IO?
> 
> The idea is to do I/O in at least 32-bit chunks to cope with hardware
> that can't handle 8-bit or 16-bit accesses.  64-bit chunks are OK for
> Pathscale hardware.

Well then they can just as well use normal memcpy as long as they don't
pass any sizes % 4 != 0. That should be ok as long as they add a comment
there.

-Andi

