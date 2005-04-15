Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVDOSfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVDOSfq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 14:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVDOSfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 14:35:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44510 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261922AbVDOSdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 14:33:31 -0400
Date: Fri, 15 Apr 2005 20:33:27 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Allison <fireflyblue@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: Kernel Rootkits
Message-ID: <20050415183327.GA7422@pasky.ji.cz>
References: <17d79880504151115744c47bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17d79880504151115744c47bd@mail.gmail.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Fri, Apr 15, 2005 at 08:15:37PM CEST, I got a letter
where Allison <fireflyblue@gmail.com> told me that...
> hi,

Hello,

> I got the terminology mixed up. I guess what I really want to know is,
> what are the different types of exploits by which rootkits
> (specifically the ones that modify the kernel) can get installed on
> your system.(other than buffer overflow and somebody stealing the root
> password)
> 
> I know that SucKIT is a rootkit that gets loaded as a kernel module
> and adds new system calls. Some other rootkits change machine
> instructions in several kernel functions.

I think you are still confused. You are mixing two things:

(1) Getting enough access to the machine to load the rootkit

(2) Loading the rootkit smart enough to slip any detectors

The first part basically involves getting root access to the machine.
This is so broad area that it is out of scope of this mail, I guess, but
innumerable types of vulnerabilities exist, ranging from silly bugs in
programs running as root, to in-kernel bugs which let you elevate your
permissions from a regular user to superuser (root).

The second part is very broad too, I think you would be better off by
doing some research on your own - there are plenty of resources on the
net w.r.t. this. (I hope you are asking only in order to defend
yourself! ;-) Basically, rootkits can range from a set of
custom-tailored binaries like ps and ls which will hide the cracker's
files from you, to linux kernel modules which the attacker will load as
a regular kernel module, but which will then usually hide itself and
then again hide the cracker's files from you, only better. These are
already kind of old-fashioned now, though. E.g. the SucKIT rootkit
installs itself to the kernel by bypassing the traditional kernel module
installing mechanism and writing itself directly to the memory,
overriding certain kernel structures and therefore taking control over
it.

> Once these are loaded into the kernel, is there no way the kernel
> functions can be protected ?

once they are in the kernel, they can do anything they want. That's the
point of being in the kernel, after all.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
