Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129351AbRB0Anq>; Mon, 26 Feb 2001 19:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129350AbRB0An1>; Mon, 26 Feb 2001 19:43:27 -0500
Received: from [204.244.205.25] ([204.244.205.25]:18246 "HELO post.gateone.com")
	by vger.kernel.org with SMTP id <S129329AbRB0AnH>;
	Mon, 26 Feb 2001 19:43:07 -0500
From: Michael Peddemors <michael@linuxmagic.com>
Reply-To: michael@linuxmagic.com
Organization: Wizard Internet Services
To: Craig Milo Rogers <rogers@ISI.EDU>
Subject: Re: [UPDATE] zerocopy.. While working on ip.h stuff
Date: Mon, 26 Feb 2001 17:53:30 -0800
X-Mailer: KMail [version 1.1.95.0]
Content-Type: text/plain
In-Reply-To: <2137.983232656@ISI.EDU>
In-Reply-To: <2137.983232656@ISI.EDU>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <0102261753300I.02007@mistress>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2001, Craig Milo Rogers wrote:

> > > I have a whole 40 bytes (+/-) to share...  Now although I don't see
> > > anything explicitly prohibiting the use of unused IP Header option 
..
> > > in between.. Has anyone seen any RFC that explicitly says I MUST NOT?
> >
> >Not to my knowledge.  Routers already change the time to live field,
> >so I see no reason why they can't do smart things with special IP
> >options either (besides efficiency concerns :-).

I know they 'rewrite/extend' existing options, but have never seen a case 
where a router adds an option to a packet beyond those based on what the 
original sender set..

> I've forgotten how the Stream ID option was implemented, but I
> won't be surprised if a router inserted it on the fly (but it was
> probably inserted by end systems).  On the other hand, there was also

Hmm, have to look at a little history..

> a competing philosophy that said that the IP checksum must be
> recomputed incrementally at routers to catch hardware problems in the
> routers, and an incremental recomputation when changing the size of
> the header would be more work.

ah.. we do recalculate IP Checksums now..  when we update any of the 
timestamp rr options etc..

> The one thing I would worry about is unleashing mutant IP
> packets upon the world at large.  I hope the proposed experiments have
> a very good firewall.  It would be very nice to attempt to acquire an
> officially blessed IP option number for such experiments before
> unleashing these packets upon an unprepared world.
>
> 					Craig Milo Rogers

Ah, we better have a good firewall <wink> No, if this goes past concept 
phase, we will try for de official bless.



-- 
"Catch the magic of Linux...."
--------------------------------------------------------
Michael Peddemors - Senior Consultant
Unix Administration - WebSite Hosting
Network Services - Programming
Wizard Internet Services http://www.wizard.ca
Linux Support Specialist - http://www.linuxmagic.com
--------------------------------------------------------
(604) 589-0037 Beautiful British Columbia, Canada
--------------------------------------------------------
