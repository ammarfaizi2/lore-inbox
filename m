Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbTFJHjs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 03:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbTFJHjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 03:39:48 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:10624 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262424AbTFJHjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 03:39:47 -0400
Date: Tue, 10 Jun 2003 08:53:46 +0100
From: john@grabjohn.com
Message-Id: <200306100753.h5A7rk0e000377@81-2-122-30.bradfords.org.uk>
To: core@enodev.com, ms@citd.de
Subject: Re: cachefs on linux
Cc: leoh@dcc.ufmg.br, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anyway, linux also does not have unionFS. If it was that big of a deal,
> someone would write it. As it is, it's a whizbang no one cares about enough.

BSD has had a UnionFS for a while now, by the way.

There are a lot of things we _could_ add to filesystems, E.G.:

* Appending to a read-only filesystem on a separate volume

* File versioning

* Transparent, variable compression

* Format conversion, (I.E. write a png file to a filesystem, and it is
			   automatically visible as half a dozen other
			   formats, without them actually existing on
			   the disk)

* Priorities, (E.G. temp files could have a bit to indicate that we
		    don't really care how long they remain in
		    write-cache, instead of flushing them along with
		    other more-important-to-get-to-the-oxide data)

* WORM mode, (I.E. start at block 1 and use blocks sequentially, never
		   re-using blocks - makes a tape somewhat usable as a
		   block device)

Some of these are available in some form or another already.  There is
plenty we can do, given enough time :-).

John.
