Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261987AbTCLWHw>; Wed, 12 Mar 2003 17:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262000AbTCLWHw>; Wed, 12 Mar 2003 17:07:52 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:40197 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S261987AbTCLWHu>; Wed, 12 Mar 2003 17:07:50 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303122220.h2CMKShH001833@81-2-122-30.bradfords.org.uk>
Subject: Re: bio too big device
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 12 Mar 2003 22:20:28 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0303121111440.15738-100000@home.transmeta.com> from "Linus Torvalds" at Mar 12, 2003 11:14:52 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Couldn't we have a list of known good drives, though, and enable 256
> > sectors as a special case?
> 
> My problem is that I just don't see the point. What's the difference 
> between 256 and 254 sectors? 128kB vs 127kB? 

Ah, I thought there was a reason that it was a Good Thing to keep it
as a power of 2, which would mean 64kB vs 128kB, but if not then I
totally agree.

> Also, looking closer, the current limit actually seems to be _controller_
> dependent, not disk-dependent. I don't know how valid that is, but it
> looks reasonable at least in theory - while the IDE controller is mostly a
> passthrough thing, it does end up doing part of the work. So the picture
> look smore complex than just another drive blacklist.
> 
> In short, the headaches just aren't worth the 127->128kB gain.

I wasn't aware of the controller issue - with that thrown in to the
mix, I see your point.

John.
