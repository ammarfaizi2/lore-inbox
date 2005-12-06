Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965029AbVLFTFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbVLFTFu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 14:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbVLFTFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 14:05:50 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:6061 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S965029AbVLFTFs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 14:05:48 -0500
Subject: Re: [PATCH 02/14] spufs: fix local store page refcounting
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       viro@ftp.linux.org.uk
In-Reply-To: <200512061949.33482.arnd@arndb.de>
References: <20051206035220.097737000@localhost>
	 <200512061118.19633.arnd@arndb.de> <1133869108.7968.1.camel@localhost>
	 <200512061949.33482.arnd@arndb.de>
Date: Tue, 06 Dec 2005 21:05:47 +0200
Message-Id: <1133895947.3279.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2005-12-06 at 19:49 +0100, Arnd Bergmann wrote:
> I guess there is no strict rule where these file systems go to, e.g.
> hugetlbs could just as well live near mm/shmem.c or any of those outside
> of fs/ could be moved in there.

hugetlbs does not contain architecture specific code so I don't see it
as a problem.

On Tue, 2005-12-06 at 19:49 +0100, Arnd Bergmann wrote:
> I don't really care where I put spufs, but I would prefer to move
> the files only one more time at most.
> Initially, they were in fs/spufs, and I moved them to
> arch/powerpc/platforms/cell/spufs at Pekkas suggestion.

I would prefer them to stay in arch/powerpc/. As far as I understand,
spufs will never have any use for platforms other than cell, so I really
don't see any point in putting it in fs/.

			Pekka

