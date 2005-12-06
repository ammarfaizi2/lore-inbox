Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S964778AbVLFWOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbVLFWOl (ORCPT <rfc822;akpm@zip.com.au>);
	Tue, 6 Dec 2005 17:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbVLFWOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 17:14:41 -0500
Received: from vds.fauxbox.com ([208.210.124.75]:7301 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S964778AbVLFWOk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 17:14:40 -0500
Date: Tue, 6 Dec 2005 17:14:34 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linuxppc64-dev@ozlabs.org,
        viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
        arjan@infradead.org
Subject: Re: [PATCH 02/14] spufs: fix local store page refcounting
Message-ID: <20051206221434.GB8901@localhost.localdomain>
References: <20051206035220.097737000@localhost> <200512061118.19633.arnd@arndb.de> <1133869108.7968.1.camel@localhost> <200512061949.33482.arnd@arndb.de> <1133895947.3279.4.camel@localhost> <17301.65082.251692.675360@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17301.65082.251692.675360@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:
> Pekka Enberg writes:
> 
> > I would prefer them to stay in arch/powerpc/. As far as I understand,
> > spufs will never have any use for platforms other than cell, so I really
> > don't see any point in putting it in fs/.
> 
> The point is that people making changes to the filesystem interfaces
> will be much more likely to notice and fix stuff that is under fs/
> than code that is buried deep under arch/ somewhere.  Filesystems
> should go under fs/ for the sake of long-term maintainability.  The
> fact that it's only used on one architecture is irrelevant - you
> simply make sure (with the appropriate Kconfig bits) that it's only
> offered on that architecture.

openpromfs seems to be a precedent here.  It makes sense only on sparc
and sparc64 but it lives in fs/.

