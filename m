Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbTHYDji (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 23:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbTHYDjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 23:39:37 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:51333
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261469AbTHYDjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 23:39:13 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: "Randy.Dunlap" <rddunlap@osdl.org>, Daniel Pezoa <dpforos@yahoo.com>
Subject: Re: patches question
Date: Sun, 24 Aug 2003 01:16:18 -0400
User-Agent: KMail/1.5
Cc: hahn@physics.mcmaster.ca, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0308191339430.1464-100000@coffee.psychology.mcmaster.ca> <20030820155956.67452.qmail@web11201.mail.yahoo.com> <20030820093347.4f024a89.rddunlap@osdl.org>
In-Reply-To: <20030820093347.4f024a89.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308240116.18764.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Speaking of which, here's the FAQ update patch I sent Richard last month, just 
in case anybody else finds it useful...

--------------------

Well, here it is.  I ended up completely redoing the section, sorting the data 
into some kind of order, marking deprecated links (stuff referring to 2.0, 
etc) and moving them to the end, grouping similar entries, adding new ones, 
and updating an awful lot of stale links that have moved since the FAQ was 
last updated.

I could try giving you a more gradual series of changes, but I'm about to hit 
the road for a while so I thought I'd send what I have.  Let me know if you 
want me to explain/tweak anything, but keep in mind I might not read my email 
for a week at a time...

Rob

--- index.html	2003-06-10 19:17:05.000000000 -0400
+++ lk-faq.html	2003-06-17 13:02:45.000000000 -0400
@@ -174,107 +174,142 @@
 <HR>
 <H3>
 <A NAME="blkd"></A>Basic Linux kernel documentation</H3>
-The following are <B>Linux</B> <B>kernel</B> related documents, which you
+The following are <B>Linux kernel</B> related documents, which you
 should take a look at <B>before</B> you post to the linux-kernel mailing
 list:
+
 <UL>
+<LI>
 
-<LI><B>
-<A HREF="http://www.linuxdoc.org/LDP/khg/HyperNews/get/khg.html">
-The Linux Kernel Hackers' Guide</A></B>,
-compiled by Michael K. Johnson of <A
-HREF="http://www.redhat.com/">Red Hat</A> fame. Includes among other
-documents selected Q/A's from the linux-kernel mailing list.
+<B><A HREF="http://www.tldp.org/docs.html">The Linux Documentation 
Project</a></B> is a comprehensive resource for Linux documentation, 
including guides, HOWTOs, man pages, FAQs, tutorials...  The LDP includes 
several particularly
+interesting resources, including:
+<UL>
+<LI>  <B><A HREF="http://en.tldp.org/HOWTO/Kernel-HOWTO/">The Linux Kernel 
HOWTO</A></B> by Brian Ward is required reading before posting to 
linux-kernel.  It explains how to compile, install, and run a Linux kernel.
 </LI>
-
-<LI><B>
-<A HREF="http://www.linuxdoc.org/LDP/tlk/tlk-toc.html">
-The Linux Kernel</A></B>
-book, by David A. Rusling, available in various formats from the
-<A HREF="http://www.linuxdoc.org/">Linux Documentation Project</A>
-and <A HREF="http://www.linuxdoc.org/mirrors.html">mirrors</A>.
-Still being worked on, but explains clearly the main structure of the
-Linux kernel.
+<LI>Robert Kiesling's <B><A HREF="http://en.tldp.org/FAQ/Linux-FAQ/">The 
Linux FAQ</A></B> is about the Linux Kernel and OS (not the linux-kernel 
mailing list).
 </LI>
+<LI>The <B><A href="http://www.tldp.org/links/devel.html">Linux Development 
Projects</A></B> page is a good index of other Linux resources available on 
the internet.
+</LI>
+</UL>
 
 <LI>
-<B><A HREF="http://www.linuxdoc.org/FAQ/Linux-FAQ/">The Linux FAQ</A></B>
-by Robert Kiesling has many high quality Q/A's.
+The Linux <B>kernel source code</B> for each kernel version comes with
+built-in technical documentation.
+
+<ul>
+<li>The <B>Documentation</B> directory holds an large number of useful text
+files about drivers, subsystems, locking rationale, coding style, etc.  The
+index file for them is <B>Documentation/00-INDEX</B>, although it doesn't 
list
+everything.  You will probably want to start by reading Changes, CodingStyle,
+SubmittingPatches, SubmittingDrivers, and BUG-HUNTING.</li>
+<li>A few important documentation files (including <B>MAINTAINERS</B>, 
<B>README</B>, and <B>REPORTING-BUGS</B>) live at the root of the 
linux-kernel source tree, not in the Documentation subdirectory.</li>
+<li>Recent kernel versions also have DocBook documentation built into
+the source tree, in specially formatted comments.  Typing "<B>make
+htmldocs</B>"at the top of the linux kernel tree (or "<B>make pdfdocs</B>",
+or "<B>make psdocs,</B>") will generate the selected documentation format in
+the Documentation/DocBook directory.  (There is still a lot of non-docbook
+documentation in the source code.  Conversion of these comments to
+DocBook is ongoing, but reading the source will always be a good idea.)</li>
+</ul>
 </LI>
 
