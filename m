Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265745AbUFDLpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265745AbUFDLpa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 07:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265747AbUFDLpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 07:45:30 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:42912 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265745AbUFDLpX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 07:45:23 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: ide errors in 7-rc1-mm1 and later
Date: Fri, 4 Jun 2004 13:48:55 +0200
User-Agent: KMail/1.5.3
Cc: Ed Tomlinson <edt@aei.ca>, linux-kernel@vger.kernel.org
References: <1085689455.7831.8.camel@localhost> <20040603193107.54308dc9.akpm@osdl.org> <20040604094256.GM1946@suse.de>
In-Reply-To: <20040604094256.GM1946@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406041348.55502.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 of June 2004 11:42, Jens Axboe wrote:
> On Thu, Jun 03 2004, Andrew Morton wrote:
> > Ed Tomlinson <edt@aei.ca> wrote:
> > > Hi,
> > >
> > > I am still getting these ide errors with 7-rc2-mm2.  I  get the errors
> > > even if I mount with barrier=0 (or just defaults).  It would seem that
> > > something is sending my drive commands it does not understand...
> > >
> > > May 27 18:18:05 bert kernel: hda: drive_cmd: status=0x51 { DriveReady
> > > SeekComplete Error } May 27 18:18:05 bert kernel: hda: drive_cmd:
> > > error=0x04 { DriveStatusError }
> > >
> > > How can we find out what is wrong?
> > >
> > > This does not seem to be an error that corrupts the fs, it just slows
> > > things down when it hits a group of these.  Note that they keep poping
> > > up - they do stop (I still get them hours after booting).
> >
> > Jens, do we still have the command bytes available when this error hits?
>
> It's not trivial, here's a hack that should dump the offending opcode
> though.

I bet it is WIN_FLUSH_CACHE_EXT.

