Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbTEGGrO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 02:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTEGGrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 02:47:13 -0400
Received: from [217.157.19.70] ([217.157.19.70]:6924 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S262776AbTEGGrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 02:47:12 -0400
From: Thomas Horsten <thomas@horsten.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__ defined (trivial)
Date: Wed, 7 May 2003 07:59:49 +0100
User-Agent: KMail/1.5.1
Cc: "ismail (cartman) donmez" <voidcartman@yahoo.com>,
       "David S. Miller" <davem@redhat.com>, marcelo@conectiva.com.br,
       hch@infradead.org, linux-kernel@vger.kernel.org
References: <20030506104956.A29357@infradead.org> <200305070744.27207.thomas@horsten.com> <20030507074557.A9197@infradead.org>
In-Reply-To: <20030507074557.A9197@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305070759.49121.thomas@horsten.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 May 2003 7:45 am, Christoph Hellwig wrote:
> That's highly broken because his libc was compiled against 2.2 headers.
> You must never use different headers in /usr/include/Pasm,linux} then those
> your libc was compiled against.

I don't see why moving up should be wrong - the ABI is {guaranteed | supposed} 
to remain backward compatible so the libc itself should be fine, and using 
the newer headers to build apps shouldn't hurt - at least I can't see any 
obvious cases (there are probably some, but at any rate I, have seen this 
work without problems a number of times, without rebuilding libc but using 
new features from the kernel, like iptables).

In any case, it doesn't change my example, just let Joe Admin rebuild glibc as 
well :-)

// Thomas
