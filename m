Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVBOBTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVBOBTz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 20:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbVBOBTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 20:19:55 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:5284 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261584AbVBOBR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 20:17:27 -0500
Subject: Re: [OT] speeding boot process (was Re: [ANNOUNCE] hotplug-ng 001
	release)
From: Lee Revell <rlrevell@joe-job.com>
To: Tim Bird <tim.bird@am.sony.com>
Cc: Roland Dreier <roland@topspin.com>, Prakash Punnoor <prakashp@arcor.de>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, Greg KH <gregkh@suse.de>,
       Patrick McFarland <pmcfarland@downeast.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <42113F6B.1080602@am.sony.com>
References: <20050211004033.GA26624@suse.de> <420C054B.1070502@downeast.net>
	 <20050211011609.GA27176@suse.de>
	 <1108354011.25912.43.camel@krustophenia.net>
	 <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de>
	 <1108422240.28902.11.camel@krustophenia.net>  <524qge20e2.fsf@topspin.com>
	 <1108424720.32293.8.camel@krustophenia.net>  <42113F6B.1080602@am.sony.com>
Content-Type: text/plain
Date: Mon, 14 Feb 2005 20:17:25 -0500
Message-Id: <1108430245.32293.16.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-14 at 16:16 -0800, Tim Bird wrote:
> Lee Revell wrote:
> > But, I was referring more to things like GDM not being started until all
> > the other init scripts are done.  Why not start it first, and let the
> > network initialize while the user is logging in?
> 
> There are a number of techniques used by CE vendors to get fast bootup
> time.  Some CE products boot Linux in under 1 second.  Sony's
> best Linux boot time in the lab (from power on to user space)
> was 148 milliseconds, on an ARM chip (running at 200 MHZ I believe).

The reason I marked by response OT is that the time from power on to
userspace does not seem to be a big problem.  It's the amount of time
from user space to presenting a login prompt that's way too long.  My
distro (Debian) runs all the init scripts one at a time, and GDM is the
last thing that gets run.  There is just no reason for this.  We should
start X and initialize the display and get the login prompt up there
ASAP, and let the system acquire the DHCP lease and start sendmail and
apache and get the date from the NTP server *in the background while I
am logging in*.  It's not rocket science.

Lee

