Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUA1XGi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 18:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265964AbUA1XGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 18:06:37 -0500
Received: from ti221110a080-0832.bb.online.no ([80.213.3.64]:18565 "EHLO
	nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S265800AbUA1XGg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 18:06:36 -0500
Subject: Re: NFS: giant filename in readdir
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jussi Hamalainen <count@theblah.fi>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0401272233490.10626@mir.senv.net>
References: <Pine.LNX.4.58.0401272233490.10626@mir.senv.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1075331193.1616.69.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 29 Jan 2004 00:06:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På ty , 27/01/2004 klokka 21:53, skreiv Jussi Hamalainen:
> Both boxes have an almost identical setup of Slackware 9.1 and were
> running 2.4.23-pac1+security bugfixes. The boxes are connected to the
> same switch and VLAN. They mount filesystems from each other (yeah, I
> know cross-mounting with NFS is a bad idea...) and the problem
> occurred on both servers simultaineously.
> 
> The mounts look like this:
> 
> mir:/home on /home type nfs
> (rw,rsize=8192,wsize=8192,hard,intr,lock,addr=XXX)
> mir:/archive on /archive type nfs
> (rw,rsize=8192,wsize=8192,soft,intr,addr=XXX)
> 
> sputnik:/var/spool/mail on /var/spool/mail type nfs
> (rw,rsize=8192,wsize=8192,hard,intr,lock,nfsvers=2,addr=XXX)
> sputnik:/files on /files type nfs
> (rw,rsize=8192,wsize=8192,soft,intr,nfsvers=2,addr=XXX)

Any info forthcoming on the filesystem you used and/or a binary tcpdump
demonstrating the problem? (remember to use a large snaplen in the
tcpdump - something like "-s 9000").

Does the problem still occur when you change "soft" to "hard"? Note that
the default setting for "retrans" as set by the nfs-utils "mount"
program is way too low for "soft" on UDP.

Cheers,
  Trond

BTW: 2.4.23 has no readdir changes at all compared to 2.4.21. I've no
idea WTF 2.4.23-pac1 contains...
