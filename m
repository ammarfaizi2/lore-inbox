Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266490AbUHQByz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266490AbUHQByz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 21:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268069AbUHQByy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 21:54:54 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:18693 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S266490AbUHQByx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 21:54:53 -0400
Message-ID: <41216566.8040206@superbug.demon.co.uk>
Date: Tue, 17 Aug 2004 02:54:46 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040812)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sf.net>
CC: george@mvista.com, Albert Cahalan <albert@users.sourceforge.net>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Andrew Morton OSDL <akpm@osdl.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       lkml <linux-kernel@vger.kernel.org>, voland@dmz.com.pl,
       nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       johnstul@us.ibm.com, david+powerix@blue-labs.org
Subject: Re: boot time, process start time, and NOW time
References: <1087948634.9831.1154.camel@cube>	 <87smcf5zx7.fsf@devron.myhome.or.jp>	 <20040816124136.27646d14.akpm@osdl.org>	 <Pine.LNX.4.53.0408170055180.14122@gockel.physik3.uni-rostock.de>	 <412151CA.4060902@mvista.com> <1092695544.2301.1227.camel@cube>	 <41215EDA.3070802@mvista.com> <1092697717.2301.1233.camel@cube>
In-Reply-To: <1092697717.2301.1233.camel@cube>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
>>>
>>>
>>>That's userspace, which works fine on a 2.4.xx kernel.
>>>If userspace were to change, it wouldn't work OK for
>>>a 2.4.xx kernel anymore. So consider that cast in stone.
>>>
>>>"now" is the time() function. Using gettimeofday()
>>>would only make sense if I decided to pay the cost
>>>of asking for the time every time I look at a task.
>>>

While on the subject of time, is it possible to get a monotonic timer 
with 1ms or better resolution?
We need this for linux multimedia applications, and it is used to sync 
audio and video. Currently we use gettimeofday(). If a movie is playing, 
and the user goes and changes the time, or changes the timezone, we do 
not want that to effect the movie playing. I have not been able to find 
a monotonic 1ms accurate timer in the linux kernel, that is available to 
applications, and has little overhead. Some efficient ioctl or function 
call for uptime to 1ms accuracy would do perfectly.

James
