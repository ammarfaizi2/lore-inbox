Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286826AbSABJTq>; Wed, 2 Jan 2002 04:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286821AbSABJTh>; Wed, 2 Jan 2002 04:19:37 -0500
Received: from colorfullife.com ([216.156.138.34]:22795 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S286842AbSABJTb>;
	Wed, 2 Jan 2002 04:19:31 -0500
Message-ID: <002501c1936e$974d0f60$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Neil Brown" <neilb@cse.unsw.edu.au>
Cc: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <3C32260E.CEADDF59@colorfullife.com> <15410.35800.154586.201540@notabene.cse.unsw.edu.au>
Subject: Re: [RFC] event cleanup, part 2
Date: Wed, 2 Jan 2002 10:19:05 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Neil Brown" <neilb@cse.unsw.edu.au>
> On Tuesday January 1, manfred@colorfullife.com wrote:
> > Linus merged the first part of my patches that remove
> > 'event' into 2.5.2-pre3.
> > 
> > Attached is the second patch.
> > 
> > patch 1: remove all event users except readdir().
> > Merged.
> 
> Not quite.  ext2 and ext3 (At least) use event to set i_generation to
> a pseudo-random number, and that still seems to be so in 2.5.2-pre6.
> What do you plan to do with that usage of event?
> Possibly replacing it with net_random or similar would be fine.
>

I've replaced i_generation with a random number in ext2, that change
is part of 2.5.2-pre6.
I've sent the patch to ext3 to the maintainers.

--
    Manfred

