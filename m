Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbTEYUpP (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 16:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbTEYUpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 16:45:15 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:55558
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263771AbTEYUpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 16:45:13 -0400
Date: Sun, 25 May 2003 13:55:11 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Willy Tarreau <willy@w.ods.org>,
   Marcelo Tosatti <marcelo@conectiva.com.br>,
   lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc3 : IDE pb on Alpha
Message-ID: <20030525205511.GC23651@matchmail.com>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Willy Tarreau <willy@w.ods.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <20030525203709.GA23651@matchmail.com> <Pine.SOL.4.30.0305252242430.10573-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0305252242430.10573-100000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 25, 2003 at 10:45:00PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Sun, 25 May 2003, Mike Fedyk wrote:
> 
> > On Sun, May 25, 2003 at 07:00:46PM +0200, Willy Tarreau wrote:
> > > hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> > > hda: task_no_data_intr: error=0x04 { DriveStatusError }
> >
> > Can you revert back to your previous kernel and run badblocks read-only on
> > it a few times.  Your drive may be going bad.
> 
> 
> 
> Everything is okay, older drives don't understand some commands.
> I will fix it, but now its low on my TODO list.
> 

Bart, is there any chace you could change the printks to show the name of
the command that caused the drive to produce the error (assuming non
ide-tcq, with tcq I'd immagine that it'd be a bit harder).

This way someone who hasn't read the IDE spec might be able to tell that
this isn't a warning of impending failure.

BTW, is this information encoded in the two lines above somewhere, and if so
how would I read it?

Thanks,

Mike
