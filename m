Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264208AbTEOTmh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 15:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264207AbTEOTmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 15:42:37 -0400
Received: from palrel10.hp.com ([156.153.255.245]:55461 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S264206AbTEOTm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 15:42:28 -0400
Date: Thu, 15 May 2003 12:55:16 -0700
To: Greg KH <greg@kroah.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: airo and firmware upload (was Re: 2.6 must-fix list, v3)
Message-ID: <20030515195516.GA18244@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030514211222.GA10453@bougret.hpl.hp.com> <3EC2BDEC.6020401@pobox.com> <20030514233235.GA11581@bougret.hpl.hp.com> <20030515071317.GB6497@kroah.com> <20030515172446.GD17496@bougret.hpl.hp.com> <20030515174648.GA9549@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030515174648.GA9549@kroah.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 10:46:48AM -0700, Greg KH wrote:
> On Thu, May 15, 2003 at 10:24:46AM -0700, Jean Tourrilhes wrote:
> > 	Manuel Estrada sent me a proposal for that.
> 
> I provided some feedback to him that I think will make his proposal work
> for almost everyone.  Hopefully he has the time to implement it :)
> 
> thanks,
> 
> greg k-h

	I read that thread and I don't agree with some of your
unrealistic requirements.
	As long as kernel 2.6.X is not standard in most major
distributions (including Debian), whatever scheme we decide on must be
easy to implement on 2.4.X. Let be realistic : all of us still
continue to update 2.4.X on a regular basis. Those 3 drivers are ready
today (one of them has been waiting on this issue for already 6
months), and I want them in 2.4.X not long after they go in 2.5.X.
	Therefore, unless you plan to port sysfs to 2.4.X real soon,
the scheme can't depend exclusively on sysfs. I would even say,
because sysfs change on a weekly basis, it might even be wise to take
a two phase approach, with sysfs used only in the second phase and
based on the feedback and the results from the first phase (I
personally don't believe we will get it perfect at the first try). The
hotplug facility is flexible enough to migrate to sysfs smoothly.
	I'm pragmatic : I prefer to have something imperfect now
rather than something perfect later. I think Manuel's solution is a
good stepping stone to where we want to go. If you make it too
difficult, this will never happen (and each driver will use a
proprietary solution or be kept in a black hole).

	So, my question for you is :
	o how do you plan to make it work with 2.4.X.

	Have fun...

	Jean
