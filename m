Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbTHUPrS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 11:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbTHUPrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 11:47:18 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:45480 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262780AbTHUPrR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 11:47:17 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16196.59778.993371.804217@laputa.namesys.com>
Date: Thu, 21 Aug 2003 19:47:14 +0400
To: Jamie Lokier <jamie@shareable.org>
Cc: Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: posix_fallocate question again
In-Reply-To: <20030821153835.GA29245@mail.jlokier.co.uk>
References: <41F331DBE1178346A6F30D7CF124B24B0183C1A4@fmsmsx409.fm.intel.com>
	<20030820125301.3a1ed0fb.akpm@osdl.org>
	<16196.35366.563218.572370@laputa.namesys.com>
	<20030821153835.GA29245@mail.jlokier.co.uk>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier writes:
 > Nikita Danilov wrote:
 > > fallocate() will be useful when writing into file through
 > > mmap(). Currently kernel can just drop dirtied page at any moment (if
 > > ->writepage() fails with -ENOSPC), so the only safe way to modify file
 > > through mmap() is by using mlock().
 > 
 > Isn't msync() reliable?  I.e. will it at least report the error?

Seems latest 2.6 (19 Aug change sets by Andrew Morton) got support for
this: shrink_list() set AS_ENOSPC on mapping and error will later be
returned.

 > 
 > -- Jamie

Nikita.
