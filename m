Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261755AbSJZBvr>; Fri, 25 Oct 2002 21:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261784AbSJZBvr>; Fri, 25 Oct 2002 21:51:47 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.103]:52446 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S261755AbSJZBvl> convert rfc822-to-8bit; Fri, 25 Oct 2002 21:51:41 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: linux-kernel@vger.kernel.org
Subject: The return of the return of crunch time (2.5 merge candidate list 1.6)
Date: Fri, 25 Oct 2002 15:57:55 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210251557.55202.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since last time (closing down the list):

On Thursday, the list hit 30 different features proposed for 2.5 integration.
That's too much, they're obviously not all going to get in, and I'm now tring
to collate the list into something vaguely reasonable.

The -mm tree is now listed as one (nicely broken-up) patch.  Anything in it,
Linus is bound to see, so it doesn't need to be tracked separately.

Some other things are low-impact enough they can go in during the stable
series.  Online EXT3 resize support (resizing a mounted ext3 partition
without having to unmount it first) seems to have resolved itself
into that category ( See thread at:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/7680.html ).
Reiser4 is probably in this category as well, since Reiser3 went into
the 2.4 stable series and Reiser4 claims to be a seperate filesystem
(like EXT2 and EXT3).  Add in the fact that Hans Reiser still hasn't
produced a patch yet, and the decision's pretty easy.  (If you disagree,
yell out now...)

I'm NOT going to list the post-freeze things, the 2.5 status list at
http://kernelnewbies.org/status does a fine job of that.

Most of the other "unresolved issues" are probably either in this category
or are going to have to wait for the next development series, because
nobody's piped up in support of them yet.  I'm going to drop those
by sunday.  If you have a concern on that list (or that should be
on that list), time is running out.

I'm also looking for other things that can similarly be removed from
this list and pushed for integration during the next stable series.
Criteria for this: no API changes, and no impact on people who don't
actually try to use the thing.

If people familiar with these features can suggest stuff that's
deferrable, please let me know.  I've been trying very hard not to make
judgement calls on these patches (not my job), but I'm certainly open
to advice.

And so:

================================= Intro ====================================

Linus returns from the Linux Lunacy Cruise after Sunday, October 27th.
The following features aim to be ready for submission to Linus by Monday,
October 28th, to be considered for inclusion (in 2.5.45) before the feature
freeze on Thursday, October 31 (halloween).

This list is just pending features trying to get in before feature freeze.
It's primarily for features that need more testing, or might otherwise get
forgotten in the rush.  If you want to know what's already gone in, or what's
being worked on for the next development cycle, or self-contained things that
might be merged during the stable series, check out:
http://kernelnewbies.org/status

Thanks to Rusty Russell and Guillaume Boissiere, whose respective 2.5 merge
candidate lists have been ruthlessly strip-mined in the process of
assembling this.  And to everybody who's emailed stuff.

============================ Pending features: =============================

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

1) Andrew Morton's -mm tree. (Andre Morton, editor.)

Andrew Morton's -mm tree collates several other projects, including:

The ext2/ext3 Extended Attributes and Access Control Lists patch from Ted Tso
(ext23-*.patch), Page Table Sharing from Danliel Phillips and Dave McCracken
(shpte-ng.patch), Andrew Morton's own deadline IO scheduler
(akpm-deadline.patch), a bunch of huge page upgrades from Richard J. Moore
(hugetlb*.patch), the orlov allocator, Ingo's generic nonlinear mappings...

Stuff.  Lots of stuff.

You can get Andrew Morton's MM tree from the following URL, including a
broken-out patches directory and a description file.  (The latest version
as of this writing is -mm5.)

http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.44

Issues: Did Ed Tomlinson's page table bug get fixed?

http://lists.insecure.org/lists/linux-kernel/2002/Oct/7147.html

----------------------------------------------------------------------------

2) Device mapper for Logical Volume Manager (LVM2)  (LVM2 team)  (in -ac)

Announce:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103536883428443&w=2

Download:
http://people.sistina.com/~thornber/patches/2.5-stable/

Home page:
http://www.sistina.com/products_lvm.htm

Note: this is in the 2.5-ac tree, available at:
http://www.kernel.org/pub/linux/kernel/people/alan/

----------------------------------------------------------------------------

3) EVMS (Enterprise Volume Management System) (IBM, Contact: Kevin Corry)

Fighting with LVM2 for a place in the tree, a bigger solution to a bigger
set of problems:

Home page:
http://sourceforge.net/projects/evms

Home page:
http://evms.sourceforge.net

Download:
http://evms.sourceforge.net/patches/

Some related discussions:
http://marc.theaimsgroup.com/?t=103359686900003&r=1&w=2
http://marc.theaimsgroup.com/?t=103439913000001&r=1&w=2
http://marc.theaimsgroup.com/?w=2&r=1&s=%5Bpatch%5D+evms+core&q=t

----------------------------------------------------------------------------

4) New kernel configuration system (Roman Zippel)

Announcement:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6898.html

Code:
http://www.xs4all.nl/~zippel/lc/

