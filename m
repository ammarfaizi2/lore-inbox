Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261921AbSJVB4n>; Mon, 21 Oct 2002 21:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbSJVB4n>; Mon, 21 Oct 2002 21:56:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60165 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261921AbSJVB4l>;
	Mon, 21 Oct 2002 21:56:41 -0400
Message-ID: <3DB4B1B9.4070303@pobox.com>
Date: Mon, 21 Oct 2002 22:02:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: landley@trommello.org
CC: Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Son of crunch time: the list v1.2.
References: <20021021135137.2801edd2.rusty@rustcorp.com.au> <3DB3AB3E.23020.5FFF7144@localhost> <200210211536.25109.landley@trommello.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> 1) Roman  Zippel's new kernel configuration system.
> Announce: http://lists.insecure.org/lists/linux-kernel/2002/Oct/6898.html
> Code: http://www.xs4all.nl/~zippel/lc/

I support merge, Linus seemed to support it with the caveat that he said 
he didn't personally see much discussion...


> 2) Ted Tso's new ext2/ext3 code with extended attributes and access control
> lists.
> Announce: http://lists.insecure.org/lists/linux-kernel/2002/Oct/6787.html
> Code: bk://extfs.bkbits.net/extfs-2.5-update 
> http://thunk.org/tytso/linux/extfs-2.5

No comment other than I notice tytso's patches got dropped (at least 
once/twice?).  Maybe viro hasn't reviewed them?

IIRC viro had some objections to ACLs in general and how they might not 
necessarily actually improve security -- but I did not see detailed 
elaboration on this.


> 3) Linux Trace Toolkit (LTT) (Karim Yaghmour)
> Announce: http://lists.insecure.org/lists/linux-kernel/2002/Oct/7016.html
> Patch: 
> http://opersys.com/ftp/pub/LTT/ExtraPatches/patch-ltt-linux-2.5.44-vanilla-021019-2.2.bz2
> User tools: http://opersys.com/ftp/pub/LTT/TraceToolkit-0.9.6pre2.tgz

I dunno if this needs to be in the kernel...


> 4) Device mapper for Logical Volume Manager (LVM2)  (LVM2 team)  (in -ac tree)
> http://www.sistina.com/products_lvm.htm

Needs sysfs support or devmapperfs support... no need to add a bunch of 
ioctls that will go away eventually.


> 5) VM large page support  (Many people) (in -mm tree)
> http://lse.sourceforge.net/

Rob - this URL doesn't seen to have anything directly to do with large 
page support.

Others-
Is this not already in the kernel?  I still want to actually see someone 
from Oracle actually say "I will use this" or "we find this useful".

[I cynically propose a sys_oracle and be done with it <g>]


> 6) Page table sharing  (Daniel Phillips, Dave McCracken) (in -mm tree)
> http://www.geocrawler.com/mail/msg.php3?msg_id=7855063&list=35
> (A newer version of which seems to be at:)
> http://lists.insecure.org/lists/linux-kernel/2002/Oct/6446.html

IMO 2.7.x item...


> 7) Dynamic Probes (dprobes team)
> http://oss.software.ibm.com/developerworks/opensource/linux/projects/dprobes

why does this need to be the mainline kernel?  this is another type of 
thing that can live as a patch, IMO...


> 8) Zerocopy NFS (Hirokazu Takahashi)
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.1/0429.html

this is already merged, isn't it??


> 9) High resolution timers (George Anzinger, etc.)
> http://high-res-timers.sourceforge.net/

no comment, I've heard arguments that high-res timers would be useful, 
but haven't read the patch myself so won't comment...


> 10) EVMS (Enterprise Volume Management System) (EVMS team)
> http://sourceforge.net/projects/evms

Sounds like 2.7.x material, viro pointed out several problems ...


> 11) Linux Kernel Crash Dumps (Matt Robinson, LKCD team)
> Announce: http://lists.insecure.org/lists/linux-kernel/2002/Oct/7060.html
> Code: http://lkcd.sourceforge.net/

I would personally _love_ to see this merged, but I think it's 2.7.x 
material given the recent comments (unless they get fixed up)


> 12) Rewrite of the console layer (James Simmons)
> http://linuxconsole.sourceforge.net/

needs more review... but hasn't some of this stuff already made it in?
(or am I thinking about fbdev...?)

> 13) Kexec, luanch ELF format linux kernel from Linux (Eric W. Biederman)
> http://lists.insecure.org/lists/linux-kernel/2002/Oct/6584.html

Useful, but at the same time not many people will use this I think.  It 
may need to live as a patch for a while, if not for a long while...


> 14) USAGI IPv6.
> 
> Yoshifuji Hideyaki points out that ipv6 is very important overseas
> (where some entire countries make do with a single class B ipv4
> address range).  He says:
> 
> 
>>Well, our IPsec is ready, runs and is tested...
>>ftp://ftp.linux-ipv6.org/pub/usagi/patch/ipsec/

The USAGI guys have been slowly splitting up their patches and 
submitting them... AFAIK DaveM is just waiting on more split-up IPv6 
patches from them...


> 17) Kernel Hooks (IBM kernel team, contact: Richard J. Moore.)
> http://www-124.ibm.com/linux/projects/kernelhooks/

at first glance this seems to have serious issues with being a black 
hole for overriding syscalls-type behavior...


> 19) In-kernel module loader (Rusty Russell.)
> http://lists.insecure.org/lists/linux-kernel/2002/Oct/6214.html

most likely 2.7.x material

> 20) Unlimited groups patch (Tim Hockin.)

I dunno if people want to take the hit in the mainline kernel... Maybe 
this should be a CONFIG_xxx option, or live outside as a patch that 
enterprise customers integrate



> 8) ReiserFS 4
> 
> Hans Reiser said:
> 
> 
>>We will send Reiser4 out soon, probably around the 27th.

how mysterious...  ;-)


