Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264767AbSLBS21>; Mon, 2 Dec 2002 13:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264799AbSLBS20>; Mon, 2 Dec 2002 13:28:26 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:61457
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S264767AbSLBS2S>; Mon, 2 Dec 2002 13:28:18 -0500
Subject: Re: a bug in autofs
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: "Andrey R. Urazov" <coola@ngs.ru>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021202175040.GA857@ktulu>
References: <20021201071612.GA936@ktulu>
	 <1038799532.15370.301.camel@ixodes.goop.org> <20021202075725.GC1459@ktulu>
	 <1038818346.3253.17.camel@ixodes.goop.org> <20021202151730.GB885@ktulu>
	 <1038847726.2560.51.camel@ixodes.goop.org>  <20021202175040.GA857@ktulu>
Content-Type: text/plain
Organization: 
Message-Id: <1038854145.2560.79.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 02 Dec 2002 10:35:45 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-02 at 09:50, Andrey R. Urazov wrote:
> > > Just tested that the system hangs when the autofs4 module is in use.
> > > autofs (without 4) module does not cause any problems.
> > 
> > Do you mean you're switching from the autofs4 kernel module with autofs4
> > automount, or are you using the autofs4 kernel module with autofs3
> > automount?
> In both cases I use user level tools version 3.1.7.

OK. Using v3 tools with the v4 kernel modules isn't well tested.  It is
supposed to work, but I wouldn't be surprised if there were problems. 
But I don't think that's your problem.

> I misinformed you again :)
> The message is different from those that was in my memory:
> 
> hdc: ATAPI reset complete 
> hdc: status error: status=0x00 { }
> ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
> 
> then I get an Oops message. I reproduced the bug twice this time and
> I get two different oops messages. At least the call stacks of the two
> were different since during second time the call stack was so large that
> I didn't see anything else.

Well, if you post the decoded backtrace, I'm sure it will help the IDE
developers find your problem.  It looks to me like you've got something
strange going on with IDE and/or ide-scsi.

I'm not sure why you'd be seeing different behaviour between manual
mounting and autofs, but it may have something to do with timing.

	J