Linus has actually looked fairly favorably on this one so far:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/3250.html

And an AOL for it:

http://lists.insecure.org/lists/linux-kernel/2002/Oct/8255.html

----------------------------------------------------------------------------

5) Linux Trace Toolkit (LTT) (Karim Yaghmour)

Announce:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/7016.html

Patch:
http://opersys.com/ftp/pub/LTT/ExtraPatches/patch-ltt-linux-2.5.44-vanilla-021022-2.2.bz2

User tools:
http://opersys.com/ftp/pub/LTT/TraceToolkit-0.9.6pre2.tgz

----------------------------------------------------------------------------

6) Kernel Probes (IBM, contact: Vamsi Krishna S)

Kprobes announcement:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103528410215211&w=2

Base Kprobes Patch:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103528425615302&w=2

KProbes->DProbes patches:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103528454215523&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103528454015520&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103528485415813&w=2

Official IBM download site for most recent versions (gzipped
tarballs):
http://www-124.ibm.com/linux/patches/?project_id=141

See also the DProbes Home Page:
http://oss.software.ibm.com/developerworks/opensource/linux/projects/dprobes

A good explanation of the difference between kprobes, dprobes,
and kernel hooks is here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103532874900445&w=2

And a clarification: just kprobes is being submitted for
2.5.45, not the whole of dprobes:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103536827928012&w=2

----------------------------------------------------------------------------

7) High resolution timers (George Anzinger, etc.)

Home page:
http://high-res-timers.sourceforge.net/

Sourceforge download page for this patch:
http://sourceforge.net/projects/high-res-timers

Descriptions of each patch:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103557676007653&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103557677207693&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103558349714128&w=2

Linus had concerns with this one (possibly resolved?):
http://lists.insecure.org/lists/linux-kernel/2002/Oct/3463.html

----------------------------------------------------------------------------

8) Posix clocks and timers (non-highres) (George Anzinger or Jim Houston)

There are two different posix timer patches.  The one from George Anzinger
is here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103553654329827&w=2

An alternate version from Jim Houston is here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103549000027416&w=2

----------------------------------------------------------------------------

9) Linux Kernel Crash Dumps (Matt Robinson, LKCD team)

Announce:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103536576625905&w=2

Code:
http://lkcd.sourceforge.net/download/latest/

----------------------------------------------------------------------------

10) Rewrite of the console layer (James Simmons)

Home page:
http://linuxconsole.sourceforge.net/

Patch (Unknown version, but home page only has random CVS du jour link.):
http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

Bitkeeper tree:
http://linuxconsole.bkbits.net


----------------------------------------------------------------------------

11) Kexec, luanch new linux kernel from Linux (Eric W. Biederman)

Announcement with links:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6584.html

And this thread is just too brazen not to include:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/7952.html

----------------------------------------------------------------------------

12) USAGI IPv6 (Yoshifujy Hideyaki)

README:
ftp://ftp.linux-ipv6.org/pub/usagi/patch/ipsec/README.IPSEC

Patch:
ftp://ftp.linux-ipv6.org/pub/usagi/patch/ipsec/ipsec-2.5.43-ALL-03.patch.gz

----------------------------------------------------------------------------

13) MMU-less processor support (Greg Ungerer)

Announcement with lots of links:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/7027.html

----------------------------------------------------------------------------

14) sys_epoll (I.E. /dev/poll) (Davide Libenzi)

Announce:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103542994232004&w=2

homepage:
http://www.xmailserver.org/linux-patches/nio-improve.html

Auto-updating URL to most recent patch:
http://www.xmailserver.org/linux-patches/sys_epoll-2.5.44-last.diff

Linus participated repeatedly in a thread on this one too, expressing
concerns which (hopefully) have been addressed.  See:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6428.html

----------------------------------------------------------------------------

15) CD Recording/sgio patches (Jens Axboe)

Announce:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/8060.html

Patch:
http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.44/sgio-14b.diff.bz2

----------------------------------------------------------------------------

16) In-kernel module loader (Rusty Russell.)

Announce:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6214.html

Patch:
http://www.kernel.org/pub/linux/kernel/people/rusty/patches/module-x86-18-10-2002.2.5.43.diff.gz

----------------------------------------------------------------------------

17) Unified Boot/Module parameter support (Rusty Russell)

Note: depends on in-kernel module loader.

Huge disorganized heap 'o patches with no explanation:
http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Module/

----------------------------------------------------------------------------

18) Hotplug CPU Removal (Rusty Russell)

Even bigger, more disorganized Heap 'o patches:
http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Hotplug/

----------------------------------------------------------------------------

19) Unlimited groups patch (Tim Hockin.)

Announce:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103524761319825&w=2

Patch set:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103524717119443&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103524761819834&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103524761619831&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103524761519829&w=2

----------------------------------------------------------------------------

20) Initramfs (Al Viro)

Way back when, Al said:
http://www.cs.helsinki.fi/linux/linux-kernel/2001-30/0110.html

I THINK this is the most recent patch:
ftp://ftp.math.psu.edu/pub/viro/N0-initramfs-C40

