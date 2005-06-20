Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVFUAFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVFUAFj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVFUADd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:03:33 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:48834 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261500AbVFTXhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:37:14 -0400
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
From: Lee Revell <rlrevell@joe-job.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <Pine.LNX.4.61.0506202231070.3728@scrub.home>
References: <1119063400.9663.2.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0506181344000.3743@scrub.home>
	 <1119287354.9947.22.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0506202231070.3728@scrub.home>
Content-Type: text/plain
Date: Mon, 20 Jun 2005 19:40:46 -0400
Message-Id: <1119310847.17602.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-21 at 00:05 +0200, Roman Zippel wrote:
> With -mm you can now choose the HZ value, so that's not really the 
> problem anymore. A lot of archs even never changed to a higher HZ
> value. 

That does not solve anything, going back to HZ=100 is a big user-visible
regression because the resolution of sleep() (and poll, etc) is now 10ms
rather than 1ms.  Many apps have RT constraints between 1ms and 10ms.

Lee


