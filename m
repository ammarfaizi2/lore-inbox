Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTEYVKR (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 17:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263780AbTEYVKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 17:10:17 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:48265 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263777AbTEYVKP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 17:10:15 -0400
Date: Sun, 25 May 2003 23:23:01 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Willy Tarreau <willy@w.ods.org>,
   Marcelo Tosatti <marcelo@conectiva.com.br>,
   lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc3 : IDE pb on Alpha
In-Reply-To: <20030525205511.GC23651@matchmail.com>
Message-ID: <Pine.SOL.4.30.0305252304510.10573-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 25 May 2003, Mike Fedyk wrote:
> On Sun, May 25, 2003 at 10:45:00PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Sun, 25 May 2003, Mike Fedyk wrote:
> >
> > > On Sun, May 25, 2003 at 07:00:46PM +0200, Willy Tarreau wrote:
> > > > hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> > > > hda: task_no_data_intr: error=0x04 { DriveStatusError }
> > >
> > > Can you revert back to your previous kernel and run badblocks read-only on
> > > it a few times.  Your drive may be going bad.
> >
> >
> >
> > Everything is okay, older drives don't understand some commands.
> > I will fix it, but now its low on my TODO list.

> Bart, is there any chace you could change the printks to show the name of
> the command that caused the drive to produce the error (assuming non
> ide-tcq, with tcq I'd immagine that it'd be a bit harder).

For taskfile based IO its trivial, but IDE is not yet switched to it
(will be soon).

> This way someone who hasn't read the IDE spec might be able to tell that
> this isn't a warning of impending failure.

> BTW, is this information encoded in the two lines above somewhere, and if so
> how would I read it?

Only failed irq handler, drive status and error returned by drive.
"error = 0x04" means command aborted.

Regards,
--
Bartlomiej

> Thanks,
>
> Mike