-<LI>
-<B><A HREF="http://www.linuxdoc.org/HOWTO/Kernel-HOWTO.html">The Linux
-Kernel HOWTO</A></B> by Brian Ward.  Fundamental reading for anybody
-wanting to post to the linux-kernel mailing list.
+<LI>An invaluable resource for anyone who doesn't know where to start reading
+through the Linux kernel source code is <B><a 
href=http://www.moses.uklinux.net/patches/lki.html>Linux Kernel 2.4 
Internals</a></B> by Tigran Aivazian.
 </LI>
 
-<LI>
-A completely new <B>Kernelhacking-HOWTO</B> at
-<A HREF="http://www.kernelhacking.org/">http://www.kernelhacking.org/</A>.
-Currently work in progress, but already contains some useful information.
+<LI>To bring yourself up to speed on the differences between 2.4 and 2.5/2.6,
+read Jonathan Corbet's <B><a 
href=http://lwn.net/Articles/driver-porting/>Porting
+device drivers to 2.5</a></B>, a 30 article series for Linux Weekly News.
 </LI>
 
-<LI>
-Various Linux <B>
-<A HREF="http://www.linuxdoc.org/HOWTO/HOWTO-INDEX/index.html">HOWTOs</A></B>
-on specific questions, such as the <B>
-<A HREF="http://www.linuxdoc.org/HOWTO/mini/BogoMips.html">
-BogoMips mini-HOWTO</A></B> by Wim van Dorst. These are all by
-definition LDP documents.
+<LI>Mel Gorman's <B><a 
href=http://www.csn.ul.ie/~mel/projects/vm/guide/>Virtual
+memory Guides</a></B> are useful to anyone learning that subsystem.  (Read
+the "understanding" guide first, then "coding".)
 </LI>
 
 <LI>
-The Linux <B>kernel source code</B> for any particular kernel version
-that you may be using. Note that there is a /Documentation directory
-which holds some very useful text files about drivers, etc. Also check
-the MAINTAINERS file in the kernel source root directory.
+Another useful site is:
+<B><A 
HREF="http://www.kernelnewbies.org/">http://www.kernelnewbies.org/</A></B>
 </LI>
 
 <LI>
-Some drivers even have <B>Web pages</B>, with additional up to date
-information e.g. <A
-HREF="http://www.scyld.com/page/support/network/">the network drivers
-by Donald Becker</A>, etc. Check the <A
-HREF="http://www.linuxdoc.org/devel.html">Hardware section in the
-LDP site</A>.
+A google search is often the easiest way to find specialized web pages,
+mailing lists, or documentation for specific hardware,
+such as <A HREF="http://www.scyld.com/page/support/network/">the
+network drivers by Donald Becker</A>, or specific CPU architectures,
+such as the <A HREF=http://www.alphalinux.org/>Alpha Linux</A> website for
+running Linux on the Alpha processor.  They're out there if you look for
+them.
 </LI>
 
 <LI>
