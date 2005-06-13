Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVFMOdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVFMOdI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 10:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVFMOdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 10:33:08 -0400
Received: from gs.bofh.at ([193.154.150.68]:33232 "EHLO gs.bofh.at")
	by vger.kernel.org with ESMTP id S261431AbVFMOdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 10:33:02 -0400
Subject: Re: A Great Idea (tm) about reimplementing NLS.
From: Bernd Petrovitsch <bernd@firmix.at>
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <f1929877050613065461ad3253@mail.gmail.com>
References: <f192987705061303383f77c10c@mail.gmail.com>
	 <1118664352.898.16.camel@tara.firmix.at>
	 <f1929877050613065461ad3253@mail.gmail.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 13 Jun 2005 16:32:55 +0200
Message-Id: <1118673175.898.55.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 17:54 +0400, Alexey Zaytsev wrote:
> On 13/06/05, Bernd Petrovitsch <bernd@firmix.at> wrote:
> > On Mon, 2005-06-13 at 14:38 +0400, Alexey Zaytsev wrote:
> > [ Filenames with another encoding ]
> > > Some would suggest not to use non-ascii file names at all, some would
> > > say that I should temporary change my locale, some could even offer me
> > > a perl script they wrote when faced the same problem. All these
> > > solutions are inconvenient and conflict with fundamental VFS concepts.
> >                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > In what way?
> > Basically you just rename the files. How can this conflict with
> > "fundamental VFS concepts" (and with which).
> 
> I can't rename files on Pupkin's drive because he won't like it. ;)

.... which has IMHO nothing to do with the VFS (or concepts behind it).

> In the case with a flash drive I can copy all the files to my computer
> and rename them, but I can't do it with a bigger media like hard disk.

You forgot CDs/DVDs and other inherently read-only media with such
strange filenames.

> The main idea of VFS is that you can access your files in the same way
> on any supported file system. But actually you can't simple access
> different-encoded non-ascii files on a filesystem that has no NLS,
> like ext or reiser.

I don't think that any filesystem knows about the encoding of every
filename - after all it is up to the user which encoding he uses for a
given file (and no, no one forces me to use the same encoding on the
names of all of "mine" files).
IOW given a FAT filesystem on an USB stick, which codepage should be
used?

Perhaps it makes sense to start a prototype with a FUSE (or similar)
module. You could use standard libs to convert without messing around in
the kernel (and I don't think someone wants to have an encoding
conversion layer in the kernel).

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

