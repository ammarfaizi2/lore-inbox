Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268840AbUHZNtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268840AbUHZNtL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 09:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268866AbUHZNsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 09:48:53 -0400
Received: from mail.shareable.org ([81.29.64.88]:9670 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S268906AbUHZNs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 09:48:27 -0400
Date: Thu, 26 Aug 2004 14:48:12 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       Alex Zarochentsev <zam@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826134812.GB5733@mail.shareable.org>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <20040825203516.GB4688@backtop.namesys.com> <20040825205149.GA17654@lst.de> <412DA2CF.2030204@namesys.com> <20040826124119.GA431@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826124119.GA431@lst.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
>  you need to fstat after open to really check that no one swtiched the
>  path below you to a fifo or device, O_DIRECTORY gets that directly in
>  the open call, with the additional benefit of making sure you don't
>  get any of the sideeffects at all that would happen if you're opening
>  a device file.
> 
>  the current reiser4 semantics break that and as soon as you're having a
>  world-writeable (e.g. /tmp) dir on it and someone is doing an opendir
>  on it he's lost.

How does the current reiser4 semantics break that?

In a reiser4 filesystem, a file _is_ a directory.
opendir() is supposed to succeed on it.

There's bound to be some security issue, but I'm not sure what you're
getting at with /tmp.  What sort of sort of security problem arises
with a world-writeable directory such as /tmp, that cannot arise with
the standard fs semantics?

-- Jamie
