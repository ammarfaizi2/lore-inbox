Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWALAGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWALAGS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 19:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWALAGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 19:06:17 -0500
Received: from mx.pathscale.com ([64.160.42.68]:9940 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964836AbWALAGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 19:06:16 -0500
Subject: Re: [PATCH 3 of 3] Add __raw_memcpy_toio32 to each arch
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andrew Morton <akpm@osdl.org>
Cc: rdreier@cisco.com, linux-kernel@vger.kernel.org, hch@infradead.org,
       ak@suse.de
In-Reply-To: <20060111154614.47725c23.akpm@osdl.org>
References: <patchbomb.1137019194@eng-12.pathscale.com>
	 <ee6ce7e55dc7aec0d870.1137019197@eng-12.pathscale.com>
	 <20060111154614.47725c23.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 16:05:58 -0800
Message-Id: <1137024358.17705.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 15:46 -0800, Andrew Morton wrote:

> How's about we add a new linux/io.h which does:
> 
> #include <asm/io.h>
> void __raw_memcpy_toio32(void __iomem *to, const void *from, size_t count);

I thought about this, and about moving other duplicated definitions from
asm-*/io.h in here, but I couldn't find any other obvious candidates, so
I wasn't anxious to introduce a new file.

If you think that's OK, though, it obviously makes the patch a lot
smaller, and gives a common place to put future cross-arch definitions.

I'll run another spin of the patch with your and Roland's suggestions.

	<b

