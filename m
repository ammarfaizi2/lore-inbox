Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265925AbUBJO4G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 09:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265931AbUBJO4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 09:56:06 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:56075 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265925AbUBJO4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 09:56:02 -0500
Date: Tue, 10 Feb 2004 14:55:58 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg Kroah-Hartman <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dmapool (was: Re: Linux 2.6.3-rc2)
Message-ID: <20040210145558.A4684@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0402091914040.2128@home.osdl.org> <Pine.GSO.4.58.0402101424250.2261@waterleaf.sonytel.be> <Pine.GSO.4.58.0402101531240.2261@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.58.0402101531240.2261@waterleaf.sonytel.be>; from geert@linux-m68k.org on Tue, Feb 10, 2004 at 03:32:47PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 03:32:47PM +0100, Geert Uytterhoeven wrote:
> This patch seems to fix the problem (all offending platforms include
> <asm/generic.h> if CONFIG_PCI only):

Umm, no the whole point of the dmapool is that it's not pci-dependent.
Just fix your arch to have proper stub dma_ routines.  There were at
least two headsups during 2.5 and 2.6-test that this will be required.

