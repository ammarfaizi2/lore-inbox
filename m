Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVBONSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVBONSN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 08:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVBONSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 08:18:13 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:19219 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261715AbVBONRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 08:17:48 -0500
Message-ID: <4211F706.4030104@aitel.hist.no>
Date: Tue, 15 Feb 2005 14:20:06 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Petrovitsch <bernd@firmix.at>
CC: Kyle Moffett <mrmacman_g4@mac.com>, Lee Revell <rlrevell@joe-job.com>,
       Patrick McFarland <pmcfarland@downeast.net>,
       linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>,
       Prakash Punnoor <prakashp@arcor.de>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-hotplug-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Roland Dreier <roland@topspin.com>
Subject: Re: [OT] speeding boot process (was Re: [ANNOUNCE] hotplug-ng 001
 release)
References: <20050211004033.GA26624@suse.de> <420C054B.1070502@downeast.net>	 <20050211011609.GA27176@suse.de>	 <1108354011.25912.43.camel@krustophenia.net>	 <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de>	 <1108422240.28902.11.camel@krustophenia.net> <524qge20e2.fsf@topspin.com>	 <1108424720.32293.8.camel@krustophenia.net> <42113F6B.1080602@am.sony.com>	 <1108430245.32293.16.camel@krustophenia.net>	 <4B923A81-7EF3-11D9-86CC-000393ACC76E@mac.com>	 <4211B8FC.8000600@aitel.hist.no> <1108459982.438.9.camel@tara.firmix.at>
In-Reply-To: <1108459982.438.9.camel@tara.firmix.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch wrote:

>On Tue, 2005-02-15 at 09:55 +0100, Helge Hafting wrote:
>[...]
>  
>
>>The init-script dependencies are specifies already - at least on debian.
>>    
>>
>
>These are not dependencies but "only" the sequence of startup (and it is
>not only Debian but also Fedora/RedHat, SuSE, Mandrake and probably all
>except Gentoo).
>  
>
Yes, it is a sequence.  It it derived from real dependencies though,
where nondependent stuff have the same number.

>Yuo get a much stricter ordering and sorting (and thus much simpler to
>implement in a shell script).
>  
>
Correct.

>This would be a win (especially if the numbers are tweked to tune this)
>with a relatively small effort.
>However for real dependencies and parallelism you want the info similar
>to creat a Makefile from it (i.e. the explicit dependency from service X
>to service Y). As a consequence you can get rid of the numbers (since
>they are not needed any more).
>  
>
Now that is a really good idea.  Init could simply run "make -j init2" to
enter runlevel 2.  A suitable makefile would list all dependencies, and
of course the targets needed for "init2", "init3" and so on.

It might not be that much work either.  Parallel make exists already, 
and the
first attempt at a makefile could simply implement the current sequence that
is known to work. Then the tweaking comes. :-)

Helge Hafting

 
