Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265764AbUAKFTD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 00:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265766AbUAKFTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 00:19:03 -0500
Received: from stinkfoot.org ([65.75.25.34]:36994 "EHLO stinkfoot.org")
	by vger.kernel.org with ESMTP id S265764AbUAKFTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 00:19:00 -0500
Message-ID: <4000DCD0.6080904@stinkfoot.org>
Date: Sun, 11 Jan 2004 00:19:12 -0500
From: Ethan Weinstein <lists@stinkfoot.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20031224
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ed Tomlinson <edt@aei.ca>
Cc: linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: 2.6.1 and irq balancing
References: <40008745.4070109@stinkfoot.org> <200401102139.09883.edt@aei.ca>
In-Reply-To: <200401102139.09883.edt@aei.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson wrote:
> Hi,
> 
> What is the load on the box when this is happening?  If its low think
> this is optimal (for cache reasons).
> 

Admittedly, the machine's load was not high when I took this sample. 
However, creating a great deal of load does not change these statistics 
at all.  Being that there are patches available for 2.4.x kernels to fix 
this, I don't think this at all by design, but what do I know? =)

2.6.0 running on a non-HT SMP machine I have (old Compaq proliant 
2xPentium2) does interrupt on all CPU's with "noirqbalance" bootparam.

Regarding the keyboard, I noticed something interesting

2.6.1-rc1 shows the i8042 in /proc/interrupts:

   1:       1871          0          0          0    IO-APIC-edge  i8042

(keyboard still does not work, though..)

2.6.1 final does not show this at all, and [kseriod] eats a constant 5% 
  CPU.  Something's awry =)


-Ethan
