Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262913AbSJ1HLs>; Mon, 28 Oct 2002 02:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262914AbSJ1HLs>; Mon, 28 Oct 2002 02:11:48 -0500
Received: from pimout4-ext.prodigy.net ([207.115.63.103]:24488 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S262913AbSJ1HLm> convert rfc822-to-8bit; Mon, 28 Oct 2002 02:11:42 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: linux-kernel@vger.kernel.org
Subject: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge candidate list.
Date: Sun, 27 Oct 2002 21:17:56 -0500
User-Agent: KMail/1.4.3
Cc: reiser@namesys.com, alan@lxorguk.ukuu.org.uk, davem@redhat.com,
       boissiere@adiglobal.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210272017.56147.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the next to last posting of this list.  (When abbott and costello
meet the monster, its time is almost up.)  There will be at most one more,
tomorrow, and it may just be a repost of this cc'd to Linus.  (Those
of you waiting for the last minute, this would be it.)

Linus is definitely going to ignore the majority of this list.  The best
most of these patches can hope for is an explicit rejection, rather than a
drop-on-the-floor that might have been because he forgot it or didn't
see it.  If this list generates explicit rejections, it will have done
its job.

I didn't exactly sort the list, but I did move some stuff that's more likely
to go in after the freeze to the end.

David Miller: I have no IPV6 tree from you.

Reiser4 people: I still haven't seen a patch for it.  (You're in the
list because Hans is capable of making puppy eyes through email.)

Alan: I have no 32 bit dev_t patch.  And did this mean anything:
http://lwn.net/Articles/11583/

Everybody else, please proofread your entry.  I'm not looking to add
anything else to the list, but I am looking for last-minute objections.

And so:

================================= Intro ====================================

Linus is back from the Linux Lunacy Cruise.  Photos are available here:
http://www.geekcruises.com/Linux_Lunacy_02/pages/

And a few more here:
http://www.lnxfan.org/

The following features aim to be ready for submission to Linus by Monday,
October 28th (that's today, guys), to be considered for inclusion (in
2.5.45) before the feature freeze on Thursday, October 31 (halloween).

This list is just pending features trying to get in before feature freeze.
It's primarily for features that need more testing, or might otherwise get
forgotten in the rush.  If you want to know what's already gone in, or what's
being worked on for the next development cycle, or self-contained things that
might be merged during the stable series, check out:
http://kernelnewbies.org/status

Thanks to Rusty Russell and Guillaume Boissiere, whose respective 2.5 merge
candidate lists have been ruthlessly strip-mined in the process of
assembling this.  And to everybody who's emailed stuff.

And now, in no particular order:

============================ Pending features: =============================

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

1) Andrew Morton's -mm tree. (Andrew Morton, editor.)

Andrew Morton's -mm tree collates several other projects, including:

The ext2/ext3 Extended Attributes and Access Control Lists patch from Ted Tso
and Andreas Gruenbacher (ext23-*.patch), Page Table Sharing from Daniel
Phillips and Dave McCracken (shpte-ng.patch), a bunch of huge page upgrades
from Bill Irwin (hugetlb*.patch), the orlov allocator, Ingo's generic
nonlinear mappings...

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
http://lists.insecure.org/lists/linux-kernel/2002/Oct/9043.html

Download:
http://www.xs4all.nl/~zippel/lc/

Linus has actually looked fairly favorably on this one so far:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/3250.html

And an AOL for it:

http://lists.insecure.org/lists/linux-kernel/2002/Oct/8255.html

----------------------------------------------------------------------------

5) Linux Trace Toolkit (LTT) (Karim Yaghmour)

Announce:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/7016.html

Download:
http://opersys.com/ftp/pub/LTT/ExtraPatches/patch-ltt-linux-2.5.44-vanilla-021026-2.2.bz2

User tools:
http://opersys.com/ftp/pub/LTT/TraceToolkit-0.9.6pre2.tgz

----------------------------------------------------------------------------

6) Kernel Probes (IBM, contact: Vamsi Krishna S)

Kprobes announcement:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103528410215211&w=2

Download Base Kprobes Patch:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103528425615302&q=raw

KProbes->DProbes patches:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103528454215523&q=raw
http://marc.theaimsgroup.com/?l=linux-kernel&m=103528454015520&q=raw
http://marc.theaimsgroup.com/?l=linux-kernel&m=103528485415813&q=raw

