Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVBODif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVBODif (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 22:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVBODif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 22:38:35 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:64955 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261612AbVBODia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 22:38:30 -0500
Message-ID: <42116EAF.4070503@why.dont.jablowme.net>
Date: Mon, 14 Feb 2005 22:38:23 -0500
From: Jim Crilly <jim@why.dont.jablowme.net>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Cc: Tim Bird <tim.bird@am.sony.com>, Roland Dreier <roland@topspin.com>,
       Prakash Punnoor <prakashp@arcor.de>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, Greg KH <gregkh@suse.de>,
       Patrick McFarland <pmcfarland@downeast.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [OT] speeding boot process (was Re: [ANNOUNCE] hotplug-ng 001
 release)
References: <20050211004033.GA26624@suse.de> <420C054B.1070502@downeast.net>	 <20050211011609.GA27176@suse.de>	 <1108354011.25912.43.camel@krustophenia.net>	 <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de>	 <1108422240.28902.11.camel@krustophenia.net>  <524qge20e2.fsf@topspin.com>	 <1108424720.32293.8.camel@krustophenia.net>  <42113F6B.1080602@am.sony.com> <1108430245.32293.16.camel@krustophenia.net>
In-Reply-To: <1108430245.32293.16.camel@krustophenia.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell said the following:
> The reason I marked by response OT is that the time from power on to
> userspace does not seem to be a big problem.  It's the amount of time
> from user space to presenting a login prompt that's way too long.  My
> distro (Debian) runs all the init scripts one at a time, and GDM is the
> last thing that gets run.  There is just no reason for this.  We should
> start X and initialize the display and get the login prompt up there
> ASAP, and let the system acquire the DHCP lease and start sendmail and
> apache and get the date from the NTP server *in the background while I
> am logging in*.  It's not rocket science.

That is one of the "features" that I hate most about Windows. All you really do 
is move the delays around. For instance, my Windows machine at work is joined 
to a domain and has the Novell NetWare client installed for NDS auth (don't 
ask) so when the GINA comes up, I hit Ctrl+Alt+Del, enter my password and wait 
staring at an hourglass while the GINA waits for network connectivity to come 
up so that it can authenticate me. And even if authentication was local and I 
got logged in right away, chances are good that I have mapped drives or 
printers on the network that I will have to wait for during the login process 
anyway.

I agree boot up is too slow and that some things should be started in the 
background, but not things that are required for the main purpose of the box to 
work properly, what should be started sync and what should be async is a hard 
decision IMO. Right now I use swsusp2 to work around this, it takes less time 
to resume my session + 500M of file cache than it does to boot manually and 
start all of my apps back up, but obviously that's not a real solution.

> 
> Lee
> 

Jim.
