Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263002AbVD2VdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbVD2VdN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 17:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263004AbVD2Vaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 17:30:30 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:52623 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S263005AbVD2V2N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 17:28:13 -0400
Date: Fri, 29 Apr 2005 23:28:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: aq <aquynh@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/Kconfig: more consistent configuration of XFS
Message-ID: <20050429212835.GD8699@mars.ravnborg.org>
References: <9cde8bff050428005528ecf692@mail.gmail.com> <20050428080914.GA10799@infradead.org> <9cde8bff0504280138b979c08@mail.gmail.com> <20050428083922.GA11542@infradead.org> <9cde8bff05042802213ec650e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cde8bff05042802213ec650e0@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 06:21:52PM +0900, aq wrote:
> 
> OK, here is another patch. It is up to Andrew to pick the approriate.
> But I still prefer the first patch, which provides both consistency in
> interface and configuration.

We shall do out best to distribute info to places where it belongs.
A much better approch would be to move all ext2 + ext3 stuff out in
their respective directories.
When modifying xfs (or ext2,ext3) no files outside their respective
directories should in need to be touched - this would just impose
additional burden doing parrallel development.

About your modifications:

Skipping the menu part is OK.
While you are modifying Kconfig in xfs/ put a

if XFS_FS
...
endif

around all config options expcept the one defining the XFS_FS option.
This will fix menu identing.

	Sam
