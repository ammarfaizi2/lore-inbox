Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265217AbSJWWHP>; Wed, 23 Oct 2002 18:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265248AbSJWWHM>; Wed, 23 Oct 2002 18:07:12 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:53408 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265217AbSJWWHJ>; Wed, 23 Oct 2002 18:07:09 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 23 Oct 2002 15:22:16 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: John Gardiner Myers <jgmyers@netscape.com>
cc: linux-aio <linux-aio@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: async poll
In-Reply-To: <3DB71A82.6070204@netscape.com>
Message-ID: <Pine.LNX.4.44.0210231510300.1581-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002, John Gardiner Myers wrote:

> Davide Libenzi wrote:
>
> >Why would you want to have a single fd simultaneously handled by two
> >different threads with all the locking issues that would arise ?
> >
> You would not want this to happen.  Thus you would want the poll
> facility to somehow prevent returning event N+1 until after the thread
> that got event N has somehow indicated that it has finished handling the
> event.

We're again looping talking about threads and fd being bounced between
threads. It seems that we've very different opinions about the use of
threads and how server applications should be designed. IMHO if you're
thinking of bouncing fds among threads for their handling you're doing
something somehow wrong, but this is just my opinion ...



- Davide




