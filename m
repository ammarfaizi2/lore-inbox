Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261713AbSJMWgt>; Sun, 13 Oct 2002 18:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261738AbSJMWgt>; Sun, 13 Oct 2002 18:36:49 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:22440 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S261713AbSJMWgs>; Sun, 13 Oct 2002 18:36:48 -0400
Message-Id: <200210132242.g9DMgVng334662@pimout3-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Date: Sun, 13 Oct 2002 13:32:34 -0400
X-Mailer: KMail [version 1.3.1]
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com> <20021012012807.1BB5B635@merlin.webofficenow.com> <3DA7F385.3040409@namesys.com>
In-Reply-To: <3DA7F385.3040409@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 October 2002 06:03 am, Hans Reiser wrote:
> Rob Landley wrote:
> >I'm also looking for an "unmount --force" option that works on something
> >other than NFS.  Close all active filehandles (the programs using it can
> > just deal with EBADF or whatever), flush the buffers to disk, and
> > unmount.  None of this "oh I can't do that, you have a zombie process
> > with an open file...", I want  "guillotine this filesystem pronto,
> > capice?" behavior.
>
> This sounds useful.  It would be nice if umount prompted you rather than
> refusing.

The problem here is that umount(2) doesn't take a flag.  I'd be happy to have 
it fail unless called with the WITH_EXTREME_PREJUDICE flag or some such, but 
that's an API change.

Of course I haven't gotten that far yet, but eventually this will have to be 
dealt with...

Rob
