Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267330AbUIARJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267330AbUIARJs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 13:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267235AbUIARFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 13:05:39 -0400
Received: from dh138.citi.umich.edu ([141.211.133.138]:7052 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S267330AbUIARDo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 13:03:44 -0400
Subject: Re: NFS problem with 2.6.9-rc1-bk7
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Harry Edmon <harry@atmos.washington.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200409011606.i81G6EGG016287@moist.atmos.washington.edu>
References: <200409011606.i81G6EGG016287@moist.atmos.washington.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1094058222.8528.45.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 01 Sep 2004 13:03:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På on , 01/09/2004 klokka 12:06, skreiv Harry Edmon:
> I have been trying newer versions of the kernel on a web/NFS server
> tofix memory problems that seem to be associated with NFS for all
> 2.6versions through 2.6.8.1-mm4.  Andrew Morton suggested I try the
> latestsnapshot.  With this version (2.6.9-rc1-bk7) I have the problem
> that NFSclients will spontaneously find themselves without permission
> to accessthe files on the server.  When I type "exportfs -ar" on the
> server, theclients get better for awhile, and then fail.  The message
> I see on theserver is:
> 
> Sep  1 08:17:57 funnel rpc.mountd: getfh failed: Operation not
> permitted

Looks like that is more of a question for Neil Brown than for me.

That said 2.6 kernels require more recent versions of nfs-utils, and
require you to mount the "nfsd" pseudofilesystem on /proc/fs/nfsd or
/proc/fs/nfs (see the "exportfs" manpage). Have you checked that this is
indeed the case?

Cheers,
  Trond
