Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129230AbRBANkU>; Thu, 1 Feb 2001 08:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129171AbRBANkK>; Thu, 1 Feb 2001 08:40:10 -0500
Received: from smtp.mountain.net ([198.77.1.35]:24339 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S129168AbRBANkC>;
	Thu, 1 Feb 2001 08:40:02 -0500
Message-ID: <3A79671B.8A1BD249@mountain.net>
Date: Thu, 01 Feb 2001 08:39:39 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Ford <david@linux.com>,
        Stephen Frost <sfrost@snowman.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x and SMP fails to compile (`current' undefined)
In-Reply-To: <Pine.LNX.4.10.10102010011530.15351-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
> Make it and I will care and post it on kernel.org for you.
> I need that patch soon.
> 
> On Thu, 1 Feb 2001, Tom Leete wrote:
> 
> > Alan Cox wrote:
> > > The string.h code was fine, someone came along and put in a ridiculous loop
> > > in the include dependancies and broke it. Nobody has had the time to untangle
> > > it cleanly since
> >
> > Yes, bitrot. I don't see a rearrangement of system headers happening in 2.4.
> > I'm pretty sure if I committed such a patch it would have no measurable
> > lifetime.

Hi Andre,

I meant that nobody should be reshuffling 2.4 headers now, didn't intend to
sound like I take that personally.

I'll take a look. I may be able to do something with include guards or other
#defines + multiple passes. We already have the multiple passes.

I think my arguments for the present patch are good. I'm making a mod of
Arjan's athlon.c to see if I'm right. If you have a suggestion for another
benchmark, I'd like to hear about it. Whatever the results, I'll post them
here.

Glad if whatever comes out is useful to you.

Cheers,
Tom

-- 
The Daemons lurk and are dumb. -- Emerson
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
