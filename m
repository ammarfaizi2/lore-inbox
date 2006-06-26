Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWFZVwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWFZVwI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 17:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWFZVwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 17:52:08 -0400
Received: from pat.uio.no ([129.240.10.4]:9438 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751185AbWFZVwH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 17:52:07 -0400
Subject: Re: NFS and partitioned md
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Martin Filip <bugtraq@smoula.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1151356840.4460.18.camel@archon.smoula-in.net>
References: <1151355145.4460.16.camel@archon.smoula-in.net>
	 <1151355509.9797.7.camel@lade.trondhjem.org>
	 <1151356840.4460.18.camel@archon.smoula-in.net>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jun 2006 17:51:56 -0400
Message-Id: <1151358717.9797.13.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.803, required 12,
	autolearn=disabled, AWL 1.20, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-26 at 23:20 +0200, Martin Filip wrote:
> Trond Myklebust píše v Po 26. 06. 2006 v 16:58 -0400:
> > On Mon, 2006-06-26 at 22:52 +0200, Martin Filip wrote:
> > > Hello to LKML,
> > > 
> > > few days ago I've changed my sw RAID5 to use md_d devices, which are
> > > "partitonable". (major 254, minor dependant on partiton no)
> > > 
> > > The problem is with kernel space NFS daemon. When I create loopback
> > > device and export it - everything works OK, but when exported directory
> > > is directly something goes really wrong and it's not possible to mount
> > > it.
> > 
> > Could we at the very least see a copy of your /etc/exports
> > and /etc/fstab please?
> of course... thought It's irelevant when it works with other devices...
> 
> $ cat /etc/exports 
> /mnt/data/public            *(ro,all_squash,async)
> 
> mounted via
> mount -t nfs 192.168.0.2:/mnt/data/public /mnt/tmp/

You are running with the 'all_squash' export option: does the anonymous
user actually have the required permissions to access /mnt/data/public?

Cheers,
  Trond

