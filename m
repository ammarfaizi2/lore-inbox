Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266582AbUHQTBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266582AbUHQTBf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 15:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266604AbUHQTBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 15:01:35 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:59091 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266582AbUHQTBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 15:01:30 -0400
Subject: Re: boot time, process start time, and NOW time
From: john stultz <johnstul@us.ibm.com>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: Andrew Morton OSDL <akpm@osdl.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       voland@dmz.com.pl, nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       tim@physik3.uni-rostock.de, george anzinger <george@mvista.com>,
       david+powerix@blue-labs.org
In-Reply-To: <1092698648.2301.1250.camel@cube>
References: <1087948634.9831.1154.camel@cube>
	 <87smcf5zx7.fsf@devron.myhome.or.jp>
	 <20040816124136.27646d14.akpm@osdl.org>  <1092698648.2301.1250.camel@cube>
Content-Type: text/plain
Message-Id: <1092769231.2429.115.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 17 Aug 2004 12:00:31 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 16:24, Albert Cahalan wrote:
> On Mon, 2004-08-16 at 15:41, Andrew Morton wrote:
> 
> > Where did this all end up?  Complaints about
> > wandering start times are persistent, and it'd
> > be nice to get some fix in place...
> 
> If you're interested in reducing (not solving)
> the problem for the 2.6.x series, you might change
> HZ to something that works better with the PIT.
> 
> Here is a table showing % error for various HZ choices:
> 
> wrongness_%   HZ_diff   PIT_#   HZ     actual_HZ   
> -0.00150855  -0.001509  11932   100    99.998491  
> -0.00150855  -0.009474   1900   628   627.990526  
> -0.00083809  -0.003051   3278   364   363.996949  
> -0.00083809  -0.008389   1192  1001  1000.991611  
> +0.00000000  +0.000000  14551    82    82.000000  
> +0.00008381  +0.000304   3287   363   363.000304  
> +0.00008381  +0.000435   2299   519   519.000435  
> +0.00008381  +0.000525   1903   627   627.000525  
> +0.01525566  +0.152557   1193  1000  1000.152557  
> +0.01860917  +0.190558   1165  1024  1024.190558
> 
> As you can see, 1000 HZ and 1024 HZ are really bad.
> They're worse than typical quartz crystal variation.
> 
> The old 100 HZ tick was just barely tolerable.
> While 82 is perfect, it's a bit low. :-(
> 
> Some of the other choices are nice. How about 363,
> 519, or 627?

What about 1001? That looks reasonably accurate.

thanks
-john