Download gzipped tarball patches from official IBM site:
http://www-124.ibm.com/linux/patches/?project_id=141

The DProbes Home Page:
http://oss.software.ibm.com/developerworks/opensource/linux/projects/dprobes

A good explanation of the difference between kprobes, dprobes,
and kernel hooks:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103532874900445&w=2

And a clarification: just kprobes is being submitted for 2.5.45, (and
optionally some basic dprobes support,) but not the whole of dprobes:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103536827928012&w=2

----------------------------------------------------------------------------

7) Posix support and High Resolution timers (George Anzinger)

George has a patch that provides posix support, and on top of that a
patch to provide high resolution timers.  He talks about it here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103562196700924&w=2

The project's home page is here:
http://high-res-timers.sourceforge.net/

Downloadable patches may be found here:
http://sourceforge.net/project/showfiles.php?group_id=20460&release_id=118345

And descriptions for each patch (in the order they should be applied) are
available here (although in this case the archive truncates the patches
themselves, use the download link above):
http://marc.theaimsgroup.com/?l=linux-kernel&m=103553654329827&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103557676007653&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103557677207693&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103558349714128&w=2

Linus had concerns with this one a while back:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/3463.html

----------------------------------------------------------------------------

8) Posix timers alternate implementation (Jim Houston)

Jim Houston has an alternate patch to provide posix support (but not
high resolution timers on top of it, yet).

http://marc.theaimsgroup.com/?l=linux-kernel&m=103549000027416&q=raw

----------------------------------------------------------------------------

9) Linux Kernel Crash Dumps (Matt Robinson, LKCD team)

Announce:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103553563728914&w=2
And again:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103536576625905&w=2

Download:
http://lkcd.sourceforge.net/download/latest/

----------------------------------------------------------------------------

10) Rewrite of the console layer (James Simmons)

Announcement:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103487329526903&w=2

Home page:
http://linuxconsole.sourceforge.net/

Downloadable patch:
http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

Bitkeeper tree:
bk://fbdev.bkbits.net/fbdev-2.5

----------------------------------------------------------------------------

11) IPv6 upgrades and crypto API (Yoshifuji Hideyaki)

The Usagi ipv6 upgrades have been available for a while, and their
author would like to see them in 2.5:

README:
ftp://ftp.linux-ipv6.org/pub/usagi/patch/ipsec/README.IPSEC

Downloadable patch here:
ftp://ftp.linux-ipv6.org/pub/usagi/patch/ipsec/ipsec-2.5.43-ALL-03.patch.gz

Dave Miller is doing a major ipv6 layer rewrite, but no patch has been sent
to the list yet.  Ironically, James Morris has a Crypto API patch on top of
Dave Miller's tree:

Announce:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103559983324080&w=2

Download:
http://samba.org/~jamesm/crypto/

----------------------------------------------------------------------------

12) MMU-less processor support (Greg Ungerer)

Most recent announcement (with links):
http://marc.theaimsgroup.com/?l=linux-kernel&m=103578189421588&w=2

A version of this is in the 2.5-ac tree.  An announcement of a patch against
that is here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103578338922236&w=2

----------------------------------------------------------------------------

13) sys_epoll (I.E. /dev/poll) (Davide Libenzi)

Announce:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103542994232004&w=2

Homepage:
http://www.xmailserver.org/linux-patches/nio-improve.html

Download:
http://www.xmailserver.org/linux-patches/sys_epoll-2.5.44-last.diff

Linus participated repeatedly in a thread on this one too, expressing
concerns which (hopefully) have been addressed.  See:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6428.html

----------------------------------------------------------------------------

14) CD Recording/sgio patches (Jens Axboe)

Announce:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/8060.html

Download patch:
http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.44/sgio-15.bz2

This should be in Alan Cox's tree as of 2.4.44-ac4.

----------------------------------------------------------------------------

15) In-kernel module loader (Rusty Russell.)

Announce:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6214.html

Download patch:
http://www.kernel.org/pub/linux/kernel/people/rusty/patches/module-x86-18-10-2002.2.5.43.diff.gz

----------------------------------------------------------------------------

16) Unlimited groups patch (Tim Hockin.)

Announce:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103524761319825&w=2

Download patch set from:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103524717119443&q=raw
http://marc.theaimsgroup.com/?l=linux-kernel&m=103524761819834&q=raw
http://marc.theaimsgroup.com/?l=linux-kernel&m=103524761619831&q=raw
http://marc.theaimsgroup.com/?l=linux-kernel&m=103524761519829&q=raw

