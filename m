Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137109AbRA1OTu>; Sun, 28 Jan 2001 09:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137171AbRA1OTk>; Sun, 28 Jan 2001 09:19:40 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:49916 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S137109AbRA1OTZ>; Sun, 28 Jan 2001 09:19:25 -0500
Message-ID: <3A742C27.4E179E83@uow.edu.au>
Date: Mon, 29 Jan 2001 01:26:47 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Huey <billh@gnuppy.monkey.org>
CC: yodaiken@fsmlabs.com, Nigel Gamble <nigel@nrg.org>,
        linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <200101220150.UAA29623@renoir.op.net> <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org> <20010128061428.A21416@hq.fsmlabs.com>,
		<20010128061428.A21416@hq.fsmlabs.com>; from yodaiken@fsmlabs.com on Sun, Jan 28, 2001 at 06:14:28AM -0700 <20010128060704.A2181@gnuppy.monkey.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey wrote:
> 
> Andrew Morton's patch uses < 10 rescheduling points (maybe less from memory)

err... It grew.  More like 50 now reiserfs is in there.  That's counting
real instances - it's not counting ones which are expanded multiple times
as "1".

It could be brought down to 20-25 with good results.  It seems to have
a 1/x distribution - double the reschedule count, halve the latency.
We're currently doing 300-400 usecs.

I think a 1.5-millisecond @ 500MHz kernel would be a good, maintainable
solution and a sensible compromise.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
