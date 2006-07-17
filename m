Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWGQVMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWGQVMP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 17:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWGQVMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 17:12:15 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:60093 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751198AbWGQVML
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 17:12:11 -0400
Date: Mon, 17 Jul 2006 23:07:11 +0200
To: Christian Trefzer <ctrefzer@gmx.de>
Cc: Xavier Roche <roche+kml2@exalead.com>, linux-kernel@vger.kernel.org
Subject: Re: reiserFS?
Message-ID: <20060717210710.GB6803@aitel.hist.no>
References: <20060716161631.GA29437@httrack.com> <20060716162831.GB22562@zeus.uziel.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060716162831.GB22562@zeus.uziel.local>
User-Agent: Mutt/1.5.11+cvs20060403
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2006 at 06:28:31PM +0200, Christian Trefzer wrote:
> On Sun, Jul 16, 2006 at 06:16:31PM +0200, Xavier Roche wrote:
> > > It simply the best filesystem for many kinds of usage patterns.
> > 
> > The most frightening too. Reiserfs might be suitable for very specific
> > appliactions, but to use it in production machine, you need to have
> > some guts.
> > 
> > My last reiserfs partition was blown up two days ago, because of a bad
> > sector, plus a fatal oops, looping endlessly. This was the second
> > time, and the last one, as none of my ext3 filesystems *ever* had
> > similar problems, despite numerous other bad sector issues. Not
> > mentionning the funny "recovery" tool, which generally finishes to
> > trash your data.
> 
> I don't quite understand. You are supposed to dd_rescue the whole block
> device to a working drive and use fsck on the copy.  Whatever is lost in
> the process must of course be restored from a recent backup. But, as a
> friend of mine put it recently, people don't need backup, they only need
> restore ; )
>
Well, many a home user simply doesn't have a a spare block device of 
the same size.  The hassle of reinstalling instead of just waiting
out a fsck is something still.  

The ext filesystems are nice in that they have spare superblocks,
if the main one dies from a bad sector, the spares still work
so you don't loose the entire fs to only a few damaged sectors.

> fsck on a faulty drive might cause even more damage - how do you know
> that other areas of the device are OK? 
>
Somehow, that has saved my day quite a few times with ext2.
I only lost a few files, then went shopping for a new disk. :-)

Helge Hafting
