Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbVLFVXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbVLFVXR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 16:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbVLFVXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 16:23:17 -0500
Received: from ozlabs.org ([203.10.76.45]:4010 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030254AbVLFVXQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 16:23:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17301.65082.251692.675360@cargo.ozlabs.ibm.com>
Date: Wed, 7 Dec 2005 08:10:18 +1100
From: Paul Mackerras <paulus@samba.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       viro@ftp.linux.org.uk
Subject: Re: [PATCH 02/14] spufs: fix local store page refcounting
In-Reply-To: <1133895947.3279.4.camel@localhost>
References: <20051206035220.097737000@localhost>
	<200512061118.19633.arnd@arndb.de>
	<1133869108.7968.1.camel@localhost>
	<200512061949.33482.arnd@arndb.de>
	<1133895947.3279.4.camel@localhost>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg writes:

> I would prefer them to stay in arch/powerpc/. As far as I understand,
> spufs will never have any use for platforms other than cell, so I really
> don't see any point in putting it in fs/.

The point is that people making changes to the filesystem interfaces
will be much more likely to notice and fix stuff that is under fs/
than code that is buried deep under arch/ somewhere.  Filesystems
should go under fs/ for the sake of long-term maintainability.  The
fact that it's only used on one architecture is irrelevant - you
simply make sure (with the appropriate Kconfig bits) that it's only
offered on that architecture.

Paul.
