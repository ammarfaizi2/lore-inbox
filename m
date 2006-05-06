Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751814AbWEFCoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbWEFCoP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 22:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWEFCoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 22:44:15 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:33211 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751814AbWEFCoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 22:44:14 -0400
Subject: Re: [PATCH 3/5] periodic clocksource update
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0604272159400.32445@scrub.home>
References: <Pine.LNX.4.64.0604032156430.4714@scrub.home>
	 <1144437489.2745.114.camel@leatherman>
	 <Pine.LNX.4.64.0604272159400.32445@scrub.home>
Content-Type: text/plain
Date: Fri, 05 May 2006 19:44:11 -0700
Message-Id: <1146883452.12414.63.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-27 at 23:40 +0200, Roman Zippel wrote:
> There are big differences. :)
> As I already mentioned it produces smaller code and I tried to make the 
> fast path as small as possible.
> I also updated the algorithm to be more robust, the subtle changes are in 
> the clocksource_bigadjust(), which does a bit more work to keep the clock 
> from oscillating.

Ok, I'd like to integrate the ideas from your clocksource_adjust()
method into what I currently have as make_ntp_adj().  However the code
is still difficult to grasp, for example, you have the constants 33, 32
and 31 there with no explanation of exactly why you're using differing
shift values. I'm just still really hesitant to add code that is so
difficult to read and understand. 

So I'll take another pass at optimizing my make_ntp_adj function, and
maybe you could do the same with respect to clarity and comments for
clocksource_adjust() and maybe we can meet halfway?

thanks
-john

