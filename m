Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbTDUSPc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbTDUSPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:15:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6848 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261829AbTDUSPb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:15:31 -0400
Date: Mon, 21 Apr 2003 19:27:34 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       "David S. Miller" <davem@redhat.com>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new system call mknod64
Message-ID: <20030421182734.GN10374@parcelfarce.linux.theplanet.co.uk>
References: <20030421191013.A9655@infradead.org> <Pine.LNX.4.44.0304211117260.3101-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304211117260.3101-100000@home.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 11:22:51AM -0700, Linus Torvalds wrote:
 
> One way to avoid the bug is to always keep all dev_t numbers in "canonical 
> format". Which happens automatically if the interface is <major, minor> 
> rather than a 64-bit blob.
> 
> I personally think that anything that uses "dev_t" in _any_ other way than 
> <major,minor> is fundamentally broken.

Do you consider internal use of MKDEV-produced constants broken?
