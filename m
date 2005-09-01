Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbVIAS1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbVIAS1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 14:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbVIAS1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 14:27:46 -0400
Received: from mxsf06.cluster1.charter.net ([209.225.28.206]:31121 "EHLO
	mxsf06.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1030287AbVIAS1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 14:27:45 -0400
X-IronPort-AV: i="3.96,162,1122868800"; 
   d="scan'208"; a="1335326973:sNHT15072004"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17175.18456.860997.997539@smtp.charter.net>
Date: Thu, 1 Sep 2005 14:27:36 -0400
From: "John Stoffel" <john@stoffel.org>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: "John Stoffel" <john@stoffel.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm1
In-Reply-To: <200509012005.18369.dominik.karall@gmx.net>
References: <20050901035542.1c621af6.akpm@osdl.org>
	<200509011828.13579.dominik.karall@gmx.net>
	<17175.15252.782903.646427@smtp.charter.net>
	<200509012005.18369.dominik.karall@gmx.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dominik> Why should I check for newer firmware!? I don't understand
Dominik> that point of view.  The device works without any problems
Dominik> with 2.6.13-ck1 as 2.6.13-rc6-mm1 and before kernels. So
Dominik> there is no need to check the firmware imho.

That's on point of view.  In my experience, it simplifies debugging to
make sure the unit is at the latest firmware, since bugs in the
enclosure's IDE driver could be causing the problem.  As I said
before, when my enclosure was upgraded, all my problems went away.  

So that's why I was asking you to make sure your firmware was upto
date.  Is that so hard to understand?  

Dominik> I don't think that it makes any difference if I power up
Dominik> first or plug in first. The device is recognized when I power
Dominik> it on, so it would be the same when I power it on and connect
Dominik> after that imho.

Sure it can make a difference.  If the enclosure puts out crap signals
on the USB bus when it's powered up, and the older versions of the
Linux kernel dealt with them because of an oversight, but now we're
closer to the USB specs... it could the issue.  

In any case, it's a *simple* test to do, unless you're not physically
at the system with this device, or if you can't be bothered to:

1. unplug enclosure from USB.
2. power it off.
3. power it on.
4. wait 30 seconds.
5. plug in the USB cable.
6. what happens?

That tells us useful stuff.  

Dominik> I will try to get the backtraces from the kernel, this should
Dominik> make debugging easier.

That will help people debug this for sure.

In any case, I'm not going to be much help from here on.
