Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbTHUPjE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 11:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262778AbTHUPjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 11:39:04 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:64898 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262754AbTHUPjC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 11:39:02 -0400
Date: Thu, 21 Aug 2003 16:38:35 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: posix_fallocate question again
Message-ID: <20030821153835.GA29245@mail.jlokier.co.uk>
References: <41F331DBE1178346A6F30D7CF124B24B0183C1A4@fmsmsx409.fm.intel.com> <20030820125301.3a1ed0fb.akpm@osdl.org> <16196.35366.563218.572370@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16196.35366.563218.572370@laputa.namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:
> fallocate() will be useful when writing into file through
> mmap(). Currently kernel can just drop dirtied page at any moment (if
> ->writepage() fails with -ENOSPC), so the only safe way to modify file
> through mmap() is by using mlock().

Isn't msync() reliable?  I.e. will it at least report the error?

-- Jamie
