Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTEGPH6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263869AbTEGPH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:07:58 -0400
Received: from watch.techsource.com ([209.208.48.130]:177 "EHLO techsource.com")
	by vger.kernel.org with ESMTP id S263861AbTEGPHr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:07:47 -0400
Message-ID: <3EB9250A.8030306@techsource.com>
Date: Wed, 07 May 2003 11:23:54 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Torsten Landschoff <torsten@debian.org>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de> <20030507143315.GA6879@stargate.galaxy> <20030507144736.GE8978@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



William Lee Irwin III wrote:

> 
> The kernel stack is (in Linux) unswappable memory that persists
> throughout the lifetime of a thread. It's basically how many threads
> you want to be able to cram into a system, and it matters a lot for
> 32-bit.
> 
> 

The point that may or may not have been obvious is that more than one 
kernel stack is hanging around.  One single 8k stack versus one single 
4k stack is a trivial difference, even for most embedded systems.  But 
this becomes a huge problem when you have numerous concurrent threads 
hanging around, one of which can be swapped out.  That eats memory fast.

Or am I getting it wrong?


