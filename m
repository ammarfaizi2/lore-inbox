Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264394AbTEPJ0h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 05:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbTEPJ0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 05:26:37 -0400
Received: from mail.ipc-fabautomation.com ([195.145.106.210]:18308 "EHLO
	fw-blf2.ipc-kallmuenz.de") by vger.kernel.org with ESMTP
	id S264394AbTEPJ0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 05:26:35 -0400
Message-ID: <3EC4B1E8.67AFAFEE@ipc-fabautomation.com>
Date: Fri, 16 May 2003 11:39:52 +0200
From: np <np@ipc-fabautomation.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-4GB i686)
X-Accept-Language: en
MIME-Version: 1.0
To: masud@googgun.com
CC: linux-kernel@vger.kernel.org
Subject: RE:2.4.20 freeze problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

  The machine does not respond to ping either. I was not able until know
to hookup a serial console but I will try also that. 
I do not suspect a heating issue because I have another machine which
dies 
randomnessly( not always after 2 hours --- was my mistake ). I also
tried with 2.4.21-rc2 and I have the same behaviour. Complete stall.
Maybe some other ideeas ?

Cheers,
Nicu

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

bzImage will be the booted kernel but there is a corrosponding vmlinux
in
the main source directory. bzImage is simply a compressed version of
that,
you can use the vmlinux that was produced to look at the debug Info but
i
doubt you will get anything useful in the first glance.

> Any ideeas of how to move forward with this will be greatly appreciated.
> Cheers,
> Nicu

Is the userspace program interacting with the kernel in any way?

How is ram usage around say 1:45 minutes into the run?

Have you looked at heating issues? If this happens almost always around
2
hours later it could very well be that the problem may be heat related.
Or
that around that time you end up accessing a part of RAM that doesn't
get
accessed for a while and you have bad ram. If it were a kernel related
issue, i would expect more randomness in death.

Do you have network access to this system? Can you perhaps try to ping
it
when it is dead and see if you get a response back? That may indicate
whether it is actually the kernel dying or some thing that SEEMs as as
if
the kernel died.

Just because sysreq isn't working doesn't mean that the kernel has
frozen,
it could mean that your interaction with the bus may be a bit out of
whack, can you hook up a serial console to this thing and try from there
too?

Just a few thoughts :)

Ahmed.
