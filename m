Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264932AbRFZFJ7>; Tue, 26 Jun 2001 01:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265912AbRFZFJt>; Tue, 26 Jun 2001 01:09:49 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:25104 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264932AbRFZFJi>;
	Tue, 26 Jun 2001 01:09:38 -0400
Date: Mon, 25 Jun 2001 22:07:01 -0700
From: Greg KH <greg@kroah.com>
To: rio500-devel <rio500-devel@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] rio500 devfs support
Message-ID: <20010625220701.A18827@kroah.com>
In-Reply-To: <20010619175224.A1137@glitch.snoozer.net> <20010625103521.A17036@kroah.com> <20010625171201.A13305@glitch.snoozer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010625171201.A13305@glitch.snoozer.net>; from haphazard@socket.net on Mon, Jun 25, 2001 at 05:12:01PM -0500
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2001 at 05:12:01PM -0500, Gregory T. Norris wrote:
> I was thinking of doing some similar updates this evening after work. 
> Darn it... now I have to find something else to do!  :-)
> 
> Going by this morning's comments from Richard Gooch, it sounds like the
> 
> 	if (rio->devfs == NULL)
> 		dbg("probe_rio: device node registration failed");

Just don't have it be using a call to "err()" like the printer.c file
does.  Loads of users wondering why they have an error message in their
logs, yet their printers still work.  That's why I made it dbg().

But yes, I agree that it doesn't have to be there at all.

greg k-h
