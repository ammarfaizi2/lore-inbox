Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933090AbWFZWQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933090AbWFZWQS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933091AbWFZWQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:16:17 -0400
Received: from r16s03p19.home.nbox.cz ([83.240.22.12]:11159 "EHLO
	scarab.smoula.net") by vger.kernel.org with ESMTP id S933090AbWFZWQP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:16:15 -0400
Subject: Re: NFS and partitioned md
From: Martin Filip <bugtraq@smoula.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1151358717.9797.13.camel@lade.trondhjem.org>
References: <1151355145.4460.16.camel@archon.smoula-in.net>
	 <1151355509.9797.7.camel@lade.trondhjem.org>
	 <1151356840.4460.18.camel@archon.smoula-in.net>
	 <1151358717.9797.13.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-2
Date: Tue, 27 Jun 2006 00:14:47 +0200
Message-Id: <1151360087.8325.2.camel@archon.smoula-in.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust pí¹e v Po 26. 06. 2006 v 17:51 -0400:

> > > > few days ago I've changed my sw RAID5 to use md_d devices, which are
> > > > "partitonable". (major 254, minor dependant on partiton no)
> > > > 
> > > > The problem is with kernel space NFS daemon. When I create loopback
> > > > device and export it - everything works OK, but when exported directory
> > > > is directly something goes really wrong and it's not possible to mount
> > > > it.
> > > 
> > > Could we at the very least see a copy of your /etc/exports
> > > and /etc/fstab please?
> > of course... thought It's irelevant when it works with other devices...
> > 
> > $ cat /etc/exports 
> > /mnt/data/public            *(ro,all_squash,async)
> > 
> > mounted via
> > mount -t nfs 192.168.0.2:/mnt/data/public /mnt/tmp/
> 
> You are running with the 'all_squash' export option: does the anonymous
> user actually have the required permissions to access /mnt/data/public?
> 

Yes, of course... that dir and everything in that is world readable
(+executable when it is directory)
Everything worked with same settings, versions and everything between
switching my multiple md devices into md_d. And even now it works on
other devices than md_d.


