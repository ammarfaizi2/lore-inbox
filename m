Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262898AbTCKLQi>; Tue, 11 Mar 2003 06:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262899AbTCKLQi>; Tue, 11 Mar 2003 06:16:38 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:773 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S262898AbTCKLQh>; Tue, 11 Mar 2003 06:16:37 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303111127.h2BBRrnE003336@81-2-122-30.bradfords.org.uk>
Subject: Re: [Ext2-devel] Re: [RFC] Improved inode number allocation for HTree
To: jakob@unthought.net (Jakob Oestergaard)
Date: Tue, 11 Mar 2003 11:27:53 +0000 (GMT)
Cc: willy@debian.org, bos@serpentine.com, phillips@arcor.de,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       tytso@mit.edu, adilger@clusterfs.com, chrisl@vmware.com,
       bzzz@tmi.comex.ru
In-Reply-To: <20030311084736.GE14814@unthought.net> from "Jakob Oestergaard" at Mar 11, 2003 09:47:36 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Why start?  Who actually uses atime for anything at all, other than the
> > > tiny number of shops that care about moving untouched files to tertiary
> > > storage?

What about the situation where the primary storage is a device which
has a limited number of write-cycles.  That's just the sort of
application where you might be archiving data to secondary or tertiary
storage, and it would be a big advantage to save on writes.  If a file
is read every ten minutes, we could just update the atime once an
hour.  That would save five writes an hour.

John.
