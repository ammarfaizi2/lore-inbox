Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314940AbSDVX1l>; Mon, 22 Apr 2002 19:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314941AbSDVX1k>; Mon, 22 Apr 2002 19:27:40 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:8412 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S314940AbSDVX1k>;
	Mon, 22 Apr 2002 19:27:40 -0400
Date: Tue, 23 Apr 2002 09:26:27 +1000
From: Anton Blanchard <anton@samba.org>
To: george anzinger <george@mvista.com>
Cc: John Alvord <jalvo@mbay.net>, Pavel Machek <pavel@suse.cz>,
        davidm@hpl.hp.com, Davide Libenzi <davidel@xmailserver.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
Message-ID: <20020422232627.GA5527@krispykreme>
In-Reply-To: <Pine.LNX.4.20.0204221019280.20972-100000@otter.mbay.net> <3CC4861C.F21859A6@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Please folks.  When can we put the "tick on demand" thing to bed?  If in
> doubt, get the patch from the high-res-timers sourceforge site (see
> signature for the URL) and try it.  Overhead becomes higher with system
> load passing the ticked system at relatively light loads.  Just what we
> want, very low overhead idle systems!  
> 
> The problem is in accounting (or time slicing if you prefer) where we
> need to start a timer each time a task is context switched to, and stop
> it when the task is switched away.  The overhead is purely in the set up
> and tear down.  MOST of these never expire.

Did you work out where exactly the overhead was and if it was hardware
specific? On ppc for example updating the timer is just a write to a cpu
register.

Anton
