Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314602AbSGOOW6>; Mon, 15 Jul 2002 10:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317277AbSGOOW5>; Mon, 15 Jul 2002 10:22:57 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:20190 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314602AbSGOOW4>; Mon, 15 Jul 2002 10:22:56 -0400
Message-ID: <3D32DB43.3040906@us.ibm.com>
Date: Mon, 15 Jul 2002 07:25:07 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a+) Gecko/20020712
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Serial: updated serial drivers
References: <20020707010009.C5242@flint.arm.linux.org.uk> <20020715100310.GF23693@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Sun, Jul 07, 2002 at 01:00:09AM +0100, Russell King wrote:
> 
>>I've been maintaining a serial driver "off the side" of the ARM port
>>which cleans up the serial driver mess that we currently have, with
>>many duplications of serial.c, each with subtle bugs.
> 
> 
> global_cli() overhead on my testbox is a significant problem.
> 
> Profile info from tbench 1024 with ttyS0 as stdout, taken on a 16 cpu
> i386 box with 16GB of RAM and irqbalance disabled, (needed to boot):
> 
<snip profile>
 >
> The disabling of irqbalance should make these profiling results valid.

So, is irqbalance the thing that is screwing up our profiles on 2.5? 
We were getting some strage profiles that made us look at oprofile 
again.

oprofile is really cool, but readprofile is dead simple.
-- 
Dave Hansen
haveblue@us.ibm.com

