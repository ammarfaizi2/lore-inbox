Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWHBVxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWHBVxE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWHBVxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:53:04 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:18338 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932247AbWHBVxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:53:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eejPL7caJzGZbpNCmhU8ig4GUTvSfDf2oWv74DscFiN3oRsw8vaWUb+vu4hj7cZEXcauju0geAVD0qvDpAUbaS/i1zpFA/k0BuiWK1VbrpMzAFFcdQbrUXhwqrKhmUbk6JHeMZyiF3nm5Bch8dkoS2DXw1T9vgCjfbdy4E0NDl8=
Message-ID: <6bffcb0e0608021453x5f44973ct7ce257dc80b5f1c2@mail.gmail.com>
Date: Wed, 2 Aug 2006 23:53:02 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Hugh Dickins" <hugh@veritas.com>
Subject: Re: mm snapshot broken-out-2006-08-02-00-27.tar.gz uploaded
Cc: "Andrew Morton" <akpm@osdl.org>, "Nick Piggin" <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0608021942500.13042@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608020728.k727SegM012704@shell0.pdx.osdl.net>
	 <6bffcb0e0608021115s65f81224td8d852b931a9b787@mail.gmail.com>
	 <Pine.LNX.4.64.0608021942500.13042@blonde.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

On 02/08/06, Hugh Dickins <hugh@veritas.com> wrote:
> On Wed, 2 Aug 2006, Michal Piotrowski wrote:
> > On 02/08/06, akpm@osdl.org <akpm@osdl.org> wrote:
> > > The mm snapshot broken-out-2006-08-02-00-27.tar.gz has been uploaded to
> > >
> > >    ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/broken-out-2006-08-02-00-27.tar.gz
> > >
> > > It contains the following patches against 2.6.18-rc3:
> ....
> >
> > Here is something new, previous mm snapshot was fine
> >
> > Aug  2 19:56:08 ltg01-fedora kernel: ------------[ cut here ]------------
> > Aug  2 19:56:08 ltg01-fedora kernel: kernel BUG at
> > /usr/src/linux-work4/mm/shmem.c:1228!
> > 1228            BUG_ON(!(vma->vm_flags & VM_CAN_INVALIDATE));
> >
> > I will revert
> > fix-the-race-between-invalidate_inode_pages-and-do_no_page.patch
> > fix-the-race-between-invalidate_inode_pages-and-do_no_page-tidy.patch
> > and see what will happen.
>
> Rather than reverting those, please add something like (I've not seen
> this particular tree) the fixup below - it's easily missed that
> ipc/shm.c has its own reference to shmem_nopage.  (Last I heard,
> the flag was called VM_CAN_INVLD, but it looks like I'm not the
> only one averse to unpronounceables.)

Oops is gone. Thanks!

Andrew, can you add this patch to -mm?

>
> Hugh
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
