Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265290AbSJXCUI>; Wed, 23 Oct 2002 22:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265291AbSJXCUI>; Wed, 23 Oct 2002 22:20:08 -0400
Received: from pc132.utati.net ([216.143.22.132]:45441 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S265290AbSJXCUC> convert rfc822-to-8bit; Wed, 23 Oct 2002 22:20:02 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: linux-kernel@vger.kernel.org
Subject: Crunch time -- the musical.  (2.5 merge candidate list 1.5)
Date: Wed, 23 Oct 2002 16:26:12 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210231626.12903.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel hooks is back with new links.  Also new versions of Linux Trace Tookit
and sys_epoll.  And new stuff from the 2.5 status list, and new stuff is STILL
showing up on linux-kernel.  (Still no 2.5 patch for Alan's 32 bit dev_t,
though.)

Richard J. Moore has stepped up to defend "VM Large Page support",
which has become "hugetlb update".  I don't know if this counts as
a new feature or a bugfix, but it's back...

Due to numerous complaints (okay, one, but technically that's a number)
tried to reformat a bit to have a slightly less eye-searingly hideous layout.
And reorganized the -mm stuff to be together in one clump.

And so:

----------

Linus returns from the Linux Lunacy Cruise after Sunday, October 27th.
(See "http://www.geekcruises.com/itinerary/ll2_itinerary.html".  He's
off to Jamaica, mon.)

The following features aim to be ready for submission to Linus by Monday,
October 28th, to be considered for inclusion (in 2.5.45) before the feature
freeze on Thursday, October 31 (halloween).  (L minus four days, and
counting...)

Note: if you want to submit a new entry to this list, PLEASE provide a URL
to where the patch can be found, and any descriptive announcement you think
useful (user space tools, etc).  This doesn't have to be a web page devoted
to the patch, if the patch has been posted to linux-kernel a URL to the post
on any linux-kernel archive site is fine.

If you don't know of one, a good site for looking at the threaded archive is:
http://lists.insecure.org/lists/linux-kernel/

A more searchable archive is available at:
http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&group=mlist.linux.kernel

This archive seems less likely to mangle your patch for cut and pasting
(especially if you click "raw download" at the top of the message),
although its a real pain to actualy try to read:
http://marc.theaimsgroup.com/?l=linux-kernel

This list is just pending features trying to get in before feature freeze.
It's primarily for features that need more testing, or might otherwise get
forgotten in the rush.  If you want to know what's already gone in, or what's
being worked on for the next development cycle, check out
"http://kernelnewbies.org/status".

You can get Andrew Morton's MM tree here, including a broken-out patches
directory and a description file:

http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.44

Alan Cox's -ac tree comes from here:

http://www.kernel.org/pub/linux/kernel/people/alan/

Thanks to Rusty Russell and Guillaume Boissiere, whose respective 2.5 merge
candidate lists have been ruthlessly strip-mined in the process of
assembling this.  And to everybody who's emailed stuff.

And now, in no particular order:

============================ Pending features: =============================

1) New kernel configuration system (Roman Zippel)

Announcement:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6898.html

Code:
http://www.xs4all.nl/~zippel/lc/

Linus has actually looked fairly favorably on this one so far:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/3250.html

----------------------------------------------------------------------------

2) ext2/ext3 extended attributes and access control lists (Ted Tso) (in -mm)

Announce:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6787.html

Code:
bk://extfs.bkbits.net/extfs-2.5-update
http://thunk.org/tytso/linux/extfs-2.5
(Or just grab it from the -mm tree.)

(Considering that EA/ACL infrastructure is already in, and supported by XFS
and JFS, this one's pretty close to a shoe-in.)

----------------------------------------------------------------------------

3) Page table sharing  (Daniel Phillips, Dave McCracken) (in -mm)

Announce:
http://www.geocrawler.com/mail/msg.php3?msg_id=7855063&list=35

Patch from the -mm tree:
http://www.zipworld.com.au/~akpm/linux/patches/2.5/2.5.44/2.5.44-mm3/broken-out/shpte-ng.patch

Ed Tomlinson seems to have a show-stopper bug for this one
(although he tells me in email he'd like to see it go in anyway):

http://lists.insecure.org/lists/linux-kernel/2002/Oct/7147.html

----------------------------------------------------------------------------

4) Improved Hugetlb support (Richard J. Moore) (in -mm tree)

(Dunno if this is exactly a feature, but giving it the benfit of the doubt...)

Description:
http://www.zipworld.com.au/~akpm/linux/patches/2.5/2.5.44/2.5.44-mm3/description