-Similarly, Linux implementations for some CPU architectures have
-dedicated <B>Web pages, mailing lists</B>, and sometimes even a HOWTO
-e.g. the <B><A
-HREF="http://www.linuxdoc.org/HOWTO/Alpha-HOWTO.html">Linux Alpha
-HOWTO</A></B> by Neal Crook. Check the LDP site and its mirrors for
-Web links to the various architecture specific sites.
+Here is a general guide on
+<A HREF="http://www.catb.org/~esr/faqs/smart-questions.html">how to ask smart
+questions</a> in a way that greatly improves your chances
+of getting a reply.  If you have a bug to report, you should also read this
+paper on <A HREF="http://www.chiark.greenend.org.uk/~sgtatham/bugs.html">how 
to
+report bugs effectively</a>, then read the specific
+<A HREF=reporting-bugs.html>Linux-kernel bug reporting instructions</A>.
+<BR>
 </LI>
 
+</UL>
+
+<UL>
+<li>
+<B>A few books</B> that might help you get up to speed
+with the Linux kernel include:
+<UL>
+
 <LI>
-<B><I>Linux device drivers</I></B>, a book written by Alessandro
-Rubini. C. Scott Ananian <A
-HREF="http://www.amazon.com/exec/obidos/ISBN%3D1565922921/cscottananianA/002-0842973-3116635">reviewed
-it for Amazon.com</A>.
+The complete text of <B><I>Linux device drivers</I></B>, by Alessandro Rubini
+and Jonathan Corbet is
+<a href=http://www.xml.com/ldd/chapter/book/index.html>available online</a>,
+or from your local bookstore.
 </LI>
 
 <LI>
-<B><I>Linux kernel internals</I></B>, a book by Michael Beck (Editor) et al. 
Also <A 
HREF="http://www.amazon.com/exec/obidos/ISBN=0201331438/r/002-0842973-3116635">reviewed 
for Amazon.com</A>.
+<B><I>Linux kernel internals</I></B>,
+a book by Michael Beck (Editor) et al., is <a 
href=http://www.amazon.com/exec/obidos/tg/detail/-/0201331438/103-4959406-6330231?vi=glance>available 
from Amazon.com</a>.  The version linked to covers the 2.4.4 kernel.
 </LI>
 
 <LI>
-Another useful site is:
-<A HREF="http://www.kernelnewbies.org/">http://www.kernelnewbies.org/</A>
+<B><I>The ia-64 Linux Kernel Book</I></B> may be useful to people working on
+64 bit platforms.  It has a <a href=http://www.lia64.org/book/>homepage</a>.
 </LI>
 
+</UL>
+</UL>
+
+
+<P>Some older documentation is also available on the web, although it may
+be somewhat out of date.
+
+<UL>
 <LI>
-Here is a general guide on how to ask questions in a way that greatly
-improves your chances of getting a reply:
-<A HREF="http://www.tuxedo.org/~esr/faqs/smart-questions.html">
-http://www.tuxedo.org/~esr/faqs/smart-questions.html</A>. If you have
-a bug to report, you should also read
-<A HREF="http://www.chiark.greenend.org.uk/~sgtatham/bugs.html">
-http://www.chiark.greenend.org.uk/~sgtatham/bugs.html</A>.
-<BR>
-Extra instructions, specific to the Linux kernel are available
-<A HREF="reporting-bugs.html">here</A>.
+A completely new <a 
href=http://www.kernelhacking.org/docs/kernelhacking-HOWTO/index.html>Kernelhacking-HOWTO</a> 
at
+<A HREF="http://www.kernelhacking.org/">http://www.kernelhacking.org/</A>.
+Currently work in progress, but already contains some useful information.
+(Note: this project stalled in early 2002, with a call for volunteers, but 
may
+restart at any time.)
+</LI>
+
+<LI><B>
+<A HREF="http://en.tldp.org/LDP/khg/HyperNews/get/khg.html">
+The Linux Kernel Hackers' Guide</A></B>,
+compiled by Michael K. Johnson of <A
+HREF="http://www.redhat.com/">Red Hat</A> fame. Includes among other
+documents selected Q/A's from the linux-kernel mailing list.  (Circa 2.0 
kernel.
+Explicitly abandoned.)
+</LI>
+
+<LI><B>
+<A HREF="http://en.tldp.org/LDP/tlk/tlk.html">
+The Linux Kernel</A></B>
+book, by David A. Rusling, available in various formats from the
+<A HREF="http://www.linuxdoc.org/">Linux Documentation Project</A>
+and <A HREF="http://www.linuxdoc.org/mirrors.html">mirrors</A>.
+Explains clearly the main structure of the Linux kernel.  (Circa 2.0 kernel.)
 </LI>
 
 </UL>


