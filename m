Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945896AbWJSGcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945896AbWJSGcP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 02:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161335AbWJSGcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 02:32:14 -0400
Received: from ns2.suse.de ([195.135.220.15]:65480 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161337AbWJSGcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 02:32:13 -0400
From: Neil Brown <neilb@suse.de>
To: Grant Coady <gcoady.lk@gmail.com>
Date: Thu, 19 Oct 2006 16:32:02 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17719.7138.688743.259430@cse.unsw.edu.au>
Cc: Al Viro <viro@ftp.linux.org.uk>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] nfs endianness annotations
In-Reply-To: message from Grant Coady on Thursday October 19
References: <E1GX7zV-00047C-PO@ZenIV.linux.org.uk>
	<1161206763.6095.172.camel@lade.trondhjem.org>
	<17718.51050.186385.512984@cse.unsw.edu.au>
	<20061019012600.GR29920@ftp.linux.org.uk>
	<du2ej21g7pkccoe4cigs8r9gsq1ir6nc9p@4ax.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday October 19, grant_lkml@dodo.com.au wrote:
> On Thu, 19 Oct 2006 02:26:00 +0100, Al Viro <viro@ftp.linux.org.uk> wrote:
> 
> >Folks, seriously, please run sparse after changes; it's a simple matter of
> >make C=2 CF=-D__CHECK_ENDIAN__ fs/nfs*/; nothing tricky and it saves a lot
> >of potential PITA...
> 
> grant@sempro:~/linux/linux-2.6.19-rc2a$ make C=2 CF=-D__CHECK_ENDIAN__ fs/nfs*/;
>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   CHECK   scripts/mod/empty.c
> /bin/sh: sparse: command not found
> make[2]: *** [scripts/mod/empty.o] Error 127
> make[1]: *** [scripts/mod] Error 2
> make: *** [scripts] Error 2
> 
> What sparse?  Pointer please?  Hell of a keyword to search for :(
> 
> Thanks,
> Grant.

git clone  git://git.kernel.org/pub/scm/devel/sparse/sparse.git
cd sparse
make
make install


Of course you need git first ... not "GNU Interactive Tools", but
Linus' SCM.  Most distros have it.

NeilBrown


