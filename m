Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131228AbRCTXV4>; Tue, 20 Mar 2001 18:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131232AbRCTXVq>; Tue, 20 Mar 2001 18:21:46 -0500
Received: from vp175062.reshsg.uci.edu ([128.195.175.62]:18189 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S131228AbRCTXVa>; Tue, 20 Mar 2001 18:21:30 -0500
Date: Tue, 20 Mar 2001 15:20:39 -0800
Message-Id: <200103202320.f2KNKdF22559@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Doug Ledford <dledford@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: esound (esd), 2.4.[12] chopped up sound -- solved
In-Reply-To: <3AB7BB59.9513514C@redhat.com>
User-Agent: tin/1.5.7-20001104 ("Paradise Regained") (UNIX) (Linux/2.2.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2001 15:19:37 -0500, Doug Ledford <dledford@redhat.com> wrote:

> Why would esd get a short write() unless it is opening the file in non
> blocking mode (which I didn't see when I was working on the i810 sound
> driver)?  If esd is writing to a file in blocking mode and that write is
> returning short, then that sounds like a driver bug to me.

No, it's not a bug. It would be a bug if esd was writing to a *real* file
or if the write() returned -1 and an errno of EAGAIN. But incomplete writes
are very much ok.

Just try opening /dev/tty and see how it won't take writes of more than
2k (iirc). And that's not just on Linux, I've tested on Solaris and BSD
as well -- though it was a while ago.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