And Linus recently made happy noises about the idea:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/1110.html

----------------------------------------------------------------------------

21) Kernel Hooks (IBM contact: Vamsi Krishna S.)

Website:
http://www-124.ibm.com/linux/projects/kernelhooks/

Download site:
http://www-124.ibm.com/linux/patches/?patch_id=595

Posted patch:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103364774926440&w=2

----------------------------------------------------------------------------

22) NMI request/release interface (Corey Minyard)

He says:
> Add a request/release mechanism to the kernel (x86 only for now) for NMIs.
...
>I have modified the nmi watchdog to use this interface, and it
>seems to work ok.  Keith Owens is copied to see if he would be
>interested in converting kdb to use this, if it gets put into the kernel.

There was a lot of back and forth, resulting in the latest patch (version 8):
http://marc.theaimsgroup.com/?l=linux-kernel&m=103555247911211&w=2

----------------------------------------------------------------------------

23) Digital Video Broadcasting Layer (LinuxTV team)

Home page:
http://www.linuxtv.org:81/dvb/

Download:
http://www.linuxtv.org:81/download/dvb/

----------------------------------------------------------------------------

24) DriverFS Topology (Matthew Dobson)

Announcement:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103523702710396&w=2

Patches:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103540707113401&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103540757613962&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103540758013984&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103540757513957&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103540757813966&w=2

----------------------------------------------------------------------------

25) Advanced TCA Disk Hotswap (Steven Dake)

Announcement of most recent patch, with links:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103558466315221&w=2

Steven's comments:

> This is a generic feature that provides good hotswap support for SCSI
> and FibreChannel disk devices.  The entire SCSI layer has been properly
> analyzed to provide correct locking and a complete RAMFS filesystem is
> available to control the kernel disk hotswap operations.
>
> Both Alan Cox and Greg KH have looked at the patch for 2.4 and suggested
> if I ported to 2.5 and made some changes (as I have in the latest port)
> this feature would be a good candidate for the 2.5 kernel.
>
> A thread discussing Advanced TCA hotswap (of which this partch is one
> part of) can be found at:
> http://marc.theaimsgroup.com/?t=103462115700001&r=1&w=2

----------------------------------------------------------------------------

26) Mobile IPV6 (contact: Antti Tuominen)

Antti Tuominen says:

> We've been working on an implementation of Mobility Support in IPv6
> specification, called MIPL Mobile IPv6 for Linux.  We are now trying
> to get it included in the kernel.  Mobile IPv6 is an integral part of
> the IPv6 protocol.
>
> We've had discussion with Alexey Kuznetsov and Dave Miller.  Dave says
> he does not know enough about IPv6, and trusts Alexey on this one.
> Alexey requested the patch to be split, which we did, and we are
> currently waiting for additional comments whether he is going to
> recommend inclusion.
>
> This project has nothing to do with USAGI IPv6 Project (though they do
> merge our code from time to time).  However, we would benefit from
> having IPSec support for IPv6 in the kernel.
>
> MIPL Mobile IPv6 for Linux Project site:
> http://www.mipl.mediapoli.com/
>
> Patches:
> http://www.mipl.mediapoli.com/patches/

----------------------------------------------------------------------------

27) NUMA Scheduler Upgrade

Erich Focht and Michael Hohnbaum have two different NUMA scheduler
patches.

Michael has a stripped down NUMA scheduler, which he says was created
because the full Node Affine NUMA Scheduler didn't look like it would
be ready for 2.5.  He talks about it here, with links to patches:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103548635122591&w=2

Meanwhile, Erich Focht says the full Node Affine Numa Scheduler is
indeed ready for 2.5, and already in use at customer sites.  He makes
his case here, with links to patches, home page, LWN review, etc:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103549657202782&w=2

Here's Erich's scheduler's home page:
http://home.arcor.de/efocht/sched/


======================== Unresolved issues: =========================

1) hyperthread-aware scheduler
2) connection tracking optimizations.

No URLs to patch.  Anybody want to come out in favor of these
with an announcement and pointer to a version being suggested
for inclusion?

3) IPSEC (David Miller, Alexy)
4) New CryptoAPI (James Morris)

David S. Miller said:

> No URLs, being coded as I type this :-)
>
> Some of the ipv4 infrastructure is in 2.5.44

Note, this may conflict with Yoshifuji Hideyaki's ipv6 ipsec stuff.  If not,
I'd like to collate or clarify the entries.)  USAGI ipv6 is in the first
section and this isn't because I have a URL to an existing patch to
USAGI, and don't for this.  I have no idea how much overlap there is
between these projects, and whether they're considered parts of the
same project or submitted individually...

6) 32bit dev_t

Alan Cox said:

> The big one missing is 32bit dev_t. Thats the killer item we have left.

But did not provide a URL to a patch.  Presumably, it's in his tree and
is capable of being extracted out of it, so I guess it's already in
good hands?  (I dunno, ask him.)

Then Dan Kegel pointed out:

> One possible page to quote for 32 bit dev_t:
> http://lwn.net/Articles/11583/

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
