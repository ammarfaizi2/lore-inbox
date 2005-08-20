Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbVHTDpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbVHTDpL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 23:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbVHTDpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 23:45:11 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1029 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030186AbVHTDpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 23:45:09 -0400
Date: Sat, 20 Aug 2005 05:45:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] the big Documentation/Changes change
Message-ID: <20050820034501.GL3615@stusta.de>
References: <20050810011740.GR4006@stusta.de> <20050809203817.2225a33f.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050809203817.2225a33f.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 08:38:17PM -0700, Randy.Dunlap wrote:
> On Wed, 10 Aug 2005 03:17:40 +0200 Adrian Bunk wrote:
> 
> > I edited Documentation/Changes:
> > - remove obsolete information
> > - point to feature-list-2.6.txt instead of providing similar information
> > - removed the URLs of the software packages (people compiling their own
> >   kernel usually know where to find the required software)
> 
> I always found those real handy.

OK, I'll keep them.

> Overall, I find this a good idea.
> 
> > The resulting file is pretty short.
> 
> >  Documentation/Changes |  376 +-----------------------------------------
> >  1 files changed, 15 insertions(+), 361 deletions(-)
> > 
> > --- linux-2.6.13-rc5-mm1-full/Documentation/Changes.old	2005-08-10 03:01:11.000000000 +0200
> > +++ linux-2.6.13-rc5-mm1-full/Documentation/Changes	2005-08-10 03:12:12.000000000 +0200
> > @@ -1,435 +1,89 @@
> 
> > -Kernel compilation
> > -==================
> > +Notes
> > +=====
> > +
> > +Please read feature-list-2.6.txt for information about new features
> 
> We usually prefix Doc file names with Documentation/, even though
> this is in the same directory.

fixed

> but where is this file?  I can't find it.
> Ah, it's in -mm only.
> 
> > +and changes compared to 2.4 kernels.

Updated patch below.

> ~Randy

cu
Adrian


<--  snip  -->


I edited Documentation/Changes:
- remove obsolete information
- point to feature-list-2.6.txt instead of providing similar information
- misc small fixes


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/Changes |  295 +++---------------------------------------
 1 files changed, 27 insertions(+), 268 deletions(-)

--- linux-2.6.13-rc6-mm1-full/Documentation/Changes.old	2005-08-20 05:08:07.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/Documentation/Changes	2005-08-20 05:44:12.000000000 +0200
@@ -1,435 +1,194 @@
 Intro
 =====
 
 This document is designed to provide a list of the minimum levels of
