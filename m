Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271598AbRHZVfT>; Sun, 26 Aug 2001 17:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271599AbRHZVfK>; Sun, 26 Aug 2001 17:35:10 -0400
Received: from ool-18bc60e1.dyn.optonline.net ([24.188.96.225]:4104 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S271598AbRHZVfB>;
	Sun, 26 Aug 2001 17:35:01 -0400
Date: Sun, 26 Aug 2001 17:35:15 -0400 (EDT)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: <linux-kernel@vger.kernel.org>
Subject: [RFC] Documentation/ changes
Message-ID: <Pine.LNX.4.33.0108261731140.5038-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Just to put it out there...
Comments/Flames/Improvements?

Thanks,
Rob Radez

--- linux-2.4.9/Documentation/SubmittingPatches.orig	Sun Aug 26 16:06:54 2001
+++ linux-2.4.9/Documentation/SubmittingPatches	Sun Aug 26 16:10:18 2001
@@ -284,3 +284,10 @@



+5) Include relevant documentation.
+
+If you add a CONFIG_ entry, add a corresponding entry to
+Documentation/Configure.help. If you're adding stuff to /proc, your code adds
+kernel command-line arguments, or your module takes parameters, make sure to
+add a file in Documentation/ detailing what exactly those things do and how to
+use them.
--- linux-2.4.9/Documentation/SubmittingDrivers.orig	Sun Aug 26 15:46:37 2001
+++ linux-2.4.9/Documentation/SubmittingDrivers	Sun Aug 26 15:57:38 2001
@@ -16,7 +16,10 @@
 by the Linux assigned name and number authority (currently better
 known as H Peter Anvin). The site is http://www.lanana.org/. This
 also deals with allocating numbers for devices that are not going to
-be submitted to the mainstream kernel.
+be submitted to the mainstream kernel. Currently, Linus has disallowed
+allocation of new majors for 2.4 (see
+http://marc.theaimsgroup.com/?l=linux-kernel&m=98986825425771&w=2 for more
+info).

 If you don't use assigned numbers then when you device is submitted it will
 get given an assigned number even if that is different from values you may
@@ -33,6 +36,8 @@
 	the maintainer listed in MAINTAINERS in the kernel file. If the
 	maintainer does not respond or you cannot find the appropriate
 	maintainer then please contact Alan Cox <alan@lxorguk.ukuu.org.uk>
+	In general, please submit new drivers for inclusion in the 2.4 tree
+	before trying to add them to 2.2.

 Linux 2.4:
 	This kernel tree is under active development. The same rules apply
@@ -45,7 +50,8 @@
 What Criteria Determine Acceptance
 ----------------------------------

-Licensing:	The code must be released to us under the GNU General Public License.
+Licensing:	The code must be released to us under the GNU General Public
+		License.
 		We don't insist on any kind of exclusively GPL licensing,
 		and if you wish the driver to be useful to other communities
 		such as BSD you may well wish to release under multiple
@@ -112,7 +118,4 @@
 Kernel traffic:
 	Weekly summary of kernel list activity (much easier to read)
 	[http://kt.zork.net/kernel-traffic]
-
-Linux USB project:
-	http://sourceforge.net/projects/linux-usb/

--- linux-2.4.9/Documentation/KernelProjects.orig	Sun Aug 26 16:15:07 2001
+++ linux-2.4.9/Documentation/KernelProjects	Sun Aug 26 16:15:38 2001
@@ -0,0 +1,28 @@
+Kernel Projects:
+
+This is a quick list of major kernel projects. It is by no means complete and
+probably never will be. Feel free to e-mail updates to <rob@osinvestor.com>.
+
+Linux USB project:
+        http://sourceforge.net/projects/linux-usb/
+
+Netfilter project:
+	http://netfilter.samba.org/
+
+Linux ATA Development project:
+	http://www.linux-ide.org/
+
+Linux Memory Management:
+	http://www.linux-mm.org/
+
+Linux Scalability Effort:
+	http://lse.sf.net/
+
+Linux Kernel Janitors project:
+	http://www.sf.net/projects/kernel-janitor
+
+Linux HotPlug:
+	http://linux-hotplug.sf.net/
+
+Linux Assigned Names and Numbers Authority:
+	http://www.lanana.org/
--- linux-2.4.9/Documentation/CodingStyle.orig	Sun Aug 26 16:10:27 2001
+++ linux-2.4.9/Documentation/CodingStyle	Sun Aug 26 16:14:46 2001
@@ -233,3 +233,16 @@
 stable. All options that are known to trash data (experimental write-
 support for file-systems, for instance) should be denoted (DANGEROUS), other
 Experimental options should be denoted (EXPERIMENTAL).
+
+Also, make sure to add entries to Documentation/Configure.help for *any*
+CONFIG_ entries you add or change.
+
+		Chapter 8: Documentation
+
+There's no such thing as too much up to date documentation, so whenever you
+make a change that adds some configurable option, or changes an existing one,
+or is just plain confusing, document it! Feel free to add a file in
+Documentation/ or add entries to Documentation/Configure.help or update an
+existing Documentation/ file! It's much nicer to put it there than hidden in
+some sub-directory in the kernel tree, plus, it tastes yummy and has less fat
+too! You can't lose!


