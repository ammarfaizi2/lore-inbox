Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbVKCULS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVKCULS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 15:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbVKCULS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 15:11:18 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:18900 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750774AbVKCULR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 15:11:17 -0500
Subject: Re: NTP broken with 2.6.14
From: john stultz <johnstul@us.ibm.com>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Jean-Christian de Rivaz <jc@eclis.ch>, linux-kernel@vger.kernel.org,
       dean@arctic.org
In-Reply-To: <20051103195124.GE9488@csclub.uwaterloo.ca>
References: <4369464B.6040707@eclis.ch>
	 <1130973717.27168.504.camel@cog.beaverton.ibm.com>
	 <43694DD1.3020908@eclis.ch>
	 <1130976935.27168.512.camel@cog.beaverton.ibm.com>
	 <43695D94.10901@eclis.ch>
	 <1130980031.27168.527.camel@cog.beaverton.ibm.com>
	 <43697550.7030400@eclis.ch>
	 <1131046348.27168.537.camel@cog.beaverton.ibm.com>
	 <20051103195124.GE9488@csclub.uwaterloo.ca>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 12:11:10 -0800
Message-Id: <1131048670.27168.573.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-03 at 14:51 -0500, Lennart Sorensen wrote:
> On Thu, Nov 03, 2005 at 11:32:28AM -0800, john stultz wrote:
> > Yep. Thats what I was guessing. For some reason time is running too
> > quickly on your system. Since it is more then +/-500ppm NTP gives up and
> > won't sync.
> > 
> > Time running too fast can have a number of causes.
> > 
> > Could you open a bugme bug on this and tag me as the owner?
> > http://bugzilla.kernel.org
> > 
> > Also attach dmesg output and we'll see if that doesn't provide more
> > clues.
> 
> I have no idea if this is related at all, but I have had system time
> speed issues on my machine for a while too.
> 
> With 2.6.8 it always ran fine, with 2.6.12 it seemed to gain around 10
> minutes per hour, and so far today with 2.6.14 it seems to be gaining
> about 3 or 4 minutes per hour.  These are all Debian kernels, although I
> hope they haven't added/removed anything that would affect this.
> 
> This is happening on an Asus A7N8X-E-DX with an Athlon XP 2800+.  I have
> acpi enabled, so who knows if that is what is breaking things.  There
> does seem to have been time keeping issues on ati chipsets big time in
> recent kernels, and some other acpi issues at times, so it wouldn't
> surprise me if a fix for one issue causes problems on another chipset.
> The chipset on this board is the nforce2.

Yea, we have some issues with a few specific chipsets, but those were
not regressions to my knowledge. 

Hmm. Check bug #5038 to see if sounds familiar.
http://bugzilla.kernel.org/show_bug.cgi?id=5038

thanks
-john




