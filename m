Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135671AbRDXPMt>; Tue, 24 Apr 2001 11:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135672AbRDXPMa>; Tue, 24 Apr 2001 11:12:30 -0400
Received: from theirongiant.weebeastie.net ([203.62.148.50]:56077 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S135671AbRDXPMV>; Tue, 24 Apr 2001 11:12:21 -0400
Date: Wed, 25 Apr 2001 01:11:32 +1000
From: CaT <cat@zip.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alexander Viro <viro@math.psu.edu>, "Mohammad A. Haque" <mhaque@haque.net>,
        ttel5535@artax.karlin.mff.cuni.cz,
        "Mike A. Harris" <mharris@opensourceadvocate.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
Message-ID: <20010425011132.H1245@zip.com.au>
In-Reply-To: <20010425004710.F1245@zip.com.au> <E14s4Hq-0002F0-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14s4Hq-0002F0-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Apr 24, 2001 at 03:59:28PM +0100
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 03:59:28PM +0100, Alan Cox wrote:
> What is this gid mail crap ? You don't need priviledge. You get the mail by
> asking the daemon for it. procmail needs no priviledge either if it is done
> right.
> 
> You just need to think about the security models in the right way. Linux gives
> you the ability to do authenticated uid/gid checking over a socket connection.
> That is an incredibly powerful model for real compartmentalisation.

Ok. My experience isn't all that great so I may well be missing something
here. But what?

1. email -> sendmail

2. sendmail figures out what it has to do with it. turns out it's deliver
it locally for user blah

3. sendmail starts procmail so that it delivers the email.

4. procmail goes through the recepie list for user blah and eventually
delivers the email (one way or another)

Now, in order for step 4 to be done safely, procmail should be running
as the user it's meant to deliver the mail for. for this to happen
sendmail needs to start it as that user in step 3 and to do that it
needs extra privs, above and beyond that of a normal user.

Now as I said, I'm not a UNIX God[tm] and so I may well be missing something
vital. If so, what is it? This sounds like something that would be way
useful to learn. :)

-- 
CaT (cat@zip.com.au)		*** Jenna has joined the channel.
				<cat> speaking of mental giants..
				<Jenna> me, a giant, bullshit
				<Jenna> And i'm not mental
					- An IRC session, 20/12/2000

