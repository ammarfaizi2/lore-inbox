Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319038AbSIJAR6>; Mon, 9 Sep 2002 20:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319039AbSIJAR6>; Mon, 9 Sep 2002 20:17:58 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:35851 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319038AbSIJARz>;
	Mon, 9 Sep 2002 20:17:55 -0400
Date: Mon, 9 Sep 2002 17:19:45 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB changes for 2.5.34
Message-ID: <20020910001945.GB8477@kroah.com>
References: <20020909221727.GF7433@kroah.com> <Pine.LNX.4.33.0209091714330.2069-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0209091714330.2069-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2002 at 05:17:40PM -0700, Linus Torvalds wrote:
> 
> Greg, please don't do this
> 
> > ChangeSet@1.614, 2002-09-05 08:33:20-07:00, greg@kroah.com
> >   USB: storage driver: replace show_trace() with BUG()
> 
> that BUG() thing is _way_ out of line, and has killed a few of my machines 
> several times for no good reason. It actively hurts debuggability, because 
> the machine is totally dead after it, and the whole and ONLY point of 
> BUG() messages is to help debugging and make it clear that we can't handle 
> something.
> 
> In this case, we _can_ handle it, and we're much better off with a machine 
> that works and that you can look up the messages with than killing it.
> 
> Rule of thumb: BUG() is only good for something that never happens and 
> that we really have no other option for (ie state is so corrupt that 
> continuing is deadly).

Sorry, Matt told me to add it, I didn't realize the background.  Should
I leave it as show_trace(), or just remove it?  Do you want me to send
you another changeset to put it back?

thanks,

greg k-h
