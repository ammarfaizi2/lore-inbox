Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129985AbRBSRad>; Mon, 19 Feb 2001 12:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129785AbRBSRaY>; Mon, 19 Feb 2001 12:30:24 -0500
Received: from slc921.modem.xmission.com ([166.70.6.159]:36617 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129985AbRBSRaJ>; Mon, 19 Feb 2001 12:30:09 -0500
To: Martin Rode <Martin.Rode@programmfabrik.de>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.1 crashes every two days, oopses included
In-Reply-To: <Pine.LNX.4.31.0102151645110.25331-100000@localhost.localdomain> <3A90E072.BCF45429@programmfabrik.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Feb 2001 10:17:31 -0700
In-Reply-To: Martin Rode's message of "Mon, 19 Feb 2001 09:59:30 +0100"
Message-ID: <m1elwu1tjo.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Rode <Martin.Rode@programmfabrik.de> writes:

> Rik van Riel wrote:
> 
> > On Thu, 15 Feb 2001, Martin Rode wrote:
> >
> > > My last bug report did not seem to attract to much attention.
> >
> > > For now we have switched back to 2.2.18 which stays up for about
> > > a week before it crashes because of the VM too.
> >
> > [snip]
> > > VM: reclaim_page, wrong page on list.
> > > VM: refill_inactive, wrong page on list.
> > > Unable to handle kernel paging request at virtual address 00002208
> >
> > Since:
> > 1. you see this kind of bug with both 2.2 and the completely
> >    changed 2.4 VM code  and
> > 2. this bug usually only happens when people have RAM problems,
> >
> > could you try running memtest86 on that machine to see if it indeed
> > has memory errors or if the problem is coming from somewhere else ?
> 
> Hello Rik,
> 
> my maschine has spent the entire week-end running memtest86. It ran for
> over 60 hours with all tests and it finished 3 passes with 0 errors.
> 
> Here's one more interesting aspect about the behaviour I'm seeing:
> 
> with 256 MB RAM:
> 
> <= 2.2.18: > 7 days, crashes randomly, no pattern.
> >= 2.2.19pre2: 1 hour. Crashes as soon as I start hylafax daemon,
> reproducable.
> 
> 
> with 512 MB RAM
> 
> <= 2.2.18: same behaviour as with 2.4.1
> 2.4.1: Stands up 1 day, crashes as soon as arekeia has started the
> backup (happend twice, second oopses included in my last mail)
> 
> 
> Is there anything I can do? Is my problem kernel related? I believe
> somehow it is. Is my maschine busted?

You might want to double check that you have either disabled power
management or that you at least are not using memory it is using.

I ran into one motherboard that would not disable power management but
with default settings did not report which memory it was using for
power management.  Eventually I enabled ACPI and that helped.

Eric