Patches (everything starting with "htlb" or "hugetlb"):
http://www.zipworld.com.au/~akpm/linux/patches/2.5/2.5.44/2.5.44-mm3/broken-out/

----------------------------------------------------------------------------

5) Generic Nonlinear Mappings (Ingo Molnar) (in -mm)

It's new, very close to deadline, needs testing and discussion.  I'm still a
touch vague on what it actually does, but there's a thread.

Announcement, patch, and start of thread:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103530883511032&w=2

----------------------------------------------------------------------------

6) Linux Trace Toolkit (LTT) (Karim Yaghmour)

Announce:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/7016.html

Patch:
http://opersys.com/ftp/pub/LTT/ExtraPatches/patch-ltt-linux-2.5.44-vanilla-021022-2.2.bz2

User tools:
http://opersys.com/ftp/pub/LTT/TraceToolkit-0.9.6pre2.tgz

----------------------------------------------------------------------------

7) Device mapper for Logical Volume Manager (LVM2)  (LVM2 team)  (in -ac)

Announce:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103536883428443&w=2

Download:
http://people.sistina.com/~thornber/patches/2.5-stable/

Home page:
http://www.sistina.com/products_lvm.htm

----------------------------------------------------------------------------

8) EVMS (Enterprise Volume Management System) (EVMS team)

Home page:
http://sourceforge.net/projects/evms

----------------------------------------------------------------------------

9) Kernel Probes (IBM, contact: Vamsi Krishna S)

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

10) High resolution timers (George Anzinger, etc.)

Home page:
http://high-res-timers.sourceforge.net/

Patch via evil sourceforge download auto-mirror thing:
http://prdownloads.sourceforge.net/high-res-timers/hrtimers-support-2.5.36-1.0.patch?download

Linus has unresolved concerns with this one, by the way:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/3463.html

Note: The Google posix timer patch forwarded by Jim Houston is being
merged into this patch:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/8068.html

----------------------------------------------------------------------------

11) Linux Kernel Crash Dumps (Matt Robinson, LKCD team)

Announce:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103536576625905&w=2

Code:
http://lkcd.sourceforge.net/download/latest/

----------------------------------------------------------------------------

12) Rewrite of the console layer (James Simmons)

Home page:
http://linuxconsole.sourceforge.net/

Patch (Unknown version, but home page only has random CVS du jour link.):
http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

Bitkeeper tree:
http://linuxconsole.bkbits.net


----------------------------------------------------------------------------

13) Kexec, luanch new linux kernel from Linux (Eric W. Biederman)

Announcement with links:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6584.html

And this thread is just too brazen not to include:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/7952.html

----------------------------------------------------------------------------

14) USAGI IPv6 (Yoshifujy Hideyaki)

README:
ftp://ftp.linux-ipv6.org/pub/usagi/patch/ipsec/README.IPSEC

Patch:
ftp://ftp.linux-ipv6.org/pub/usagi/patch/ipsec/ipsec-2.5.43-ALL-03.patch.gz

----------------------------------------------------------------------------

15) MMU-less processor support (Greg Ungerer)

Announcement with lots of links:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/7027.html

----------------------------------------------------------------------------

16) sys_epoll (I.E. /dev/poll) (Davide Libenzi)

homepage:
http://www.xmailserver.org/linux-patches/nio-improve.html

patch:
http://www.xmailserver.org/linux-patches/sys_epoll-2.5.44-0.7.diff

Linus participated repeatedly in a thread on this one too, expressing
concerns which (hopefully) have been addressed.  See:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6428.html

----------------------------------------------------------------------------

17) CD Recording/sgio patches (Jens Axboe)

Announce:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/8060.html

Patch:
http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.44/sgio-14b.diff.bz2

----------------------------------------------------------------------------

18) In-kernel module loader (Rusty Russell.)

Announce:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6214.html

Patch:
http://www.kernel.org/pub/linux/kernel/people/rusty/patches/module-x86-18-10-2002.2.5.43.diff.gz

----------------------------------------------------------------------------

19) Unified Boot/Module parameter support (Rusty Russell)

Note: depends on in-kernel module loader.

Huge disorganized heap 'o patches with no explanation:
http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Module/

----------------------------------------------------------------------------

20) Hotplug CPU Removal (Rusty Russell)

Even bigger, more disorganized Heap 'o patches:
http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Hotplug/

----------------------------------------------------------------------------

21) Unlimited groups patch (Tim Hockin.)

Announce:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103524761319825&w=2

