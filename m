Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbTIVE3M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 00:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbTIVE3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 00:29:12 -0400
Received: from dyn-ctb-203-221-73-213.webone.com.au ([203.221.73.213]:58125
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S262769AbTIVE3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 00:29:08 -0400
Message-ID: <3F6E7A8A.8010604@cyberone.com.au>
Date: Mon, 22 Sep 2003 14:28:58 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Murray J. Root" <murrayr@brain.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-testX - strange scheduling(?) problem
References: <20030917050950.GC1376@Master> <3F67EFA1.30005@cyberone.com.au> <20030922024058.GA1348@Master>
In-Reply-To: <20030922024058.GA1348@Master>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Murray J. Root wrote:

>On Wed, Sep 17, 2003 at 03:22:41PM +1000, Nick Piggin wrote:
>
>>
>>Murray J. Root wrote:
>>
>>
>>>P4 2G
>>>1G PC2700 RAM
>>>GF2 GTS video (nv drivers, not nvidia)
>>>
>>>In all 2.6.0-test versions (1-5) I get very odd issues when using 
>>>cpu+memory
>>>intense apps. Using POV-Ray 3.5, for example:
>>>When I render an image I get about 15k pixels per second and the system is
>>>usable and responsive in other apps, most of the time.
>>>About 20% of the time the pixels-per-second is only 3k, the system is at
>>>nearly a standstill, and other apps barely function.
>>>I've tested it many times using the exact same image and the behavior is
>>>very consistent. Other apps do the same, but since I can't get a consistent
>>>starting state with them, I used POV-Ray for the testing.
>>>The slowdown is so bad that the screen can take as long as 2 seconds to 
>>>refresh, opening a term can take as much as 15 seconds.
>>>Stopping the render and restarting it fixes it about 1/2 the time. Stopping
>>>the render and switching to another app, then restarting the render fixes
>>>it about 1/2 the time. Enough stop & restarts always fixes it eventually.
>>>There doesn't appear to be any memory leakage, and the system isn't going
>>>into swap. Top shows the same numbers in all cases. Time of day, other 
>>>apps running, etc. makes no difference.
>>>
>>>
>>Hi Murray,
>>Thanks for reporting this. Its a very important issue. Would you please
>>try this patch:
>>http://ck.kolivas.org/patches/2.6/2.6.0-test5/patch-test5-O20int
>>on 2.6.0-test5, and report your results.
>>
>>If you get time, or if the above still has problems, you could try
>>http://www.kerneltrap.org/~npiggin/v15/sched-rollup-v15.gz
>>as well. Give priority to the first patch though, please.
>>
>>
>
>Using the first patch either fixed it or made it so rare I haven't seen it
>in 4 hours of testing.
>One side-effect - rendering seems to take about 20% longer, and top shows
>X using 20-25% cpu while rendering. Prior to 2.6.0-test[1-5] X never got
>up past 5% and generally hung around less than 1%.
>But user-feel is *much* better. No delays or "hangs" while typing or clicking
>even while running two renders at the same time.
>

CCing to the list. Sounds good. The longer rendering seems to be pretty
well in line with the CPU X is using. This is obviously fine and
desired. Thanks Murray, and good news, this patch will be included in
test6 as far as I can see.


