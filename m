Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131582AbQKJVg5>; Fri, 10 Nov 2000 16:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131647AbQKJVgr>; Fri, 10 Nov 2000 16:36:47 -0500
Received: from [194.213.32.137] ([194.213.32.137]:18948 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131582AbQKJVgk>;
	Fri, 10 Nov 2000 16:36:40 -0500
Message-ID: <20001110155800.B33@bug.ucw.cz>
Date: Fri, 10 Nov 2000 15:58:00 +0100
From: Pavel Machek <pavel@suse.cz>
To: "James A. Sutherland" <jas88@cam.ac.uk>, Andi Kleen <ak@suse.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <andrewm@uow.edu.au>, Oliver Xymoron <oxymoron@waste.org>,
        barryn@pobox.com, linux-kernel@vger.kernel.org,
        jamal <hadi@cyberus.ca>
Subject: Re: [PATCH] document ECN in 2.4 Configure.help
In-Reply-To: <3A068C00.272BD5D2@uow.edu.au> <E13sk36-00066o-00@the-village.bc.nu> <20001106121153.A14104@gruyere.muc.suse.de> <00110613333600.01541@dax.joh.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <00110613333600.01541@dax.joh.cam.ac.uk>; from James A. Sutherland on Mon, Nov 06, 2000 at 01:31:23PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > >        with the TCP ECN_ECHO and CWR flags set, to indicate
> > > >        ECN-capability, then the sender should send its second
> > > >        SYN packet without these flags set. This is because
> > > 
> > > Now that is nice. The end user perceived effect is that folks with faulty 
> > > firewalls have horrible slow web sites with a 3 or 4 second wait for each
> > > page. The perfect incentive. If only someone could do the same to path mtu
> > > discovery incompetents.
> > 
> > And it penalizes good guys.
> > If the host cannot answer to the first SYN for some legitimate reason 
> > then it'll never be able to use ECN. 
> 
> It could be a good idea to retry as normal with ECN set; iff that fails
> (so the user would normally see an error connecting) try again with
> ECN clear. This way, ECN-capable hosts will only see non-ECN
> connections under circumstances where the connection would
> otherwise have failed completely.

Hmm, so you want to wait 5 minutes for your TCP connection? TCP
retries for _long_ time.

I do not think that's such a good idea.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
