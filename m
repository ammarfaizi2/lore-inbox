Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbVK2Jas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbVK2Jas (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 04:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbVK2Jas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 04:30:48 -0500
Received: from cantor.suse.de ([195.135.220.2]:50157 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750951AbVK2Jar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 04:30:47 -0500
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
References: <11b141710511210144h666d2edfi@mail.gmail.com>
	<20051121095915.83230.qmail@web36406.mail.mud.yahoo.com>
	<20051121101959.GB13927@wohnheim.fh-wedel.de>
	<20051128125351.GE30589@marowsky-bree.de>
	<20051129050439.GB22879@thunk.org>
From: Andi Kleen <ak@suse.de>
Date: 29 Nov 2005 06:58:55 -0700
In-Reply-To: <20051129050439.GB22879@thunk.org>
Message-ID: <p73zmnnh7xc.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o <tytso@mit.edu> writes:

> On Mon, Nov 28, 2005 at 01:53:51PM +0100, Lars Marowsky-Bree wrote:
> > On 2005-11-21T11:19:59, J?rn Engel <joern@wohnheim.fh-wedel.de> wrote:
> > 
> > > o Merge of LVM and filesystem layer
> > >   Not done.  This has some advantages, but also more complexity than
> > >   seperate LVM and filesystem layers.  Might be considers "not worth
> > >   it" for some years.
> > 
> > This is one of the cooler ideas IMHO. In effect, LVM is just a special
> > case filesystem - huge blocksizes, few files, mostly no directories,
> > exports block instead of character/streams "files".
> 
> This isn't actually a new idea, BTW.  Digital's advfs had storage
> pools and the ability to have a single advfs filesystem spam multiple
> filesystems, and to have multiple adv filesystems using storage pool,
> something like ten years ago.

The old JFS code base had something similar before it got ported
to Linux (I believe it came from OS/2). But it was removed.
And miguel did a prototype of it with ext2 at some point long ago.

But to me it's unclear it's a really good idea. Having at least the option
to control where physical storage is placed is nice, especially 
if you cannot mirror everything (ZFS seems to assume everything is mirrored)
And separate devices and LVM make that easier.

-Andi
