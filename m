Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262599AbVDGUvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbVDGUvn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 16:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbVDGUvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 16:51:42 -0400
Received: from alog0057.analogic.com ([208.224.220.72]:4838 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262599AbVDGUvT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 16:51:19 -0400
Date: Thu, 7 Apr 2005 16:50:32 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.11 can't disable CAD
In-Reply-To: <20050407202059.GA414@delft.aura.cs.cmu.edu>
Message-ID: <Pine.LNX.4.61.0504071639060.4895@chaos.analogic.com>
References: <Pine.LNX.4.61.0504071102590.4871@chaos.analogic.com>
 <20050407202059.GA414@delft.aura.cs.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2005, Jan Harkes wrote:

> On Thu, Apr 07, 2005 at 11:16:14AM -0400, Richard B. Johnson wrote:
>> In the not-too distant past, one could disable Ctl-Alt-DEL.
>> Can't do it anymore.
> ...
>> Observe that reboot() returns 0 and `strace` understands what
>> parameters were passed. The result is that, if I hit Ctl-Alt-Del,
>> `init` will still execute the shutdown-order (INIT 0).
>
> Actually, if CAD is enabled in the kernel, it will just reboot.
> If CAD is disabled in the kernel a SIGINT is sent to pid 1 (/sbin/init).
>

No, that's not how it ever worked. There are parameters that are
available in the reboot-system call that define the operation that
will occur when the 3-finger salute occurs.

Execute man 2 reboot.

> So what you probably had in the not-too-distant past was a disabled CAD
> in the kernel _and_ you had modified the following line in /etc/inittab,
>

The systems to which I refer do not, and never even had a file-system,
much-less any inittab. That's SYS-V init stuff for interactive access.

>    # What to do when CTRL-ALT-DEL is pressed.
>    ca:12345:ctrlaltdel:/sbin/shutdown -t1 -a -r now
>
> AFAIK this hasn't ever really changed.
>
> Jan
>

The kernel's response (or the 'C' runtime-library interface) has
changed so that it is now possible for somebody at the keyboard
of a machine to destroy the machine's operation by executing
Ctl-Alt-Del. I don't know how long this potential catastrophe
has existed, but when the machine(s) were initially certified
there was no possible way for a user to kill the machine from
the keyboard.

It is possible that a 'C' runtime library was changed in the
tarket so it's not a kernel problem. I'm checking it out now.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
