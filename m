Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030451AbWALQEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030451AbWALQEr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 11:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030453AbWALQEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 11:04:47 -0500
Received: from mx.pathscale.com ([64.160.42.68]:9143 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1030451AbWALQEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 11:04:47 -0500
Subject: Re: [PATCH 2 of 3] memcpy32 for x86_64
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, hch@infradead.org, ak@suse.de,
       rdreier@cisco.com
In-Reply-To: <200601121038.17764.vda@ilport.com.ua>
References: <b4863171295fdb6e8206.1136922838@serpentine.internal.keyresearch.com>
	 <200601121038.17764.vda@ilport.com.ua>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 12 Jan 2006 08:04:41 -0800
Message-Id: <1137081882.28011.1.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 10:38 +0200, Denis Vlasenko wrote:

> 2) On all current x86_64 hardware each 64bit access from/to
> IO mapped addresses is always converted to two 32bit accesses.

This is true for 64-bit writes over Hypertransport (reads don't get
split up this way), but not for PCI-Express memory writes, which remain
atomic 64-bit.  I'll be converting the 64-bit accesses to 32-bit, as you
and Andi suggested.

	<b

