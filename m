Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289375AbSAJKbi>; Thu, 10 Jan 2002 05:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289378AbSAJKbT>; Thu, 10 Jan 2002 05:31:19 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:13586 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289375AbSAJKbR>; Thu, 10 Jan 2002 05:31:17 -0500
Date: Thu, 10 Jan 2002 11:29:52 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Benjamin LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
Message-ID: <20020110112952.F3357@inspiron.school.suse.de>
In-Reply-To: <200201091928.g09JSdH23535@eng2.beaverton.ibm.com> <E16ORfZ-0002Zu-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E16ORfZ-0002Zu-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Jan 09, 2002 at 10:58:05PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 10:58:05PM +0000, Alan Cox wrote:
> > If it is not reasonable to fix all the brokern drivers,
> > how about making this configurable (to do variable size IO) ?
> > Do you favour this solution ?
> 
> We have hardware that requires aligned power of two for writes (ie 4K on
> 4K boundaries only). The 3ware is one example Jeff Merkey found

of course the right way to do it is to coalesce only if all the
alignments simulates what would happen with a 4k ext2. Now it maybe that
the patch is broken (didn't checked the implementation), but at least
theoretically the merging to save cpu should be doable without breaking
anything and without the need of bio (of course bio can do more than 4k
at once, so it's not nearly as powerful as bio but still it should make a
noticeable difference in the benchmarks).

Andrea
