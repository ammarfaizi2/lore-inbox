Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261283AbSJUI5l>; Mon, 21 Oct 2002 04:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261285AbSJUI5l>; Mon, 21 Oct 2002 04:57:41 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:12736 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S261283AbSJUI5i> convert rfc822-to-8bit; Mon, 21 Oct 2002 04:57:38 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: linux-kernel@vger.kernel.org
Subject: Crunch time continues: the merge candidate list v1.1
Date: Sun, 20 Oct 2002 23:03:46 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210202303.46848.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I've got Rusty's list collated with my list, plus several replies to
each thread.

There is no WAY all of this is making it into the 2.5 tree before the freeze,
but this is what's currently being submitted for consideration.

Rob

----

Linus returns from the Linux Lunacy Cruise after October 27th.  The following
features aim to be ready for submission to Linus by October 27th, to be
considered for inclusion (in 2.5.45) before the feature freeze on October 31.

Note: if you want to submit a new entry to this list, PLEASE provide a URL
to where the patch can be found, and any descriptive announcement you think
useful (user space tools, etc).  This doesn't have to be a web page devoted
to the patch, if the patch has been posted to linux-kernel a URL to the post
on any linux-kernel archive site is fine.

If you don't know of one, a good site for looking at the threaded archive is:
http://lists.insecure.org/lists/linux-kernel/
and a more searchable archive is available at:
http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&group=mlist.linux.kernel

Another good resource is http://kernelnewbies.org/status, from which about
half this list was shamelessly ripped. :)

And now, in no particular order:

============================ Pending features: =============================

1) Roman  Zippel's new kernel configuration system.
Announce: http://lists.insecure.org/lists/linux-kernel/2002/Oct/6898.html
Code: http://www.xs4all.nl/~zippel/lc/

2) Ted Tso's new ext2/ext3 code with extended attributes and access control
lists.
Announce: http://lists.insecure.org/lists/linux-kernel/2002/Oct/6787.html
Code: bk://extfs.bkbits.net/extfs-2.5-update http://thunk.org/tytso/linux/extfs-2.5

Andreas Dilger says ext3 EA+ACL is now in the -mm tree.

3) Linux Trace Toolkit (LTT) (Karim Yaghmour)

>From Karim:

> > http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.1/0832.html
>
> LTT has seen a number of changes since the posting above. Mainly,
> we've followed the recommendations of quite a few folks from the LKML.
> Here are some highlights summarizing the changes:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103491640202541&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103423004321305&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103247532007850&w=2
>
> The latest patch is available here:
> http://opersys.com/ftp/pub/LTT/ExtraPatches/patch-ltt-linux-2.5.44-vanilla-
>021019-2.2.bz2 Use this patch with version 0.9.6pre2 of the user tools:
> http://opersys.com/ftp/pub/LTT/TraceToolkit-0.9.6pre2.tgz
>
> Karim

4) PCMCIA Zoom video support (Alan Cox) (in -ac tree)
http://www.uwsg.iu.edu/hypermail/linux/kernel/0203.1/0326.html

5) Device mapper for Logical Volume Manager (LVM2)  (LVM2 team)  (in -ac tree)
http://www.sistina.com/products_lvm.htm

6) VM large page support  (Many people) (in -mm tree)
http://lse.sourceforge.net/

7) Page table sharing  (Daniel Phillips, Dave McCracken) (in -mm tree)
http://www.geocrawler.com/mail/msg.php3?msg_id=7855063&list=35
(A newer version of which seems to be at:)
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6446.html

8) Dynamic Probes (dprobes team)
http://oss.software.ibm.com/developerworks/opensource/linux/projects/dprobes

9) Zerocopy NFS (Hirokazu Takahashi) 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.1/0429.html

10) High resolution timers (George Anzinger, etc.)
http://high-res-timers.sourceforge.net/

11) EVMS (Enterprise Volume Management System) (EVMS team) 
http://sourceforge.net/projects/evms

12) Linux Kernel Crash Dumps (Matt Robinson, LKCD team)
http://lkcd.sourceforge.net/

13) Rewrite of the console layer (James Simmons) 
http://linuxconsole.sourceforge.net/

14) Kexec, luanch ELF format linux kernel from Linux (Eric W. Biederman)
http://lists.insecure.org/lists/linux-kernel/2002/Oct/6584.html

15) USAGI IPv6.

Yoshifuji Hideyaki points out that ipv6 is very important overseas
(where some entire countries make do with a single class B ipv4
address range).  He says:

> Well, our IPsec is ready, runs and is tested...
> ftp://ftp.linux-ipv6.org/pub/usagi/patch/ipsec/

16) MMU-less processor support.

Greg Ungerer wrote:

>Here's another feature I would like to see go in: MMU-less procesor support.
>
>Latest patches for the memory management changes are at:
>
>http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.44uc0-mm.patch.gz
>
>The core of this stuff has been around for years (earliest in 2.0.33),
>with a _lot_ of users (easily > 50000). And specifically these patches
>have been tracking every 2.5 release pretty much since it started.
>
>The other important peice with this is the FLAT format exe loader
>(binfmt_flat), patch at:
>
>http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.44uc0-binflat.patch.gz
>
>To make this truely useful though you also need some new archiecture
>support. Up to date patches for 2 of these are at:
>
>http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.44uc0-m68knommu.patch.gz
>http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.44uc0-v850.patch.gz
>
>These support the non-VM 68k processors (683XXX and ColdFire), and the
>NEC v850 family. [We have many more (ARM, SPARC, i960, etc) but they are
>not 2.5 ready yet].
>
>Also some drivers to go along with this, but I won't bother listing
>them here. See my other emails on the list for those patches...
>
>Regards
>Greg

======================== Unresolved issues: =========================

1) Kernel Probes  (Vamsi Krishna S)

Is this the same as dynamic probes?

2) In-kernel module loader (Rusty Russell)
3) Unified boot/parameter support (Rusty Russell)
4) Hotplug CPU removal (Rusty Russell)

Awaiting URLs from Rusty.

5) hyperthread-aware scheduler
6) connection tracking optimizations.

No URLs to patch.

7) IPSEC (David Miller, Alexy)
8) New CryptoAPI (James Morris)

David S. Miller said:

> No URLs, being coded as I type this :-)
>
> Some of the ipv4 infrastructure is in 2.5.44

Note, this may conflict with Yoshifuji Hideyaki's ipv6 ipsec stuff.  If not,
I'd like to collate or clarify the entries.)

9) Hans Reiser said:

> We will send Reiser4 out soon, probably around the 27th.
>
> Hans

10) Unlimited groups patch

Awaiting URL from Tim Hockin.
