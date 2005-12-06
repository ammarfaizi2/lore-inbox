Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbVLFVlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbVLFVlk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 16:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932643AbVLFVlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 16:41:40 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:52912 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932642AbVLFVlk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 16:41:40 -0500
Subject: Re: [PATCH 02/14] spufs: fix local store page refcounting
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Paul Mackerras <paulus@samba.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       viro@ftp.linux.org.uk
In-Reply-To: <17301.65082.251692.675360@cargo.ozlabs.ibm.com>
References: <20051206035220.097737000@localhost>
	 <200512061118.19633.arnd@arndb.de> <1133869108.7968.1.camel@localhost>
	 <200512061949.33482.arnd@arndb.de> <1133895947.3279.4.camel@localhost>
	 <17301.65082.251692.675360@cargo.ozlabs.ibm.com>
Date: Tue, 06 Dec 2005 23:41:38 +0200
Message-Id: <1133905298.8027.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Wed, 2005-12-07 at 08:10 +1100, Paul Mackerras wrote:
> The point is that people making changes to the filesystem interfaces
> will be much more likely to notice and fix stuff that is under fs/
> than code that is buried deep under arch/ somewhere.  Filesystems
> should go under fs/ for the sake of long-term maintainability.  The
> fact that it's only used on one architecture is irrelevant - you
> simply make sure (with the appropriate Kconfig bits) that it's only
> offered on that architecture.

I think the fact that it is highly architecture specific is relevant. I
have no way of testing spufs changes except on cell, no? And if I am
developing on a cell, I probably will notice it in arch/ all the same.
So I don't quite buy your the maintenace argument.

But as Arnd said, there are no clear rules on what kind of filesystems
should go into fs/ so please do whatever you must.

			Pekka

