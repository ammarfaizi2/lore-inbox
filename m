Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWFGEKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWFGEKw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 00:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWFGEKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 00:10:51 -0400
Received: from hera.kernel.org ([140.211.167.34]:34457 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750821AbWFGEKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 00:10:51 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: klibc (was: 2.6.18 -mm merge plans)
Date: Tue, 6 Jun 2006 21:10:17 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e65jj9$m9p$1@terminus.zytor.com>
References: <20060604135011.decdc7c9.akpm@osdl.org> <20060606152041.GA5427@ucw.cz> <200606062256.55472.rjw@sisk.pl> <200606071400.49980.ncunningham@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1149653417 22842 127.0.0.1 (7 Jun 2006 04:10:17 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 7 Jun 2006 04:10:17 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200606071400.49980.ncunningham@linuxmail.org>
By author:    Nigel Cunningham <ncunningham@linuxmail.org>
In newsgroup: linux.dev.kernel
> 
> Hi.
> 
> Sorry for coming in late. I've only just resubscribed after my move.
> 
> Not sure who originally said this...
> 
> > > > problems it entails.)  The initial code to have removed
> > > > is the root-mounting code, with all the various ugly
> > > > mutations of that (ramdisk loading, NFS root, initrd...)
> 
> Could I get more explanation of what this means and its implications? I'm 
> thinking in particular about the implications for suspending to disk. Will it 
> imply that everyone will _have_ to have an initramfs with some userspace 
> program that sets up device nodes and so on, even if at the moment all you 
> have is root=/dev/hda1 resume2=swap:/dev/hda2?
> 

Yes.  That initramfs is embedded in the kernel image.

> Along similar lines, I had been considering eventually including support for 
> putting an image in place of the initrd (for embedded).

You can still override the default buildin initramfs.  Then you get
the benefit of not carrying a bunch of code with you that can never be
executed.

	-hpa


