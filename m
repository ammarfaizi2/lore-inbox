Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264521AbTIDDNC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 23:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264512AbTIDDNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 23:13:01 -0400
Received: from anumail2.anu.edu.au ([150.203.2.42]:26317 "EHLO anu.edu.au")
	by vger.kernel.org with ESMTP id S264521AbTIDDM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 23:12:57 -0400
Message-ID: <3F56AD28.7080902@cyberone.com.au>
Date: Thu, 04 Sep 2003 13:10:32 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Diego Calleja Garc?a <diegocg@teleline.es>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm5
References: <20030902231812.03fae13f.akpm@osdl.org> <20030904010852.095e7545.diegocg@teleline.es> <20030904020445.GN16361@matchmail.com>
In-Reply-To: <20030904020445.GN16361@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Sender-Domain: cyberone.com.au
X-Spam-Score: (-3)
X-Spam-Tests: EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MOZILLA_UA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:

>On Thu, Sep 04, 2003 at 01:08:52AM +0200, Diego Calleja Garc?a wrote:
>
>>El Tue, 2 Sep 2003 23:18:12 -0700 Andrew Morton <akpm@osdl.org> escribi?:
>>
>>
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm5/
>>>
>>>. Dropped out Con's CPU scheduler work, added Nick's.  This is to help us
>>>  in evaluating the stability, efficacy and relative performance of Nick's
>>>  work.
>>>
>>>  We're looking for feedback on the subjective behaviour and on the usual
>>>  server benchmarks please.
>>>
>>
>>I must say that this one doesn't feel nice under heavy gcc load. Huge mp3
>>skips that didn't happened before, big pauses in X...gcc starves anything else.
>>-mm4 was better there.
>>
>
>Can you put your Xserver back to nice -10, and try again?
>

This would help X, but regardless mp3 playing should not skip. I think its
giving newly forked children much too high a priority. Basically new 
children
can't get less than 50% sleep time, which is stupid on my behalf because a
program which continually forks children that do a little bit of work then
exit would basically be at 50% sleep time when it should be at or close 
to 0.


