Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261455AbTCJUwR>; Mon, 10 Mar 2003 15:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbTCJUwR>; Mon, 10 Mar 2003 15:52:17 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:773 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S261455AbTCJUwQ>; Mon, 10 Mar 2003 15:52:16 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303102104.h2AL43iZ000875@81-2-122-30.bradfords.org.uk>
Subject: Re: [RFC] Improved inode number allocation for HTree
To: phillips@arcor.de (Daniel Phillips)
Date: Mon, 10 Mar 2003 21:04:03 +0000 (GMT)
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       tytso@mit.edu, adilger@clusterfs.com, chrisl@vmware.com,
       bzzz@tmi.comex.ru
In-Reply-To: <20030310204431.9C72D103F6D@mx12.arcor-online.net> from "Daniel Phillips" at Mar 10, 2003 09:48:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Though the journal only becomes involved when blocks are modified,
> unfortunately, because of atime updates, this includes all directory
> operations.  We could suggest to users that they should disable
> atime updating if they care about performance, but we ought to be
> able to do better than that.

On a separate note, since atime updates are not usually very important
anyway, why not have an option to cache atime updates for a long time,
or until either a write occurs anyway.  Holding a large number of
atime updates in a write cache is generally not going to be a major
issue - the worst case if a partition isn't cleanly unmounted is that
some atimes will be wrong.

John.
