Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292303AbSBBPff>; Sat, 2 Feb 2002 10:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292304AbSBBPfZ>; Sat, 2 Feb 2002 10:35:25 -0500
Received: from mailb.telia.com ([194.22.194.6]:12813 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S292303AbSBBPfO>;
	Sat, 2 Feb 2002 10:35:14 -0500
Message-Id: <200202021535.g12FZ1417639@mailb.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, Jens Axboe <axboe@suse.de>
Subject: Re: Errors in the VM - detailed (or is it Tux? or rmap? or those together...)
Date: Sat, 2 Feb 2002 16:31:59 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
        Tux mailing list <tux-list@redhat.com>
In-Reply-To: <Pine.LNX.4.30.0202021619050.10720-200000@mustard.heime.net>
In-Reply-To: <Pine.LNX.4.30.0202021619050.10720-200000@mustard.heime.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturdayen den 2 February 2002 16.22, Roy Sigurd Karlsbakk wrote:
> > > Problem #2 is _the_ worst problem, as it makes the server more-or-less
> > > unusable
> >
> > Please send sysrq-t traces for such stuck processes. It's _impossible_
> > to guess whats going on from here, the crystal ball just isn't good
> > enough :-)
>
> Decoded sysrq+t is attached.
>
> I've found only the first 60 wget processes started from the remote
> machine is being serviced. After they are done, Tux hangs, using 100%
> system time, still open on port ## (80), but doesn't do anything.
>
> I don't understand anything...

I have reread the first mail in this series - I would say that Bug#2 is much
worse than Bug#1. This since Bug#1 is "only" a performance problem,
but Bug#2 is about correctness...

Are you 100% sure that tux works with rmap?

I would suggest testing the simplest possible case.
* Standard kernel
* concurrent dd:s

What can your problem be:
* something to do with the VM - but the problem is in several different VMs...
* something to do with read ahead? you got some patch suggestions -
  please use them on a standard kernel, not rmap (for now...)

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
