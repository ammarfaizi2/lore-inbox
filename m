Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTJWXTk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 19:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbTJWXTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 19:19:40 -0400
Received: from relay.pair.com ([209.68.1.20]:5897 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S261868AbTJWXTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 19:19:38 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3F9862BD.9010708@kegel.com>
Date: Thu, 23 Oct 2003 16:22:37 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031008
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: suparna@in.ibm.com, daniel@osdl.org, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, pbadari@us.ibm.com,
       Adrian Bunk <bunk@fs.tum.de>
Subject: Re: Patch for Retry based AIO-DIO (Was AIO and DIO testing on 2.6.0-test7-mm1)
References: <1066432378.2133.40.camel@ibm-c.pdx.osdl.net>	<20031020142727.GA4068@in.ibm.com>	<1066693673.22983.10.camel@ibm-c.pdx.osdl.net>	<20031021121113.GA4282@in.ibm.com>	<1066869631.1963.46.camel@ibm-c.pdx.osdl.net>	<20031023104923.GA11543@in.ibm.com>	<20031023135030.GA11807@in.ibm.com> <20031023155937.41b0eeda.akpm@osdl.org>
In-Reply-To: <20031023155937.41b0eeda.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> 
>>It turns out that backing out gcc-Os.patch (on RH 9) or switching 
>>to a system with an older compiler version made those errors go away.
> 
> 
> Ho hum, so we have our answer.
> 
> Adrian, how do you feel about slotting this under CONFIG_EMBEDDED?

I dunno about Adrian, but I'd rest easier either way
if we knew which optimization in -Os causes the problem,
and whether this is a compiler bug.

http://gcc.gnu.org/onlinedocs/gcc-3.3.1/gcc/Optimize-Options.html#Optimize%20Options
has a nice list of the optimizations performed by -O2, but
the list for -Os is a bit fuzzy, darn it.
- Dan

p.s. For the curious, the url of that patch seems to be
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test8/2.6.0-test8-mm1/broken-out/gcc-Os.patch

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

