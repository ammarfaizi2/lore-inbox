Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUAUHgU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 02:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbUAUHgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 02:36:20 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:39088 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262153AbUAUHgS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 02:36:18 -0500
Message-ID: <400E2ABA.2060809@cyberone.com.au>
Date: Wed, 21 Jan 2004 18:31:06 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Hockin <thockin@hockin.org>
CC: vatsa@in.ibm.com, Rusty Russell <rusty@au1.ibm.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR
References: <400CD4B5.6020507@cyberone.com.au> <20040120073032.GB12638@hockin.org> <400CDCA1.5070200@cyberone.com.au> <20040120075409.GA13897@hockin.org> <400CE354.8060300@cyberone.com.au> <20040120082943.GA15733@hockin.org> <400CE8DC.70307@cyberone.com.au> <20040120084352.GD15733@hockin.org> <20040121093633.A3169@in.ibm.com> <400DFC8B.7020906@cyberone.com.au> <20040121070939.GB31807@hockin.org>
In-Reply-To: <20040121070939.GB31807@hockin.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Tim Hockin wrote:

>On Wed, Jan 21, 2004 at 03:14:03PM +1100, Nick Piggin wrote:
>
>>Or doesn't anybody care to think about hoplug scripts failing?
>>(serious question)
>>
>
>If hotplug scripts are failing, you're in really deep trouble.  I can't find
>a single case where a hotplug script failing would not indicate some other
>larger failure.
>

sigh. threads-max, pid_max, ulimit, -ENOMEM, oom.

In my opinion, you can be in fine shape after one of the above happening,
and if limits _are_ in place, its reasonable to expect they're there because
they might get reached in rare cases.

I'd rather not add something that, by design can hang any number of 
processes
including the entire system if a hotplug script fails. Thats just my honest
opinion, I know its rare enough it probably would never happen to anyone.

Sorry I keep repeating this, its not my call and its never going to affect
me so I'll shut up now ;)


