Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265140AbTAWMtC>; Thu, 23 Jan 2003 07:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265171AbTAWMtC>; Thu, 23 Jan 2003 07:49:02 -0500
Received: from 12-222-92-50.client.insightBB.com ([12.222.92.50]:28547 "EHLO
	lucky") by vger.kernel.org with ESMTP id <S265140AbTAWMtB>;
	Thu, 23 Jan 2003 07:49:01 -0500
Date: Thu, 23 Jan 2003 07:57:48 -0500
To: Jacek Radajewski <jacek@usq.edu.au>
Cc: linux-poweredge@dell.com, linux-kernel@vger.kernel.org
Subject: Re: 2650 - tg3 on 2.4.18-19.7.xsmp rh7.3 ... OOPS YET AGAIN
Message-ID: <20030123125748.GB3285@lucky>
Reply-To: shuey@purdue.edu
References: <08D7835AE15D6F4BABB5C46427F018DF0E608E@babbage.usq.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08D7835AE15D6F4BABB5C46427F018DF0E608E@babbage.usq.edu.au>
User-Agent: Mutt/1.5.3i
From: Michael Shuey <shuey@fmepnet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2003 at 09:27:40AM +1000, Jacek Radajewski wrote:
> is the network card really the problem ?  I don't want to be replacing all my network cards if the problem is elsewhere .... if you can understand the oops message please, please, please let me know where the problem is ...

You get oops messages?  You're lucky - our PE 2650s would just lock up solid.
No oops message, no crash dumps (if we used a kernel with that patch), no
console messages, nothing.  It would happen every 4-6 hours (and much sooner
when we tried a production-level amount of IO to the machine).  At the time
we were using 2.4.18-18.7.x from RedHat 7.3.

Not sure if it was the network card (tg3) or the RAID adapter (aacraid).  We
switched to 2.4.20, built with the same options (well, all that apply at any
rate) as the RedHat kernel.  We haven't had a single problem since.  You might
want to give that a try before replacing a pile of gigabit NICs....

-- 
Mike Shuey
