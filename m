Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbTENONe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 10:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbTENONe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 10:13:34 -0400
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:63931 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id S262254AbTENONc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 10:13:32 -0400
Date: Wed, 14 May 2003 10:24:05 -0400 (EDT)
From: Ahmed Masud <masud@googgun.com>
To: <Nicolae_Popovici@mksinst.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20 freeze problem.
In-Reply-To: <OF699B450E.9BF05B14-ONC1256D26.00471201-C1256D26.00482FE7@mksinternal.com>
Message-ID: <Pine.LNX.4.33.0305141015300.10993-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 May 2003 Nicolae_Popovici@mksinst.com wrote:

> Hi  guys,
>
>  Here are the facts.
> I have a small user program and the latest 2.4.20 stable kernel.
> It is running on a board from IEI ( Wafer-5823 ) with a Cyrix 300 CPU.


>  What happens is that after 2 hours of running this user program the
> computer
> freezes. I have the linux crash dump compiled inside the kernel and
> activated

> along with the magic sysrq key. Nothing works. I get only some messages
> inside
> the /var/log/messages but none of them are related to the crash ( modprobe
> says it
> can not load some module ). I also get the kcore file but I am using a
> bzImage  jkernel and I am not able to
> load it in the gdb. Should I switch to a vmlinux image ?
>

bzImage will be the booted kernel but there is a corrosponding vmlinux in
the main source directory. bzImage is simply a compressed version of that,
you can use the vmlinux that was produced to look at the debug Info but i
doubt you will get anything useful in the first glance.

> Any ideeas of how to move forward with this will be greatly appreciated.
> Cheers,
> Nicu

Is the userspace program interacting with the kernel in any way?

How is ram usage around say 1:45 minutes into the run?

Have you looked at heating issues? If this happens almost always around 2
hours later it could very well be that the problem may be heat related. Or
that around that time you end up accessing a part of RAM that doesn't get
accessed for a while and you have bad ram. If it were a kernel related
issue, i would expect more randomness in death.

Do you have network access to this system? Can you perhaps try to ping it
when it is dead and see if you get a response back? That may indicate
whether it is actually the kernel dying or some thing that SEEMs as as if
the kernel died.

Just because sysreq isn't working doesn't mean that the kernel has frozen,
it could mean that your interaction with the bus may be a bit out of
whack, can you hook up a serial console to this thing and try from there
too?

Just a few thoughts :)

Ahmed.

