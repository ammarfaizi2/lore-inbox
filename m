Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262792AbSJWDNh>; Tue, 22 Oct 2002 23:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262795AbSJWDNh>; Tue, 22 Oct 2002 23:13:37 -0400
Received: from pc132.utati.net ([216.143.22.132]:14465 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S262792AbSJWDNd> convert rfc822-to-8bit; Tue, 22 Oct 2002 23:13:33 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: linux-kernel@vger.kernel.org
Subject: Crunch Time, in 3D!  (2.5 final merge candidate list, v 1.4)
Date: Tue, 22 Oct 2002 17:19:41 -0500
User-Agent: KMail/1.4.3
Cc: "Guillaume Boissiere" <boissiere@adiglobal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210221719.41868.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sigh, silly me.  All the kernel hooks patches
(http://www-124.ibm.com/linux/projects/kernelhooks/releases/)
Are against 2.4, not 2.5.  I can't find ANY patch against
2.5.  So that's dropped.

Similarly, the "VM Large Page Support", which is a pretty vague
entry in the 2.5 status list (attributed to "many people" and
pointing to http://lse.sf.net which is an umbrealla organization
for many smaller projects), has managed to avoid all efforts
to track down a related patch.  Rohit Seth at intel seems to think
it might be this patch:

http://marc.theaimsgroup.com/?l=linux-kernel&m=102824901019428&w=2

Which already went in.  So until somebody steps up claim that
"VM Large Page Support" is not the same as hugetlb patch Linus
already merged, that's out.

You'll notice that several other patches are diffed against stuff
earlier than 2.4.44.  It might be a REALLY GOOD IDEA to re-diff the
sucker against the latest linux kernel, even if the current patch
applies cleanly.  Just for the look of the thing.  Shows you're paying
attention, and presumably that you tested it and it didn't break.  (If
I missed a newer version, please tell me.  It can take some hunting
through these home pages to find an actual patch URL...)

Also, if a directory contains a bunch of patches, and there's no
indication of what patches should be applied in which order to get
what (except possibly by reading all the patches, which don't even
necessarily specify which kernel version they apply to...  Remember,
Linus is sometimes even lazier than I am.  Amazing, but true.)

Other stuff: Collated Rusty's latest list
(http://marc.theaimsgroup.com/?l=linux-kernel&m=103526149231407&w=2),
went and examined various home pages to try to find the most recent
version of stuff, incorporated various emails, and updated Linus's
position on the Linux Lunacy Cruise.

And so:

----------

Linus returns from the Linux Lunacy Cruise after Sunday, October 27th.

(By the time you read this, Linus should have left Cozumel, Mexico
and be.  En route to Georgetown, Grand Cayman.  See
"http://www.geekcruises.com/itinerary/ll2_itinerary.html".
Strangely, Linus isn't signed up to give any seminars...
http://www.geekcruises.com/seminar/ll2_seminar.html
I wonder if he's attending any?)

The following features aim to be ready for submission to Linus by Monday,
October 28th, to be considered for inclusion (in 2.5.45) before the feature
freeze on Thursday, October 31 (halloween).

Note: if you want to submit a new entry to this list, PLEASE provide a URL
to where the patch can be found, and any descriptive announcement you think
useful (user space tools, etc).  This doesn't have to be a web page devoted
to the patch, if the patch has been posted to linux-kernel a URL to the post
on any linux-kernel archive site is fine.

If you don't know of one, a good site for looking at the threaded archive is:
http://lists.insecure.org/lists/linux-kernel/
and a more searchable archive is available at:
http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&group=mlist.linux.kernel
This archive seems less likely to mangle your patch for cut and pasting,
although its a real pain to actualy try to read:
http://marc.theaimsgroup.com/?l=linux-kernel

This list is just pending features trying to get in before feature freeze.
If you want to know what's already gone in, or what's being worked on for
the next development cycle, check out "http://kernelnewbies.org/status".

You can get Andrew Morton's MM tree here:

http://www.zipworld.com.au/~akpm/linux/patches/2.5

And Alan Cox's -ac tree here:

http://www.kernel.org/pub/linux/kernel/people/alan/

Thanks to Rusty Russell and Guillaume Boissiere, whose respective 2.5 merge
candidate lists have been ruthlessly strip-mined in the process of
assembling this.

And now, in no particular order:

============================ Pending features: =============================

1) Roman  Zippel's new kernel configuration system.
Announce: http://lists.insecure.org/lists/linux-kernel/2002/Oct/6898.html
Code: http://www.xs4all.nl/~zippel/lc/

Linus has actually looked fairly favorably on this one so far:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/3250.html

2) Ted Tso's new ext2/ext3 code with extended attributes and access control
lists.
Announce: http://lists.insecure.org/lists/linux-kernel/2002/Oct/6787.html
Code: bk://extfs.bkbits.net/extfs-2.5-update 
http://thunk.org/tytso/linux/extfs-2.5

Andreas Dilger says ext3 EA+ACL is now in the -mm tree.

3) Linux Trace Toolkit (LTT) (Karim Yaghmour)
Announce: http://lists.insecure.org/lists/linux-kernel/2002/Oct/7016.html
Patch: 
http://opersys.com/ftp/pub/LTT/ExtraPatches/patch-ltt-linux-2.5.44-vanilla-021019-2.2.bz2
User tools: http://opersys.com/ftp/pub/LTT/TraceToolkit-0.9.6pre2.tgz

