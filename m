Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbTDHWnt (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 18:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbTDHWnt (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 18:43:49 -0400
Received: from galileo.bork.org ([66.11.174.148]:6155 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S262197AbTDHWnr (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 18:43:47 -0400
Date: Tue, 8 Apr 2003 18:55:23 -0400
From: Martin Hicks <mort@wildopensource.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Pavel Machek <pavel@ucw.cz>, Jes Sorensen <jes@wildopensource.com>,
       linux-kernel@vger.kernel.org, wildos@sgi.com
Subject: Re: [patch] printk subsystems
Message-ID: <20030408225523.GB3413@bork.org>
References: <20030407201337.GE28468@bork.org> <20030408184109.GA226@elf.ucw.cz> <m3k7e4ycys.fsf@trained-monkey.org> <20030408210251.GA30588@atrey.karlin.mff.cuni.cz> <3E933AB2.8020306@zytor.com> <20030408215703.GA1538@atrey.karlin.mff.cuni.cz> <3E934793.8070801@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E934793.8070801@zytor.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Apr 08, 2003 at 03:05:07PM -0700, H. Peter Anvin wrote:
> Pavel Machek wrote:
> > 
> > Well, #define DEBUG in the driver seems like the way to go. I do not
> > like "subsystem ID" idea, because subsystems are not really well
> > defined etc.
> >
> 
> I think that's a non-issue, because it's largely self-defining.  It's
> basically whatever the developers want them to be, because they're the
> ones who it needs to make sense to.

Exactly right.  The worst cases are: 1) developers  assign messages
to a completely wrong subsystem or 2) don't assign the printk to any
subsystem, in which case we're in exactly the same situation as we are
in now.

> It should, however, be an open set, not a closed set like in syslog.

I agree.  I'll try to make it as easy as possible to add another
subsystem.

I'm going to work on the sysctl interface for this next.

mh

-- 
Wild Open Source Inc.                  mort@wildopensource.com
