Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288962AbSAFOoX>; Sun, 6 Jan 2002 09:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288963AbSAFOoN>; Sun, 6 Jan 2002 09:44:13 -0500
Received: from ns.suse.de ([213.95.15.193]:24074 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288962AbSAFOoF>;
	Sun, 6 Jan 2002 09:44:05 -0500
Date: Sun, 6 Jan 2002 15:44:04 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: <anton@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove 8 bytes from struct page on 64bit archs
In-Reply-To: <20020106.060824.106263786.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0201061542450.3859-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002, David S. Miller wrote:

>    Some of the low end single zone machines (m68k, sparc32, arm etc)
>    could benefit from losing ->virtual too.
> Sparc32 has kmapping, so it would need virtual.

I'm curious to see how large the tradeoff is with calculating
virtual in page_address(). The overhead there may be larger than
the win we get from better cacheline footprint in struct page

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

