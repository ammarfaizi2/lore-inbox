Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030478AbVKCVAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030478AbVKCVAb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 16:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030479AbVKCVAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 16:00:31 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:47525 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030478AbVKCVAa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 16:00:30 -0500
Subject: Re: NTP broken with 2.6.14
From: john stultz <johnstul@us.ibm.com>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Jean-Christian de Rivaz <jc@eclis.ch>, linux-kernel@vger.kernel.org,
       dean@arctic.org
In-Reply-To: <20051103204807.GT9486@csclub.uwaterloo.ca>
References: <4369464B.6040707@eclis.ch>
	 <1130973717.27168.504.camel@cog.beaverton.ibm.com>
	 <43694DD1.3020908@eclis.ch>
	 <1130976935.27168.512.camel@cog.beaverton.ibm.com>
	 <43695D94.10901@eclis.ch>
	 <1130980031.27168.527.camel@cog.beaverton.ibm.com>
	 <43697550.7030400@eclis.ch>
	 <1131046348.27168.537.camel@cog.beaverton.ibm.com>
	 <20051103195124.GE9488@csclub.uwaterloo.ca>
	 <1131048670.27168.573.camel@cog.beaverton.ibm.com>
	 <20051103204807.GT9486@csclub.uwaterloo.ca>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 13:00:27 -0800
Message-Id: <1131051627.27168.590.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-03 at 15:48 -0500, Lennart Sorensen wrote:
> On Thu, Nov 03, 2005 at 12:11:10PM -0800, john stultz wrote:
> > Yea, we have some issues with a few specific chipsets, but those were
> > not regressions to my knowledge. 
> 
> Well my nforce2 worked with 2.6.8 and earlier, and I believe it was even
> fine with 2.6.10 and 2.6.11, but certainly 2.6.12 ran rather awful time
> sync wise, and 2.6.14 appears so far to be running a little fast,
> although I can't say for sure.  It is much better than 2.6.12 was.  It
> may be that 2.6.14 is running correctly, but that the previous drift has
> caused something to need to be realigned.

You could try disabling NTP and running the python script I sent out
earlier in this thread to determine your systems ppm drift. Outside
+/-500ppm is def broken, outside of +/-250ppm is probably broken,
outside +/-100ppm isn't great but correctable and inside +/-100ppm is
(unfortunately) pretty average for most hardware.

> 
> > Hmm. Check bug #5038 to see if sounds familiar.
> > http://bugzilla.kernel.org/show_bug.cgi?id=5038
> 
> I was seeting WAY more drift than that with 2.6.12.

Ok, do you want to open your own bug on this and we'll mark them
duplicate as needed?

Please attach dmesg output to the bug as well.

thanks
-john