Patch set:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103524717119443&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103524761819834&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103524761619831&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103524761519829&w=2

----------------------------------------------------------------------------

22) Initramfs (Al Viro)

Way back when, Al said:
http://www.cs.helsinki.fi/linux/linux-kernel/2001-30/0110.html

I THINK this is the most recent patch:
ftp://ftp.math.psu.edu/pub/viro/N0-initramfs-C40

And Linus recently made happy noises about the idea:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/1110.html

----------------------------------------------------------------------------

23) Kernel Hooks (IBM contact: Vamsi Krishna S.)

Website:
http://www-124.ibm.com/linux/projects/kernelhooks/

Download site:
http://www-124.ibm.com/linux/patches/?patch_id=595

Posted patch:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103364774926440&w=2

----------------------------------------------------------------------------

24) NMI request/release interface (Corey Minyard)

He says:
> Add a request/release mechanism to the kernel (x86 only for now) for NMIs.
...
>I have modified the nmi watchdog to use this interface, and it
>seems to work ok.  Keith Owens is copied to see if he would be
>interested in converting kdb to use this, if it gets put into the kernel.

The latest patch so far:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103540434409894&w=2

----------------------------------------------------------------------------

25) Digital Video Broadcasting Layer (LinuxTV team)

Home page:
http://www.linuxtv.org:81/dvb/

Download:
http://www.linuxtv.org:81/download/dvb/

----------------------------------------------------------------------------

26) NUMA aware scheduler extenstions (Erich Focht, Michael Hohnbaum)

Home page:
http://home.arcor.de/efocht/sched/

Patch:
http://home.arcor.de/efocht/sched/Nod20_numa_sched-2.5.31.patch

----------------------------------------------------------------------------

27) DriverFS Topology (Matthew Dobson)

Announcement:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103523702710396&w=2

Patches:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103540707113401&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103540757613962&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103540758013984&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103540757513957&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103540757813966&w=2

----------------------------------------------------------------------------

28) Advanced TCA Disk Hotswap (Steven Dake)

At the last minute, Steven Dake submitted (and if he'd cc'd the list, I could
have linked to this message as the announcement, hint hint...):

> Please add to your 2.5.45 list:
>
> "Advanced TCA Disk Hotswap".
>
> This is a generic feature that provides good hotswap support for SCSI
> and FibreChannel disk devices.  The entire SCSI layer has been properly
> analyzed to provide correct locking and a complete RAMFS filesystem is
> available to control the kernel disk hotswap operations.
>
> Both Alan Cox and Greg KH have looked at the patch for 2.4 and suggested
> if I ported to 2.5 and made some changes (as I have in the latest port)
> this feature would be a good candidate for the 2.5 kernel.
>
> The sourceforge site for the latest patches is:
> https://sourceforge.net/projects/atca-hotswap/
>
> The lkml announcement for this latest port is:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103541572622729&w=2
>
> A thread discussing Advanced TCA hotswap (of which this partch is one
> part of) can be found at:
> http://marc.theaimsgroup.com/?t=103462115700001&r=1&w=2
>
> Thanks!
> -steve


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

5) ReiserFS 4

Hans Reiser said:

> We will send Reiser4 out soon, probably around the 27th.
>
> Hans

See also http://www.namesys.com/v4/fast_reiser4.html

Hans and Jens Axboe are arguing about whether or not Reiser4 is a
potential post-freeze addition.  That thread starts here:

http://lists.insecure.org/lists/linux-kernel/2002/Oct/7140.html

6) 32bit dev_t

Alan Cox said:

> The big one missing is 32bit dev_t. Thats the killer item we have left.

But did not provide a URL to a patch.  Presumably, it's in his tree and
is capable of being extracted out of it, so I guess it's already in
good hands?  (I dunno, ask him.)

He also mentioned:

> Oh other one I missed - DVB layer - digital tv etc. Pretty much
> essential now for europe, but again its basically all driver layer

But it's not clear this is an item that must go in before feature freeze
or not at all, which is what this list tries to focus on.

Then Dan Kegel pointed out:

> One possible page to quote for 32 bit dev_t:
> http://lwn.net/Articles/11583/

7) Online EXT3 resize support:

A thread over whether or not this is self-contained enough and low
enough impact to go in after the freature freeze starts here:

http://lists.insecure.org/lists/linux-kernel/2002/Oct/7680.html

I mention it just in case it isn't.  (We've had offline EXT3 resize for
a while, this is apparently twiddling a mounted partition without
unplugging it first, or even wearing rubber boots.)

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
