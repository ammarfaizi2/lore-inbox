Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264865AbSJVTCL>; Tue, 22 Oct 2002 15:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264876AbSJVTCL>; Tue, 22 Oct 2002 15:02:11 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:17930 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S264865AbSJVTCJ>; Tue, 22 Oct 2002 15:02:09 -0400
Date: Tue, 22 Oct 2002 20:08:18 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Cc: dipankar@gamebox.net, cminyard@mvista.com
Subject: Re: [PATCH] NMI request/release
Message-ID: <20021022190818.GA84745@compsoc.man.ac.uk>
References: <3DB4AABF.9020400@mvista.com> <20021022021005.GA39792@compsoc.man.ac.uk> <3DB4B8A7.5060807@mvista.com> <20021022025346.GC41678@compsoc.man.ac.uk> <3DB54C53.9010603@mvista.com> <20021022232345.A25716@dikhow> <3DB59385.6050003@mvista.com> <20021022233853.B25716@dikhow> <3DB59923.9050002@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB59923.9050002@mvista.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 01:29:55PM -0500, Corey Minyard wrote:

> I would vote against using it for profiling; profiling has it's own 
> special fast-path, anyway.

But it would be good (less code, simpler, and even possibly for keeping
NMI watchdog ticking when oprofile is running) if we could merge the two
cases.

> The NMI watchdog only gets hit once every 
> minute or so, it seems, so that seems suitable for this.

It can easily be much more frequent than that (though you could argue
this is a mis-setup).

> I've looked at the RCU code a little more, and I think I understand it 
> better.  I think your scenario will work, if it's true that it won't be 
> called until all CPUs have done what you say.  I'll look at it a little 
> more.

Thanks for looking into this ...

regards
john

-- 
"This is mindless pedantism up with which I will not put."
	- Donald Knuth on Pascal's lack of default: case statement
