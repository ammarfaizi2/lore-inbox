Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbTE2HAF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 03:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTE2HAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 03:00:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37902 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261944AbTE2HAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 03:00:04 -0400
Date: Thu, 29 May 2003 08:13:15 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: zippel@linux-m68k.org, mika.penttila@kolumbus.fi, akpm@digeo.com,
       hugh@veritas.com, LW@karo-electronics.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >= 2.5.30(at least))
Message-ID: <20030529081315.A12513@flint.arm.linux.org.uk>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	zippel@linux-m68k.org, mika.penttila@kolumbus.fi, akpm@digeo.com,
	hugh@veritas.com, LW@karo-electronics.de,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0305281827290.5042-100000@serv> <20030528.154720.74745668.davem@redhat.com> <Pine.LNX.4.44.0305290151470.5042-100000@serv> <20030528.183700.104033543.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030528.183700.104033543.davem@redhat.com>; from davem@redhat.com on Wed, May 28, 2003 at 06:37:00PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28, 2003 at 06:37:00PM -0700, David S. Miller wrote:
> Specifically, flush_dcache_page() is called any time the kernel makes
> cpu stores into a page cache page that might be mapped into a user's
> address space.

Presumably then the two in drivers/block/rd.c (ramdisk_readpage and
ramdisk_prepare_write) are out of spec then?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