4) Device mapper for Logical Volume Manager (LVM2)  (LVM2 team)  (in -ac tree)
http://www.sistina.com/products_lvm.htm

5) EVMS (Enterprise Volume Management System) (EVMS team)
http://sourceforge.net/projects/evms

6) Page table sharing  (Daniel Phillips, Dave McCracken) (in -mm tree)
http://www.geocrawler.com/mail/msg.php3?msg_id=7855063&list=35
(A newer version of which seems to be at:)
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6446.html

Ed Tomlinson seems to have a show-stopper bug for this one, though:

http://lists.insecure.org/lists/linux-kernel/2002/Oct/7147.html

7) Kernel Probes/Dynamic Probes  (IBM dprobes team, contact: Vamsi Krishna S)
Note: DProbes is more or less a patch on top of KProbes, but KProbes
claims to be independently useful.

Kprobes announcement:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103528410215211&w=2
Base Kprobes Patch:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103528425615302&w=2
KProbes->DProbes patches:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103528454215523&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103528454015520&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103528485415813&w=2

See also the DProbes Home Page:
http://oss.software.ibm.com/developerworks/opensource/linux/projects/dprobes

A good explanation of the difference between kprobes, dprobes,
and kernel hooks is here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103532874900445&w=2

8) High resolution timers (George Anzinger, etc.)

Home page:
http://high-res-timers.sourceforge.net/

Patch via evil sourceforge download auto-mirror thing:
http://prdownloads.sourceforge.net/high-res-timers/hrtimers-support-2.5.36-1.0.patch?download

Linus has unresolved concerns with this one, by the way:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/3463.html

9) Linux Kernel Crash Dumps (Matt Robinson, LKCD team)

Announce: http://lists.insecure.org/lists/linux-kernel/2002/Oct/7060.html

Code: http://lkcd.sourceforge.net/download/latest/

10) Rewrite of the console layer (James Simmons)

Home page:
http://linuxconsole.sourceforge.net/

Patch (Unknown version, but home page only has random CVS du jour link.):
http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

11) Kexec, luanch new linux kernel from Linux (Eric W. Biederman)

Announcement with links:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6584.html

12) USAGI IPv6 (Yoshifujy Hideyaki)

README:
ftp://ftp.linux-ipv6.org/pub/usagi/patch/ipsec/README.IPSEC

Patch:
ftp://ftp.linux-ipv6.org/pub/usagi/patch/ipsec/ipsec-2.5.43-ALL-03.patch.gz

13) MMU-less processor support (Greg Ungerer)

Announcement with lots of links:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/7027.html

14) sys_epoll (I.E. /dev/poll) (Davide Libenzi)

homepage:
http://www.xmailserver.org/linux-patches/nio-improve.html

patch:
http://www.xmailserver.org/linux-patches/sys_epoll-2.5.44-0.5.diff

Linus participated repeatedly in a thread on this one too, expressing
concerns which (hopefully) have been addressed.  See:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6428.html

15) CD Recording/sgio patches (Jens Axboe)
http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.44/

16) In-kernel module loader (Rusty Russell.)

Announce:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6214.html

Patch:
http://www.kernel.org/pub/linux/kernel/people/rusty/patches/module-x86-18-10-2002.2.5.43.diff.gz

17) Unified Boot/Module parameter support (Rusty Russell)

Note: depends on in-kernel module loader.

Huge disorganized heap 'o patches with no explanation:
http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Module/

18) Hotplug CPU Removal (Rusty Russell)

Even bigger, more disorganized Heap 'o patches:
http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Hotplug/

19) Unlimited groups patch (Tim Hockin.)

Announce:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103524761319825&w=2

Patch set:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103524717119443&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103524761819834&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103524761619831&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=103524761519829&w=2

20) Initramfs (Al Viro)

Way back when, Al said:
http://www.cs.helsinki.fi/linux/linux-kernel/2001-30/0110.html

I THINK this is the most recent patch:
ftp://ftp.math.psu.edu/pub/viro/N0-initramfs-C40

And Linus recently made happy noises about the idea:
http://lists.insecure.org/lists/linux-kernel/2002/Oct/1110.html

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
or not at all.

7) EXT3 resize support:

A thread over whether or not this is self-contained enough and low
enough impact to go in after the freature freeze starts here:

http://lists.insecure.org/lists/linux-kernel/2002/Oct/7680.html

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
