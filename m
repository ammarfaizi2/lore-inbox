Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262210AbSJDUkf>; Fri, 4 Oct 2002 16:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262560AbSJDUkf>; Fri, 4 Oct 2002 16:40:35 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:37059 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262210AbSJDUke>;
	Fri, 4 Oct 2002 16:40:34 -0400
Date: Fri, 4 Oct 2002 22:45:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: jbradford@dial.pipex.com
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.X breaks PS/2 mouse
Message-ID: <20021004224547.A49400@ucw.cz>
References: <20021004221554.A49104@ucw.cz> <200210042052.g94KqQmB008165@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210042052.g94KqQmB008165@darkstar.example.net>; from jbradford@dial.pipex.com on Fri, Oct 04, 2002 at 09:52:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 09:52:26PM +0100, jbradford@dial.pipex.com wrote:
> > > Once booted:
> > > 
> > > Hot plugging either the dedicated trackball or a PS/2 mouse generates a message on connection:
> > 
> > Good, this is expected.
> > 
> > > Just to clarify, I am not trying to use them both at the same time.
> > 
> > Not sure if that would work, it might - depends on the notebook keyboard
> > controller hardware.
> 
> I tried it, and it seems to get really confused - constant stream of seemingly random error messages.
> 
> > > X also works with the external PS/2 mouse,
> > 
> > Good.
> > 
> > > but not the dedicated trackball.
> > 
> > What are the exact symptoms?
> 
> No data at all from it.
> 
> > Does gpm work?
> 
> No.
> 
> > Does cat /dev/psaux work?
> 
> It doesn't say No such device, it just hangs, giving no data for the trackball, but works fine for the generic mouse.
> 
> > Does cat /dev/input/mice work?
> 
> Yes, it does the same as /dev/psaux
> 
> > What does cat /proc/bus/input/devices say in the
> > case it doesn't work? ....
> 
> I: Bus=0011 Vendor=0002 Product=0001 Version=0000
> N: Name="PS/2 Generic Mouse"
> P: Phys=isa0060/serio1/input0
> H: Handlers=mouse0
> B: EV=7
> B: KEY=70000 0 0 0 0 0 0 0 0
> B: REL=3
> 
> That's for both the generic mouse and the trackball.

Ok. Can you try the usual #define I8042_DEBUG_IO in
drivers/input/serio/i8042.h?

-- 
Vojtech Pavlik
SuSE Labs
