Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265976AbRG3THO>; Mon, 30 Jul 2001 15:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266698AbRG3THE>; Mon, 30 Jul 2001 15:07:04 -0400
Received: from ns.caldera.de ([212.34.180.1]:28332 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S265976AbRG3TGw>;
	Mon, 30 Jul 2001 15:06:52 -0400
Date: Mon, 30 Jul 2001 21:06:44 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Christoph Hellwig <hch@ns.caldera.de>,
        Matthew Gardiner <kiwiunixman@yahoo.co.nz>,
        kernel <linux-kernel@vger.kernel.org>,
        Joshua Schmidlkofer <menion@srci.iwpsd.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <20010730210644.A5488@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch>, Hans Reiser <reiser@namesys.com>,
	Christoph Hellwig <hch@ns.caldera.de>,
	Matthew Gardiner <kiwiunixman@yahoo.co.nz>,
	kernel <linux-kernel@vger.kernel.org>,
	Joshua Schmidlkofer <menion@srci.iwpsd.org>
In-Reply-To: <200107281645.f6SGjA620666@ns.caldera.de> <3B653211.FD28320@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B653211.FD28320@namesys.com>; from reiser@namesys.com on Mon, Jul 30, 2001 at 02:08:17PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 30, 2001 at 02:08:17PM +0400, Hans Reiser wrote:
> Christoph Hellwig wrote:
> > 
>  
> > Reiserfs as implemented in the 2.4.2-based kernel of OpenLinux 3.1 is
> > everything but stable and has a lot of issues (e.g. NFS-exporting doesn't
> > work).  That is the reason why it is a) marked experimental and is completly
> > unsupported (and that is written _big_ _fat_ in manuals and similar stuff)
> > and b) has debugging enabled to have the additional sanity checks that are
> > under this option and give addtional hints if reiserfs fails again.
> 
> The debugging won't prevent a single crash, it will only print a diagnostic that
> might help to understand why it crashed.

I don't know when you took a look at you code the last time, but when
I did some time before the COL 3.1 release, there were lots of places
in the reiserfs code where functions assumed that they have valid
arguments when compiled without debugging and did the check explicitly
when compiled with.  Given the state the reiserfs code is in I really
prefer to see this option turned on.

> It makes zero sense for a distro to
> have it on, and I think we make that pretty clear in the help button.  It would
> be nice if distros read the help buttons before selecting options when
> configuring their kernels.:-/

Well sometimes it's even better to take a look at the code..

	Christoph

> I make no claims that users should use ReiserFS as it is in a 2.4.2 kernel....

No one said that (and even if I wouldn't believe him).

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
