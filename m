Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267971AbUHPVvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267971AbUHPVvW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 17:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267969AbUHPVvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 17:51:22 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:6065 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S267971AbUHPVue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 17:50:34 -0400
Subject: Re: boot time, process start time, and NOW time
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, albert@users.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>, voland@dmz.com.pl,
       nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       tim@physik3.uni-rostock.de, george anzinger <george@mvista.com>,
       david+powerix@blue-labs.org
In-Reply-To: <20040816124136.27646d14.akpm@osdl.org>
References: <1087948634.9831.1154.camel@cube>
	 <87smcf5zx7.fsf@devron.myhome.or.jp>
	 <20040816124136.27646d14.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1092692989.2429.15.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 16 Aug 2004 14:49:49 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 12:41, Andrew Morton wrote:
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
> >
> > Albert Cahalan <albert@users.sf.net> writes:
> > 
> > > Even with the 2.6.7 kernel, I'm still getting reports of process
> > > start times wandering. Here is an example:
> > > 
> > >    "About 12 hours since reboot to 2.6.7 there was already a
> > >    difference of about 7 seconds between the real start time
> > >    and the start time reported by ps. Now, 24 hours since reboot
> > >    the difference is 10 seconds."
> > > 
> > > The calculation used is:
> > > 
> > >    now - uptime + time_from_boot_to_process_start
> > 
> > Start-time and uptime is using different source. Looks like the
> > jiffies was added bogus lost counts.
> > 
> > quick hack. Does this change the behavior?
> 
> Where did this all end up?  Complaints about wandering start times are
> persistent, and it'd be nice to get some fix in place...

Yea, I think I dropped this. Not sure what the trouble is just yet. Let
me go digging. 

thanks
-john

