Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261639AbSJVCgI>; Mon, 21 Oct 2002 22:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbSJVCgI>; Mon, 21 Oct 2002 22:36:08 -0400
Received: from pc132.utati.net ([216.143.22.132]:44416 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S261639AbSJVCgG> convert rfc822-to-8bit; Mon, 21 Oct 2002 22:36:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Son of crunch time: the list v1.2.
Date: Mon, 21 Oct 2002 16:42:10 -0500
User-Agent: KMail/1.4.3
Cc: Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
References: <20021021135137.2801edd2.rusty@rustcorp.com.au> <200210211536.25109.landley@trommello.org> <3DB4B1B9.4070303@pobox.com>
In-Reply-To: <3DB4B1B9.4070303@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210211642.10435.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 October 2002 21:02, Jeff Garzik wrote:
> Rob Landley wrote:
> > 1) Roman  Zippel's new kernel configuration system.
> > Announce: http://lists.insecure.org/lists/linux-kernel/2002/Oct/6898.html
> > Code: http://www.xs4all.nl/~zippel/lc/
>
> I support merge, Linus seemed to support it with the caveat that he said
> he didn't personally see much discussion...

After CML2, I think everybody's too afraid to speak up. :)

> > 2) Ted Tso's new ext2/ext3 code with extended attributes and access
> > control lists.
> > Announce: http://lists.insecure.org/lists/linux-kernel/2002/Oct/6787.html
> > Code: bk://extfs.bkbits.net/extfs-2.5-update
> > http://thunk.org/tytso/linux/extfs-2.5
>
> No comment other than I notice tytso's patches got dropped (at least
> once/twice?).  Maybe viro hasn't reviewed them?

Reading meaning into Linus dropping patches without explanation is like 
reading meaning into sheep entrails.  (At least with the entrails, you know 
the future is likely to contain mutton.)

> > 5) VM large page support  (Many people) (in -mm tree)
> > http://lse.sourceforge.net/
>
> Rob - this URL doesn't seen to have anything directly to do with large
> page support.

I got the URL straight from Guillaume's list.  Haven't looked at it.  I don't 
use Oracle, and the largest box I have immediate access to has maybe 2 
gigabytes of memory in it.  (256 megs is pretty standard 'round here...)

> > 6) Page table sharing  (Daniel Phillips, Dave McCracken) (in -mm tree)
> > http://www.geocrawler.com/mail/msg.php3?msg_id=7855063&list=35
> > (A newer version of which seems to be at:)
> > http://lists.insecure.org/lists/linux-kernel/2002/Oct/6446.html
>
> IMO 2.7.x item...

Yes and no.  Rmap went in already, and this mostly counteracts rmap's main 
downside.  Still, it is cutting it a bit close...

> > 7) Dynamic Probes (dprobes team)
> > http://oss.software.ibm.com/developerworks/opensource/linux/projects/dpro
> >bes
>
> why does this need to be the mainline kernel?  this is another type of
> thing that can live as a patch, IMO...

Ask IBM. :)

> > 8) Zerocopy NFS (Hirokazu Takahashi)
> > http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.1/0429.html
>
> this is already merged, isn't it??

Another item straight from Guillaume's list...

> > 9) High resolution timers (George Anzinger, etc.)
> > http://high-res-timers.sourceforge.net/
>
> no comment, I've heard arguments that high-res timers would be useful,
> but haven't read the patch myself so won't comment...

I vaguely remember Linus had some objections that it plays with the clock tick 
and potentially penalizes everybody...  Hmmm...

A quick google comes up with this:

http://www.cs.helsinki.fi/linux/linux-kernel/2002-28/0360.html

> > 10) EVMS (Enterprise Volume Management System) (EVMS team)
> > http://sourceforge.net/projects/evms
>
> Sounds like 2.7.x material, viro pointed out several problems ...

This one's a problem.  LVM1 is dead, so either LVM2 or EVMS are needed to 
avoid a major functional regression vs 2.4...

> > 11) Linux Kernel Crash Dumps (Matt Robinson, LKCD team)
> > Announce: http://lists.insecure.org/lists/linux-kernel/2002/Oct/7060.html
> > Code: http://lkcd.sourceforge.net/
>
> I would personally _love_ to see this merged, but I think it's 2.7.x
> material given the recent comments (unless they get fixed up)

T minus 6 days, and counting... :)

> > 12) Rewrite of the console layer (James Simmons)
> > http://linuxconsole.sourceforge.net/
>
> needs more review... but hasn't some of this stuff already made it in?
> (or am I thinking about fbdev...?)

This and the page table sharing are probably the two that mean the most to me 
personally, actually.  Not that this is relevant... :)

> > 13) Kexec, luanch ELF format linux kernel from Linux (Eric W. Biederman)
> > http://lists.insecure.org/lists/linux-kernel/2002/Oct/6584.html
>
> Useful, but at the same time not many people will use this I think.  It
> may need to live as a patch for a while, if not for a long while...

I have an odd usage that would be helped by having the linux kernel and a 
ramdisk in the same image, but that's a question of getting support into lilo 
or grub, not the linux kernel itself.  There's probably already a way to do 
it (actually, I'm sure I could if I wanted to hack lilo), it just hasn't made 
it far enough up my to-do list yet...

> > 14) USAGI IPv6.
> >
> > Yoshifuji Hideyaki points out that ipv6 is very important overseas
> > (where some entire countries make do with a single class B ipv4
> >
> > address range).  He says:
> >>Well, our IPsec is ready, runs and is tested...
> >>ftp://ftp.linux-ipv6.org/pub/usagi/patch/ipsec/
>
> The USAGI guys have been slowly splitting up their patches and
> submitting them... AFAIK DaveM is just waiting on more split-up IPv6
> patches from them...

Okay, ARE the Usagi IPV6 patches and Dave's work dovetailing into one project?  
I'll happily collate them if so, I'd just like to hear it from one of the 
principal authors...

Rob
