Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271748AbTG2PaO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 11:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271811AbTG2PaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 11:30:13 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:25105 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S271748AbTG2PaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 11:30:08 -0400
Message-ID: <3F26957E.7040204@techsource.com>
Date: Tue, 29 Jul 2003 11:40:46 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Andrew Morton <akpm@osdl.org>, ed.sweetman@wmich.edu,
       eugene.teo@eugeneteo.net, linux-kernel@vger.kernel.org,
       kernel@kolivas.org
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307271517.55549.phillips@arcor.de> <3F267CF9.40500@techsource.com> <200307300946.41674.phillips@arcor.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Daniel Phillips wrote:

> 
> In the meantime, the SCHED_SOFTRR proposal provides a way of closely 
> approximating the above behaviour without being intrusive or 
> application-specific.
> 


And there are obvious benefits to keeping things application-general.

IF it's possible to intelligently determine interactivity and other such 
things, and lots of impressive progress is being made in that area, then 
that is definately preferable.  But there may be some circumstances 
where we simply cannot determine need from application behavior.

It might help to have an API for real-time processes that is accessible 
by non-root tasks.  If a task sets itself to real-time, its scheduling 
is more predictable, but it gets a shorter timeslice (perhaps) so that 
being real-time doesn't adversely impact the system when abused.

The nice thing about the smart schedulers is that (a) no one has to 
change their apps (although they can tweak to cooperate better), and (b) 
future apps will behave well without us having to anticipate anything.