-software necessary to run the 2.6 kernels, as well as provide brief
-instructions regarding any other "Gotchas" users may encounter when
-trying life on the Bleeding Edge.  If upgrading from a pre-2.4.x
-kernel, please consult the Changes file included with 2.4.x kernels for
-additional information; most of that information will not be repeated
-here.  Basically, this document assumes that your system is already
-functional and running at least 2.4.x kernels.
+software necessary to run the 2.6 kernels.
 
 This document is originally based on my "Changes" file for 2.0.x kernels
 and therefore owes credit to the same people as that file (Jared Mauch,
 Axel Boldt, Alessandro Sigala, and countless other users all over the
-'net).
+'net). Chris Ricker was the former maintainer of this file.
 
-The latest revision of this document, in various formats, can always
-be found at <http://cyberbuzz.gatech.edu/kaboom/linux/Changes-2.4/>.
-
-Feel free to translate this document.  If you do so, please send me a
+Feel free to translate this document. If you do so, please send a
 URL to your translation for inclusion in future revisions of this
 document.
 
-Smotrite file <http://oblom.rnc.ru/linux/kernel/Changes.ru>, yavlyaushisya
-russkim perevodom dannogo documenta.
-
-Visite <http://www2.adi.uam.es/~ender/tecnico/> para obtener la traducción
-al español de este documento en varios formatos.
-
 Eine deutsche Version dieser Datei finden Sie unter
-<http://www.stefan-winter.de/Changes-2.4.0.txt>.
-
-Last updated: October 29th, 2002
-
-Chris Ricker (kaboom@gatech.edu or chris.ricker@genetics.utah.edu).
+<http://www.stefan-winter.de/html/kernel_2_6_-_changes.html>.
 
 Current Minimal Requirements
 ============================
 
 Upgrade to at *least* these software revisions before thinking you've
 encountered a bug!  If you're unsure what version you're currently
-running, the suggested command should tell you.
+running, the suggested command should tell you. scripts/ver_linux is a
+helpful script for automating this task.
 
-Again, keep in mind that this list assumes you are already
-functionally running a Linux 2.4 kernel.  Also, not all tools are
-necessary on all systems; obviously, if you don't have any ISDN
-hardware, for example, you probably needn't concern yourself with
-isdn4k-utils.
+Not all tools are necessary on all systems; obviously, if you don't
+have any ISDN hardware, for example, you probably needn't concern yourself
+with isdn4k-utils.
 
 o  Gnu C                  2.95.3                  # gcc --version
 o  Gnu make               3.79.1                  # make --version
 o  binutils               2.12                    # ld -v
 o  util-linux             2.10o                   # fdformat --version
 o  module-init-tools      0.9.10                  # depmod -V
 o  e2fsprogs              1.29                    # tune2fs
 o  jfsutils               1.1.3                   # fsck.jfs -V
 o  reiserfsprogs          3.6.3                   # reiserfsck -V 2>&1|grep reiserfsprogs
 o  reiser4progs           1.0.0                   # fsck.reiser4 -V
 o  xfsprogs               2.6.0                   # xfs_db -V
 o  pcmciautils            004
-o  pcmcia-cs              3.1.21                  # cardmgr -V
 o  quota-tools            3.09                    # quota -V
 o  PPP                    2.4.0                   # pppd --version
 o  isdn4k-utils           3.1pre1                 # isdnctrl 2>&1|grep version
 o  nfs-utils              1.0.5                   # showmount --version
 o  procps                 3.2.0                   # ps --version
 o  oprofile               0.9                     # oprofiled --version
 o  udev                   058                     # udevinfo -V
 
-Kernel compilation
-==================
+Notes
+=====
+
+Please read Documentation/feature-list-2.6.txt for information about
+new features and changes compared to 2.4 kernels.
 
 GCC
 ---
 
 The gcc version requirements may vary depending on the type of CPU in your
-computer. The next paragraph applies to users of x86 CPUs, but not
-necessarily to users of other CPUs. Users of other CPUs should obtain
-information about their gcc version requirements from another source.
-
-The recommended compiler for the kernel is gcc 2.95.x (x >= 3), and it
-should be used when you need absolute stability. You may use gcc 3.0.x
-instead if you wish, although it may cause problems. Later versions of gcc 
-have not received much testing for Linux kernel compilation, and there are 
-almost certainly bugs (mainly, but not exclusively, in the kernel) that
-will need to be fixed in order to use these compilers. In any case, using
-pgcc instead of plain gcc is just asking for trouble.
+computer.
 
 The Red Hat gcc 2.96 compiler subtree can also be used to build this tree.
 You should ensure you use gcc-2.96-74 or later. gcc-2.96-54 will not build
 the kernel correctly.
 
-In addition, please pay attention to compiler optimization.  Anything
-greater than -O2 may not be wise.  Similarly, if you choose to use gcc-2.95.x
-or derivatives, be sure not to use -fstrict-aliasing (which, depending on
-your version of gcc 2.95.x, may necessitate using -fno-strict-aliasing).
-
-Make
-----
-
-You will need Gnu make 3.79.1 or later to build the kernel.
-
-Binutils
---------
-
-Linux on IA-32 has recently switched from using as86 to using gas for
-assembling the 16-bit boot code, removing the need for as86 to compile
-your kernel.  This change does, however, mean that you need a recent
-release of binutils.
-
-System utilities
-================
-
-Architectural changes
----------------------
-
-DevFS has been obsoleted in favour of udev
-(http://www.kernel.org/pub/linux/utils/kernel/hotplug/)
-
-32-bit UID support is now in place.  Have fun!
+Documentation
+-------------
 
 Linux documentation for functions is transitioning to inline
 documentation via specially-formatted comments near their
 definitions in the source.  These comments can be combined with the
 SGML templates in the Documentation/DocBook directory to make DocBook
 files, which can then be converted by DocBook stylesheets to PostScript,
 HTML, PDF files, and several other formats.  In order to convert from
 DocBook format to a format of your choice, you'll need to install Jade as
 well as the desired DocBook stylesheets.
 
-Util-linux
-----------
-
-New versions of util-linux provide *fdisk support for larger disks,
-support new options to mount, recognize more supported partition
-types, have a fdformat which works with 2.4 kernels, and similar goodies.
-You'll probably want to upgrade.
-
-Ksymoops
---------
-
-If the unthinkable happens and your kernel oopses, you'll need a 2.4
-version of ksymoops to decode the report; see REPORTING-BUGS in the
-root of the Linux source for more information.
-
-Module-Init-Tools
------------------
-
-A new module loader is now in the kernel that requires module-init-tools
-to use.  It is backward compatible with the 2.4.x series kernels.
-
-Mkinitrd
---------
-
-These changes to the /lib/modules file tree layout also require that
-mkinitrd be upgraded.
-
-E2fsprogs
----------
-
-The latest version of e2fsprogs fixes several bugs in fsck and
-debugfs.  Obviously, it's a good idea to upgrade.
-
-JFSutils
---------
-
-The jfsutils package contains the utilities for the file system.
-The following utilities are available:
-o fsck.jfs - initiate replay of the transaction log, and check
-  and repair a JFS formatted partition.
-o mkfs.jfs - create a JFS formatted partition.
-o other file system utilities are also available in this package.
-
-Reiserfsprogs
--------------
-
-The reiserfsprogs package should be used for reiserfs-3.6.x
-(Linux kernels 2.4.x). It is a combined package and contains working
-versions of mkreiserfs, resize_reiserfs, debugreiserfs and
-reiserfsck. These utils work on both i386 and alpha platforms.
-
-Reiser4progs
-------------
-
-The reiser4progs package contains utilities for the reiser4 file system.
-Detailed instructions are provided in the README file located at:
-<ftp://ftp.namesys.com/pub/reiser4progs/README>.
-
-Xfsprogs
---------
-
-The latest version of xfsprogs contains mkfs.xfs, xfs_db, and the
-xfs_repair utilities, among others, for the XFS filesystem.  It is
-architecture independent and any version from 2.0.0 onward should
-work correctly with this version of the XFS kernel code (2.6.0 or
-later is recommended, due to some significant improvements).
-
-PCMCIAutils
------------
-
-PCMCIAutils replaces pcmcia-cs (see below). It properly sets up
-PCMCIA sockets at system startup and loads the appropriate modules
-for 16-bit PCMCIA devices if the kernel is modularized and the hotplug
-subsystem is used.
-
 Pcmcia-cs
 ---------
 
 PCMCIA (PC Card) support is now partially implemented in the main
 kernel source. The "pcmciautils" package (see above) replaces pcmcia-cs
 for newest kernels.
 
-Quota-tools
------------
-
-Support for 32 bit uid's and gid's is required if you want to use
-the newer version 2 quota format.  Quota-tools version 3.07 and
-newer has this support.  Use the recommended version or newer
-from the table above.
-
-Intel IA32 microcode
---------------------
-
-A driver has been added to allow updating of Intel IA32 microcode,
-accessible as both a devfs regular file and as a normal (misc)
-character device.  If you are not using devfs you may need to:
-
-mkdir /dev/cpu
-mknod /dev/cpu/microcode c 10 184
-chmod 0644 /dev/cpu/microcode
-
-as root before you can use this.  You'll probably also want to
-get the user-space microcode_ctl utility to use with this.
-
 Powertweak
 ----------
 
 If you are running v0.1.17 or earlier, you should upgrade to
 version v0.99.0 or higher. Running old versions may cause problems
 with programs using shared memory.
 
-udev
-----
-udev is a userspace application for populating /dev dynamically with
-only entries for devices actually present. udev replaces devfs.
-
-Networking
-==========
-
-General changes
----------------
-
-If you have advanced network configuration needs, you should probably
-consider using the network tools from ip-route2.
-
-Packet Filter / NAT
--------------------
-The packet filtering and NAT code uses the same tools like the previous 2.4.x
-kernel series (iptables).  It still includes backwards-compatibility modules
-for 2.2.x-style ipchains and 2.0.x-style ipfwadm.
-
-PPP
----
-
-The PPP driver has been restructured to support multilink and to
-enable it to operate over diverse media layers.  If you use PPP,
-upgrade pppd to at least 2.4.0.
-
-If you are not using devfs, you must have the device file /dev/ppp
-which can be made by:
-
-mknod /dev/ppp c 108 0
-
-as root.
-
-If you use devfsd and build ppp support as modules, you will need
-the following in your /etc/devfsd.conf file:
-
-LOOKUP	PPP	MODLOAD
-
-Isdn4k-utils
-------------
-
-Due to changes in the length of the phone number field, isdn4k-utils
-needs to be recompiled or (preferably) upgraded.
-
-NFS-utils
----------
-
-In 2.4 and earlier kernels, the nfs server needed to know about any
-client that expected to be able to access files via NFS.  This
-information would be given to the kernel by "mountd" when the client
-mounted the filesystem, or by "exportfs" at system startup.  exportfs
-would take information about active clients from /var/lib/nfs/rmtab.
-
-This approach is quite fragile as it depends on rmtab being correct
-which is not always easy, particularly when trying to implement
-fail-over.  Even when the system is working well, rmtab suffers from
-getting lots of old entries that never get removed.
-
-With 2.6 we have the option of having the kernel tell mountd when it
-gets a request from an unknown host, and mountd can give appropriate
-export information to the kernel.  This removes the dependency on
-rmtab and means that the kernel only needs to know about currently
-active clients.
-
-To enable this new functionality, you need to:
-
-  mount -t nfsd nfsd /proc/fs/nfs
-
-before running exportfs or mountd.  It is recommended that all NFS
-services be protected from the internet-at-large by a firewall where
-that is possible.
-
 Getting updated software
 ========================
 
 Kernel compilation
 ******************
 
-gcc 2.95.3
-----------
-o  <ftp://ftp.gnu.org/gnu/gcc/gcc-2.95.3.tar.gz>
+gcc
+---
+o  <ftp://ftp.gnu.org/gnu/gcc/>
 
 Make
 ----
 o  <ftp://ftp.gnu.org/gnu/make/>
 
 Binutils
 --------
-o  <ftp://ftp.kernel.org/pub/linux/devel/binutils/>
+o  <ftp://ftp.gnu.org/gnu/binutils/>
 
 System utilities
 ****************
 
 Util-linux
 ----------
 o  <ftp://ftp.kernel.org/pub/linux/utils/util-linux/>
 
-Ksymoops
---------
-o  <ftp://ftp.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/>
-
 Module-Init-Tools
 -----------------
 o  <ftp://ftp.kernel.org/pub/linux/kernel/people/rusty/modules/>
 
-Mkinitrd
---------
-o  <ftp://rawhide.redhat.com/pub/rawhide/SRPMS/SRPMS/>
-
 E2fsprogs
 ---------
-o  <http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.29.tar.gz>
+o  <http://prdownloads.sourceforge.net/e2fsprogs/>
 
 JFSutils
 --------
 o  <http://jfs.sourceforge.net/>
 
 Reiserfsprogs
 -------------
-o  <http://www.namesys.com/pub/reiserfsprogs/reiserfsprogs-3.6.3.tar.gz>
+o  <http://www.namesys.com/pub/reiserfsprogs/>
 
 Reiser4progs
 ------------
 o  <ftp://ftp.namesys.com/pub/reiser4progs/>
 
 Xfsprogs
 --------
 o  <ftp://oss.sgi.com/projects/xfs/download/>
 
 Pcmciautils
 -----------
 o  <ftp://ftp.kernel.org/pub/linux/utils/kernel/pcmcia/>
 
-Pcmcia-cs
----------
-o  <http://pcmcia-cs.sourceforge.net/>
-
 Quota-tools
 ----------
 o  <http://sourceforge.net/projects/linuxquota/>
 
 DocBook Stylesheets
 -------------------
-o  <http://nwalsh.com/docbook/dsssl/>
+o  <http://docbook.sourceforge.net/projects/dsssl/>
 
 XMLTO XSLT Frontend
 -------------------
 o  <http://cyberelk.net/tim/xmlto/>
 
 Intel P6 microcode
 ------------------
 o  <http://www.urbanmyth.org/microcode/>
 
 Powertweak
 ----------
 o  <http://powertweak.sourceforge.net/>
 
 udev
 ----
 o <http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev.html>
 
 Networking
 **********
 
 PPP
 ---
-o  <ftp://ftp.samba.org/pub/ppp/ppp-2.4.0.tar.gz>
+o  <ftp://ftp.samba.org/pub/ppp/>
 
 Isdn4k-utils
 ------------
-o  <ftp://ftp.isdn4linux.de/pub/isdn4linux/utils/isdn4k-utils.v3.1pre1.tar.gz>
-
-NFS-utils
----------
-o  <http://sourceforge.net/project/showfiles.php?group_id=14>
+o  <ftp://ftp.isdn4linux.de/pub/isdn4linux/utils/>
 
 Iptables
 --------
 o  <http://www.iptables.org/downloads.html>
 
 Ip-route2
 ---------
-o  <ftp://ftp.tux.org/pub/net/ip-routing/iproute2-2.2.4-now-ss991023.tar.gz>
+o  <ftp://ftp.tux.org/pub/net/ip-routing/>
 
 OProfile
 --------
 o  <http://oprofile.sf.net/download/>
 
 NFS-Utils
 ---------
 o  <http://nfs.sourceforge.net/>
-

