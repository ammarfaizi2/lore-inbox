Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261675AbSI1OtE>; Sat, 28 Sep 2002 10:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261679AbSI1OtE>; Sat, 28 Sep 2002 10:49:04 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:41231 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261675AbSI1OtD>; Sat, 28 Sep 2002 10:49:03 -0400
Date: Sat, 28 Sep 2002 15:54:18 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Sleeping function called from illegal context...
Message-ID: <20020928145418.GB50842@compsoc.man.ac.uk>
References: <20020927233044.GA14234@kroah.com> <1033174290.23958.17.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033174290.23958.17.camel@phantasy>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *17vIz4-000J6v-00*Tv.8lUt8C0Q* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 08:51:30PM -0400, Robert Love wrote:

> Note this has nothing to do with kernel preemption.  IDE explicitly
> sleeps while purposely holding a lock.
> 
> It is just we do not have the ability to measure atomicity w/o
> preemption enabled - e.g. the debugging only works when it is enabled.

Would it be particularly difficult to separate this debug tool from the
feature ? Surely we could make it so that CONFIG_PREEMPT depends on
CONFIG_MIGHT_SLEEP or whatever, and just adds the actual ability to
reschedule.

I have a bit of a problem with __might_sleep because I call sleepable
stuff holding a spinlock (yes, it is justified, and yes, it is safe
afaics, at least with PREEMPT=n)

regards
john

-- 
"When your name is Winner, that's it. You don't need a nickname."
	- Loser Lane
