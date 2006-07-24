Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWGXGqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWGXGqj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 02:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWGXGqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 02:46:39 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:29843 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751422AbWGXGqi
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 24 Jul 2006 02:46:38 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17604.27604.359464.181718@gargle.gargle.HOWL>
Date: Mon, 24 Jul 2006 10:42:28 +0400
To: "Joshua Hudson" <joshudson@gmail.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: what is necessary for directory hard links
Newsgroups: gmane.linux.kernel
In-Reply-To: <bda6d13a0607211457k596e912fx845c68c2daa298f6@mail.gmail.com>
References: <bda6d13a0607201804je89fc3exd0b8f821509a3894@mail.gmail.com>
	<20060721202825.GB29656@robsims.com>
	<bda6d13a0607211457k596e912fx845c68c2daa298f6@mail.gmail.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
X-SystemSpamProbe: GOOD 0.0000027 d776fe7a47a557467e92ac3a17477a7e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Hudson writes:
 > Some people seem to think that I am proposing to do something.
 > Understand that I have done it for 2.6.17-rc4 and am currently
 > involved in bringing it forward to newer kernels.
 > 
 > >
 > > What is the parent of a hard linked directory?  What is the parent if
 > > the link in "the parent" is deleted?
 > 
 > The parent is any and all directories that contain a link to the
 > stated directory.  ".." points back along the path the referrer used
 > to reach the current directory (this behavior is already in kernel:
 > didn't have to lift a finger to get it).

That won't work for kernel NFS server, using ->get_parent() method to
obtain parent directory.

Well... this is probably the smallest problem with hard-linked
directories, though.

Nikita.

