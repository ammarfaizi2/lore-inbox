Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267911AbUHPTnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267911AbUHPTnZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 15:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267914AbUHPTnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 15:43:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:42723 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267911AbUHPTnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 15:43:23 -0400
Date: Mon, 16 Aug 2004 12:41:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: albert@users.sourceforge.net, linux-kernel@vger.kernel.org,
       voland@dmz.com.pl, nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       tim@physik3.uni-rostock.de, george@mvista.com, johnstul@us.ibm.com,
       david+powerix@blue-labs.org
Subject: Re: boot time, process start time, and NOW time
Message-Id: <20040816124136.27646d14.akpm@osdl.org>
In-Reply-To: <87smcf5zx7.fsf@devron.myhome.or.jp>
References: <1087948634.9831.1154.camel@cube>
	<87smcf5zx7.fsf@devron.myhome.or.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
> Albert Cahalan <albert@users.sf.net> writes:
> 
> > Even with the 2.6.7 kernel, I'm still getting reports of process
> > start times wandering. Here is an example:
> > 
> >    "About 12 hours since reboot to 2.6.7 there was already a
> >    difference of about 7 seconds between the real start time
> >    and the start time reported by ps. Now, 24 hours since reboot
> >    the difference is 10 seconds."
> > 
> > The calculation used is:
> > 
> >    now - uptime + time_from_boot_to_process_start
> 
> Start-time and uptime is using different source. Looks like the
> jiffies was added bogus lost counts.
> 
> quick hack. Does this change the behavior?

Where did this all end up?  Complaints about wandering start times are
persistent, and it'd be nice to get some fix in place...

Thanks.
