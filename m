Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269159AbUHZP6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269159AbUHZP6s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 11:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269166AbUHZP6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 11:58:47 -0400
Received: from verein.lst.de ([213.95.11.210]:51417 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S269156AbUHZP5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 11:57:55 -0400
Date: Thu, 26 Aug 2004 17:57:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       Alex Zarochentsev <zam@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826155744.GA4250@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Jamie Lokier <jamie@shareable.org>,
	Hans Reiser <reiser@namesys.com>,
	Alex Zarochentsev <zam@namesys.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Lyamin aka FLX <flx@namesys.com>,
	Linus Torvalds <torvalds@osdl.org>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <20040825203516.GB4688@backtop.namesys.com> <20040825205149.GA17654@lst.de> <412DA2CF.2030204@namesys.com> <20040826124119.GA431@lst.de> <20040826134812.GB5733@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826134812.GB5733@mail.shareable.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 02:48:12PM +0100, Jamie Lokier wrote:
> >  the current reiser4 semantics break that and as soon as you're having a
> >  world-writeable (e.g. /tmp) dir on it and someone is doing an opendir
> >  on it he's lost.
> 
> How does the current reiser4 semantics break that?
> 
> In a reiser4 filesystem, a file _is_ a directory.
> opendir() is supposed to succeed on it.
> 
> There's bound to be some security issue, but I'm not sure what you're
> getting at with /tmp.  What sort of sort of security problem arises
> with a world-writeable directory such as /tmp, that cannot arise with
> the standard fs semantics?

Actually you are right on that issue because it would open the
device/fifo as directory and not device/fifo (in fact I'd had to look at
the code again to see whether they actually do this only for files or
also for special files)

