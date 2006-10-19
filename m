Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423312AbWJSLtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423312AbWJSLtE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 07:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423313AbWJSLtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 07:49:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54687 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1423312AbWJSLtC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 07:49:02 -0400
Date: Thu, 19 Oct 2006 12:49:00 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: Neil Brown <neilb@suse.de>, Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] nfs endianness annotations
Message-ID: <20061019114900.GS29920@ftp.linux.org.uk>
References: <E1GX7zV-00047C-PO@ZenIV.linux.org.uk> <1161206763.6095.172.camel@lade.trondhjem.org> <17718.51050.186385.512984@cse.unsw.edu.au> <20061019012600.GR29920@ftp.linux.org.uk> <du2ej21g7pkccoe4cigs8r9gsq1ir6nc9p@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <du2ej21g7pkccoe4cigs8r9gsq1ir6nc9p@4ax.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 03:30:25PM +1000, Grant Coady wrote:
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

$ grep -l sparse Documentation/*
Documentation/CodingStyle
Documentation/README.DAC960
Documentation/SubmitChecklist
Documentation/sparse.txt
$
