Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266348AbUBQRBC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 12:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266347AbUBQRBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 12:01:02 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:13541 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266348AbUBQRAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 12:00:54 -0500
Date: Tue, 17 Feb 2004 17:00:53 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Tom Guilliams <tguilliams@san.rr.com>, DHollenbeck <dick@softplc.com>,
       <busybox@mail.codepoet.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [BusyBox] [Fwd: Loopback device setup?]
In-Reply-To: <200402171022.38290.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.44.0402171649420.22275-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004, vda wrote:
> On Tuesday 17 February 2004 02:20, Tom Guilliams wrote:
> > in /driver/block/loop.c -
> >
> > loop_set_fd()
> >
> > 		/*
> >                   * If we can't read - sorry. If we only can't write -
> >                  		 * well, it's going to be read-only.
> >                   */
> >                  if (!aops->readpage)
> >                          goto out_putf;
> >
> > I confirmed the "if (!aops->readpage)" is true.  I'm not sure what the
> > readpage routine is trying to do (which dev or file) in my command below -
> > # mount -t ext2 -o loop ramdisk.image rootfs
> >
> > Anyone have any thoughts??  This is all being done in the /tmp
> > dircectory which is mounted as "tmpfs".  Not sure if that has anything
> > to do with it.
> 
> I recall that tmpfs cannot do readpage (by design?).
> CCing LKML, maybe someone will pour in more info.

readpage is not straightforward for tmpfs, so it took a long time
to be added, but tmpfs has supported loop since 2.4.22 and 2.5.45.

Hugh

