Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWHWCt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWHWCt6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 22:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWHWCt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 22:49:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47259 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932319AbWHWCt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 22:49:57 -0400
Date: Tue, 22 Aug 2006 19:49:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Clay Barnes <clay.barnes@gmail.com>
Cc: Jeff Mahoney <jeffm@suse.com>, David Masover <ninja@slaphack.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Mike Benoit <ipso@snappymail.ca>
Subject: Re: [PATCH] reiserfs: eliminate minimum window size for bitmap
 searching
Message-Id: <20060822194946.7411112f.akpm@osdl.org>
In-Reply-To: <20060823024634.GK9112@HAL_5000D.tc.ph.cox.net>
References: <44EB1484.2040502@suse.com>
	<44EB23D9.9000508@slaphack.com>
	<44EB28EC.50802@suse.com>
	<44EB684C.2090206@slaphack.com>
	<44EB7518.5010204@suse.com>
	<20060822171133.72692542.akpm@osdl.org>
	<20060823024634.GK9112@HAL_5000D.tc.ph.cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2006 19:46:34 -0700
Clay Barnes <clay.barnes@gmail.com> wrote:

> Perhaps I mis-recall, but shouldn't delayed writes (or something along 
> those lines) cause a case where two files are being incrementally
> written rare?

If we did delayed allocation, yes.  But we generally don't.  (Exceptions:
XFS, reiser4, ext4, ext2 prototype circa 2001).
