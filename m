Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbVEYRz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbVEYRz3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 13:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVEYRyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 13:54:37 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:52700 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261503AbVEYRyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 13:54:09 -0400
Subject: Re: RT patch acceptance
From: Steven Rostedt <rostedt@goodmis.org>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, hch@infradead.org,
       nickpiggin@yahoo.com.au, bhuey@lnxw.com, dwalker@mvista.com,
       Sven Dietrich <sdietrich@mvista.com>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <m1br6zxm1b.fsf@muc.de>
References: <1116957953.31174.37.camel@dhcp153.mvista.com>
	 <20050524224157.GA17781@nietzsche.lynx.com>
	 <1116978244.19926.41.camel@dhcp153.mvista.com>
	 <20050525001019.GA18048@nietzsche.lynx.com>
	 <1116981913.19926.58.camel@dhcp153.mvista.com>
	 <20050525005942.GA24893@nietzsche.lynx.com>
	 <1116982977.19926.63.camel@dhcp153.mvista.com>
	 <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com>
	 <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu>
	 <m1br6zxm1b.fsf@muc.de>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 25 May 2005 13:52:50 -0400
Message-Id: <1117043570.10320.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-25 at 19:17 +0200, Andi Kleen wrote:
> I bet if you did a double blind test (users not knowing if they
> run with RT patch or not or think they are running with patch when they
> are not) they would report the same. 
> 

The double blind is a bad idea. It puts perceptions in the head where
they may say they see no improvement when there is.

A better test would be to have two identical computers running side to
side (say computer A and B). Let a number of people play around with
both for a while, with web browsing, movie viewing, mp3 listening, etc.
And then have a survey of which machine performed better and general
comments.  Don't let them even know about the RT patch, although one
would have it and the other would not.  That would probably be the best
indication of whether or not the patch is noticeable.  If everyone
(>85%) says that computer A is much smoother in running video or sound,
and computer A had the RT patch, then the answer would be yes.  But if A
didn't, or there was no notice of a difference (~50% say A and ~50% say
B), then you can say there is no notice of difference with the patch.


> Basically when people go through all that effort of applying
> a patch then they really want to see an improvement. If it is there
> or not.

So make it mainline, and then they won't need to go through any effort
in applying the patch :-)

> 
> You surely have seen that with other patches when users
> suddenly reported something worked better/smoother with a new
> release etc and there was absolutely no explanation for it in the changed
> code.

Yes, but these changes are part of the code.

> 
> I have no reason to believe this is any different with all
> this RT testing. 

Maybe not for the average user noticing the differences, but Lee's
latency tests seem to show something.

> 
> -Andi (who also would prefer to not have interrupt threads, locks like
> a maze and related horribilities in the mainline kernel) 

Why is it so horrible to have interrupts as threads?  It's just a config
option and it really doesn't complicate the kernel that much.  As for
the maze in the locks, the spin_locks are already pretty confusing with
out the changes, and the confusion with them is just to keep the
interface the same.  I actually like the way Ingo did the locks. I use
to work for TimeSys and if you wanted to use a raw_spinlock in their
kernel you needed to always explicitly call raw_spin_lock and
raw_spin_unlock.  The macros with Ingo's makes it easy to switch between
the raw and mutex spin lock.

-- Steve


