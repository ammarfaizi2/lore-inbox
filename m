Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbVKUKUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbVKUKUE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 05:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVKUKUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 05:20:04 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:24551 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932255AbVKUKUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 05:20:03 -0500
Date: Mon, 21 Nov 2005 11:19:59 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Alfred Brons <alfredbrons@yahoo.com>
Cc: pocm@sat.inesc-id.pt, linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
Message-ID: <20051121101959.GB13927@wohnheim.fh-wedel.de>
References: <11b141710511210144h666d2edfi@mail.gmail.com> <20051121095915.83230.qmail@web36406.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051121095915.83230.qmail@web36406.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 November 2005 01:59:15 -0800, Alfred Brons wrote:
> 
> I wasn't aware of this thread.
> 
> But my question was: do we have similar functionality
> in Linux kernel?

If you have a simple, technical list of the functionality, your
question will be easily answered.  I still haven't found the time to
dig for all the information underneith the marketing blur.

o Checksums for data blocks
  Done by jffs2, not done my any hard disk filesystems I'm aware of.

o Snapshots
  Use device mapper.
  Some log structured filesystems are also under development.  For
  them, snapshots will be trivial to add.  But they don't really exist
  yet.  (I barely consider reiser4 to exist.  Any filesystem that is
  not considered good enough for kernel inclusion is effectively still
  in development phase.)

o Merge of LVM and filesystem layer
  Not done.  This has some advantages, but also more complexity than
  seperate LVM and filesystem layers.  Might be considers "not worth
  it" for some years.

o 128 bit
  On 32bit machines, you can't even fully utilize a 64bit filesystem
  without VFS changes.  Have you ever noticed?  Thought so.

o other
  Dunno, what else they do.  There's the official marketing feature
  lists, but that's rather useless for comparisons.

Jörn

-- 
Measure. Don't tune for speed until you've measured, and even then
don't unless one part of the code overwhelms the rest.
-- Rob Pike
