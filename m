Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263216AbSJOHBy>; Tue, 15 Oct 2002 03:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263232AbSJOHBy>; Tue, 15 Oct 2002 03:01:54 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:13494 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S263216AbSJOHBx>;
	Tue, 15 Oct 2002 03:01:53 -0400
Message-ID: <3DABBEB9.7040004@candelatech.com>
Date: Tue, 15 Oct 2002 00:07:37 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: "Feldman, Scott" <scott.feldman@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>
Subject: Re: Update on e1000 troubles (over-heating!)
References: <288F9BF66CD9D5118DF400508B68C44604758B78@orsmsx113.jf.intel.com> <3DABAACE.9040706@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

> 
> I get some strange e1000 failures too.  It usually involves the watchdog 
> kicking them back into order, but sometimes they'll stay offline for a 
> while.  Heat would explain it, though, because it only happens when I'm 
> actually using the cards for a benchmark.  I figured that it was either 
> my cables, or a shoddy switch.
> 
> The new dual-port e1000 that I have doesn't seem to have this problem, 
> even though I'm running 4 times more traffic than the singles that I had.

That was exactly the behaviour I noticed.  I believe it's because when you
run two side-by-side, they cook each other (I'm assuming you didn't run
2 2-ports side-by-side)

Try strapping a fan on them somehow and I bet all your troubles go
away (and maybe your .ibm email will shame Intel into putting heat-sinks
and/or small fans on their NICs... ;)

(I ran two Netgear 302t NICs (tigon-3) side-by-side for 4 days at max speed, and they
  didn't drop a single packet, even though their heat-sinks were too hot to
  touch!)

Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


