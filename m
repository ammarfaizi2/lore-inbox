Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270533AbRHHRRR>; Wed, 8 Aug 2001 13:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270527AbRHHRQ5>; Wed, 8 Aug 2001 13:16:57 -0400
Received: from web13603.mail.yahoo.com ([216.136.175.114]:48905 "HELO
	web13603.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S270528AbRHHRQw>; Wed, 8 Aug 2001 13:16:52 -0400
Message-ID: <20010808171702.57332.qmail@web13603.mail.yahoo.com>
Date: Wed, 8 Aug 2001 10:17:02 -0700 (PDT)
From: Ivan Kalvatchev <iive@yahoo.com>
Subject: Re: [Patch2] Re: DoS with tmpfs #3
To: linux-kernel@vger.kernel.org
In-Reply-To: <m37kwg5jb1.fsf_-_@linux.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Christoph Rohland <cr@sap.com> wrote:
> Hi ,
> 
> On 06 Aug 2001, Christoph Rohland wrote:
> > Since there are enough persons having trouble with
> the current
> > behaviour I append a patch (against 2.4.8-pre4) to
> implement the
> > default to be ram/2.

I didn't look at the chages but i will say this one
more time. Limiting tmpfs size at fixed amount of
space will make the bug harder to reproduce but won't
fix it. The right hack is to limit tmpfs to be with
freepages.high less than available memory(swap+ram).
It won't be hard to code. 
More, there is a big with parameter checking, then i
try to limit with nr_blocks i limit my tmpfs to
160Mpages. So put and sanity check.

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
