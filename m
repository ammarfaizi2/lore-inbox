Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263381AbTETA5T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263385AbTETA5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:57:19 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:40690 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP id S263396AbTETA5P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:57:15 -0400
Message-ID: <3EC986ED.80604@kegel.com>
Date: Mon, 19 May 2003 18:37:49 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Davide Libenzi <davidel@xmailserver.org>,
       John Myers <jgmyers@netscape.com>, linux-aio@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Comparing the aio and epoll event frameworks.
References: <200305192333.QAA12018@pagarcia.nscp.aoltw.net> <Pine.LNX.4.55.0305191657540.6565@bigblue.dev.mcafeelabs.com> <3EC9807D.3080804@kegel.com> <Pine.LNX.4.55.0305191743230.6565@bigblue.dev.mcafeelabs.com> <20030520010258.GQ2444@holomorphy.com>
In-Reply-To: <20030520010258.GQ2444@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> Davide Libenzi wrote:
> 
>>>>Adding a single shot feature to epoll takes about 5 lines of code,
>>>>comments included :) You know how many reuqests I had ? Zero, nada.
> 
> 
> On Mon, 19 May 2003, Dan Kegel wrote:
> 
>>>I thought edge triggered epoll *was* single-shot.
> 
> 
> On Mon, May 19, 2003 at 05:47:15PM -0700, Davide Libenzi wrote:
> 
>>For single shot I mean that once you receive one event, you will not
>>receive more events for that fd if you do not rearm it. Suppose you
>>receive 1000 bytes of data and you get an event (EPOLLIN). If after 10
>>seconds you receive another 1000 bytes, you will receive another event.
>>This is not single shot.
> 
> 
> I think this would be useful for network daemons that would like to
> fairly schedule responses (i.e. not re-arm until a client on a given fd
> deserves a turn again). IRC daemons would appear to be a perfect
> candidate for such.  ...

No need.  The plain old edge triggered behavior can handle this
nicely.
- Dan


-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

