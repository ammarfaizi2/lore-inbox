Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263900AbTJEXtg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 19:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263901AbTJEXtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 19:49:36 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:29704
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263900AbTJEXtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 19:49:35 -0400
Date: Sun, 5 Oct 2003 16:49:37 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Hacksaw <hacksaw@hacksaw.org>
Cc: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       linux-kernel@vger.kernel.org
Subject: Re: swap and 2.4.20
Message-ID: <20031005234937.GG1205@matchmail.com>
Mail-Followup-To: Hacksaw <hacksaw@hacksaw.org>,
	Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
	linux-kernel@vger.kernel.org
References: <20031005215627.GE1205@matchmail.com> <200310052219.h95MJQKF008980@habitrail.home.fools-errant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310052219.h95MJQKF008980@habitrail.home.fools-errant.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 05, 2003 at 06:19:26PM -0400, Hacksaw wrote:
> In fact, thinking about what might be involved to make that possible hurts my 
> head. Well maybe not. I wonder if you could have a mechanism that causes the 
> entire library to be paged out and reloaded if while paging the version is 
> discovered to have changed.
> 
> In many ways this would be cool, as it would mean that running apps could stay 
> up and yet get bugs fixed.
> 
> I'm guessing that would require there to be no static variables in the 
> library, as well as being fully reentrant, or that that any statics are in a 
> page whose format doesn't change and is locked down for the switch.

What you are talking about is equivalent to binary patching.

Now if your app could unload the library entirely, it could just reload the
updated copy.  But I really fail to see why the mechanism you are talking
about is needed.

If you have an app that needs to be available every second, then you need a
failover system, and why not just have three where you can take one down at
any time for updates(and still have one for failover during the update,
though you could get by with only two, and take down the fail-over machine
during the update)? 
