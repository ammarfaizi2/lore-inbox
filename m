Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266155AbUFYBrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266155AbUFYBrQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 21:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266157AbUFYBrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 21:47:16 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:24715 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S266155AbUFYBrP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 21:47:15 -0400
Subject: Re: [RFC] Patch to allow distributed flock
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ken Preslan <kpreslan@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1088127425.8906.40.camel@lade.trondhjem.org>
References: <20040624231057.GA13033@potassium.msp.redhat.com>
	 <1088121132.8906.29.camel@lade.trondhjem.org>
	 <20040625000720.GA13755@potassium.msp.redhat.com>
	 <1088127425.8906.40.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1088128034.8906.49.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 24 Jun 2004 21:47:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På to , 24/06/2004 klokka 21:37, skreiv Trond Myklebust:
> På to , 24/06/2004 klokka 20:07, skreiv Ken Preslan:
> 
> > If the FS is managing the posix locks and/or flocks, is there really a
> > reason to acquire the VFS versions of the locks too?  As long as there is
> > some bit set that tells the VFS to call down into the FS to unlock the
> > locks on process exit, keeping both sets of locks seems wasteful.
> > What am I missing?

...Oh I forgot to mention --- If you want to support mandatory locks (?)
then the VFS interface can serve as a billboard for posting those
regions of the file that are off-limits to other processes.

Cheers,
  Trond