----------------------------------------------------------------------------

17) Initramfs (Al Viro)

Way back when, Al said:
http://www.cs.helsinki.fi/linux/linux-kernel/2001-30/0110.html

Download (most recent patch so far):
ftp://ftp.math.psu.edu/pub/viro/N0-initramfs-C40

And Linus recently made happy noises about the idea:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/1110.html

----------------------------------------------------------------------------

18) Kernel Hooks (IBM contact: Vamsi Krishna S.)

Website:
http://www-124.ibm.com/linux/projects/kernelhooks/

Download site:
http://www-124.ibm.com/linux/patches/?patch_id=595

Posted patch:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103364774926440&w=2

----------------------------------------------------------------------------

19) NMI request/release interface (Corey Minyard)

He says:
> Add a request/release mechanism to the kernel (x86 only for now) for NMIs.
...
>I have modified the nmi watchdog to use this interface, and it
>seems to work ok.  Keith Owens is copied to see if he would be
>interested in converting kdb to use this, if it gets put into the kernel.

There was a lot of back and forth, resulting in the latest patch (version 8):
http://home.attbi.com/~minyard/linux-nmi-v8.diff

----------------------------------------------------------------------------

20) DriverFS Topology (Matthew Dobson)

Announcement:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103523702710396&w=2

Patches:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103540707113401&q=raw
http://marc.theaimsgroup.com/?l=linux-kernel&m=103540757613962&q=raw
http://marc.theaimsgroup.com/?l=linux-kernel&m=103540758013984&q=raw
http://marc.theaimsgroup.com/?l=linux-kernel&m=103540757513957&q=raw
http://marc.theaimsgroup.com/?l=linux-kernel&m=103540757813966&q=raw

----------------------------------------------------------------------------

21) Advanced TCA Disk Hotswap (Steven Dake)

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

22) Mobile IPV6 (contact: Antti Tuominen)

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

23) SCSI multi-path I/O (Patrick Mansfield)

Announcement with URLs:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/8736.html

) VFS Intent Lookup Patch (Peter Braam)

Download:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103552797823568&q=raw

----------------------------------------------------------------------------

24) NUMA Scheduler Upgrade

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

The most current version of the patches are downloadable from:

http://home.arcor.de/efocht/sched/01-numa_sched_core-2.5.44-10a.patch
http://home.arcor.de/efocht/sched/02-numa_sched_ilb-2.5.44-10.patch

Martin J. Bligh has been testing both NUMA schedulers, and wandering
back and forth in his endorsement.  At first he was leaning towards
Erich's patch, now he seems to be leaning towards Michael's.

That thread is here:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/8904.html

----------------------------------------------------------------------------

25) ptrace over fork (Daniel Jacobowitz)

At the last possible second, this was submitted:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103574480632057&q=raw
http://marc.theaimsgroup.com/?l=linux-kernel&m=103574480232051&q=raw
http://marc.theaimsgroup.com/?l=linux-kernel&m=103574511932225&q=raw

----------------------------------------------------------------------------

26) Kexec, launch new linux kernel from Linux (Eric W. Biederman)

Announcement with links:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6584.html

And this thread is just too brazen not to include:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/7952.html

Most recent status announcement:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/8879.html

----------------------------------------------------------------------------

27) Nanosecond support in stat.

Discussion thread:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/8983.html

Download:
ftp://ftp.firstfloor.org/pub/ak/v2.5/nsec-2.5.44-2.bz2

----------------------------------------------------------------------------

28) Digital Video Broadcasting Layer (LinuxTV team)

Home page:
http://www.linuxtv.org:81/dvb/

Download:
http://www.linuxtv.org:81/download/dvb/

This is also in Alan Cox's 2.5 tree.

----------------------------------------------------------------------------

29) Reiser4.

I don't have a patch yet, but Hans Reiser is very insistent that this
will be ready by halloween.  (VERY insistent.)  I'll let him speak for
himself:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/8793.html

And again (promises, promises):
http://lists.insecure.org/lists/linux-kernel/2002/Oct/9082.html

Still no patch at the time of this writing, though.  In theory it
should show up here:
http://namesys.com/download.html

In the meantime, all I can find on Reiser4 is some kind of hybrid
marketing brochure/design document thing:
http://www.reiserfs.org/v4/v4.html

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
