Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbRADWNf>; Thu, 4 Jan 2001 17:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131399AbRADWN3>; Thu, 4 Jan 2001 17:13:29 -0500
Received: from va-ext.webmethods.com ([208.234.160.252]:18752 "EHLO
	localhost.neuron.com") by vger.kernel.org with ESMTP
	id <S129370AbRADWNT>; Thu, 4 Jan 2001 17:13:19 -0500
Date: Thu, 4 Jan 2001 17:15:05 -0500 (EST)
From: <stewart@neuron.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <aviro@redhat.com>, "Marco d'Itri" <md@Linux.IT>,
        Jeff Lightfoot <jeffml@pobox.com>, Dan Aloni <karrde@callisto.yi.org>,
        Anton Blanchard <anton@linuxcare.com.au>
Subject: Re: test13-pre6
In-Reply-To: <20010104202330.J1290@redhat.com>
Message-ID: <Pine.LNX.4.10.10101041711540.2041-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stephen,

Have you or can you run these tests directly against a buffered block
device (bypassing the filesystem) and see if it still behaves correctly?
I have a Java app that does this and 2.4.0-prerelease shows a cumulative
sync() time. As I write more data, sync times take longer and longer
and never comes back down. It takes writing 30-50 megs cumulative (many
syncs along the way) to become noticable. Noticable are latencies in   
the 20-30 ms range (up from 0-1 at the start of the test). Eventually  
the test comes to a grinding halt with all of it's time spent in the 
kernel.

I don't know when this happened in 2.4.0-testxx, but 2.2.x does not
show this behavior.

stewart


On Thu, 4 Jan 2001, Stephen C. Tweedie wrote:

> Hi,
> 
> On Fri, Dec 29, 2000 at 04:25:43PM -0800, Linus Torvalds wrote:
> > 
> > Stephen: mind trying your fsync/etc tests on this one, to verify that the
> > inode dirty stuff is all done right?
> 
> Back from the Scottish Hogmanay celebrations now. :)  I've run my
> normal tests on this (based mainly on timing tests which show up
> exactly how much is being written to disk for 1000 iterations of
> various fsync/fdatasync/O_SYNC and overwrite/append combinations) and
> 2.4.0-prerelease seems to be doing the Right Thing.
> 
> My standard tests for this don't cover msync --- do you want me to
> give that a try too?
> 
> --Stephen
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
