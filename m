Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291767AbSCDGLA>; Mon, 4 Mar 2002 01:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291775AbSCDGKv>; Mon, 4 Mar 2002 01:10:51 -0500
Received: from smtp.mailbox.net.uk ([195.82.125.32]:28606 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S291767AbSCDGKh>; Mon, 4 Mar 2002 01:10:37 -0500
Date: Mon, 4 Mar 2002 06:08:53 +0000 (GMT)
From: Jon Masters <jonathan@jonmasters.org>
To: Andrew Morton <akpm@zip.com.au>
cc: Jon Masters <jonathan@jonmasters.org>, linux-kernel@vger.kernel.org
Subject: Re: Loopback (2.4.18)
In-Reply-To: <3C830842.A00609FE@zip.com.au>
Message-ID: <Pine.LNX.4.10.10203040601050.2990-100000@router>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Mar 2002, Andrew Morton wrote:

> The loop driver does really naughty things which defeat the kernel's
> management of dirty data.  It's quite easy to livelock machines with
> it, especially if you increase the dirty buffer thresholds.

I'd appreciate it if you could go in to more detail off list, out of
a general interest I have here.

> I expect the problem will go away if you drop the dirty buffer
> thresholds:
> 
> 	echo 10 0 0 0 500 3000 25 0 0 > /proc/sys/vm/bdflush
> 
> Could you please try that?

Unfortunately not today or probably earlier this week as I'm about to be
150 miles away from the office back in the land of cs.nott.ac.uk and am
planning to avoid late night sysrq fun over a serial console this week :-)

> Also, if/when it locks up again, the SYSRQ-P information will be
> interesting.  Use the key sequence several times, record the EIP values,
> look them up after reboot.   Probably, they point at shrink_cache().

Well, at least this kernel should have kernel debugging enabled so if/when
it happens again or I get chance to look at it over this week I'll lookup
where it's happening - for now all I need to know is that loopback still
isn't kosher on 2.4 and I need to avoid it by using a 2.2 box or whatever.

Jon.

