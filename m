Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUHNUSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUHNUSf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 16:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265053AbUHNUSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 16:18:35 -0400
Received: from dh138.citi.umich.edu ([141.211.133.138]:60034 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S265051AbUHNUSd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 16:18:33 -0400
Subject: Re: PATCH [2/7] Fix posix locking code
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Matthew Wilcox <willy@debian.org>
Cc: Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040814200048.GV12936@parcelfarce.linux.theplanet.co.uk>
References: <1092511792.4109.22.camel@lade.trondhjem.org>
	 <20040814200048.GV12936@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1092514711.4109.50.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 14 Aug 2004 16:18:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På lau , 14/08/2004 klokka 16:00, skreiv Matthew Wilcox:

> I know I said I thought file_lock_operations was the right thing to
> do ...  but now I think that this isn't a property of the file_lock so
> much as it is a property of the underlying filesystem.  I think putting a
> lock_operations into struct file is maybe a bit much.  How about adding
> a lock_operations pointer to file_operations?

Lock operations are as much a property of the lock *type*. A BSD lock
may/will have an entirely different set of callbacks.

Trond
