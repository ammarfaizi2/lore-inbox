Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276632AbRJKRmh>; Thu, 11 Oct 2001 13:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276631AbRJKRmS>; Thu, 11 Oct 2001 13:42:18 -0400
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:33553 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id <S276622AbRJKRmM>; Thu, 11 Oct 2001 13:42:12 -0400
Date: Thu, 11 Oct 2001 18:42:41 +0100
From: John Levon <moz@compsoc.man.ac.uk>
To: rgooch@atnf.csiro.au, linux-kernel@vger.kernel.org
Subject: [PATCH] tainting FAQ
Message-ID: <20011011184241.A95852@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: Truant - Neither Work Nor Leisure
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


short and sweet. (useful) comments ?

thanks
john

--- faq.html	Thu Oct 11 18:42:44 2001
+++ faqnew.html	Thu Oct 11 18:51:22 2001
@@ -513,6 +513,10 @@
 and Alan Cox's -ac series of patches?</A>
 </LI>
 
+<LI>
+<A HREF="#s1-22">What does it mean for a module to be tainted ?</A>
+</LI>
+
 </OL>
 
 <H4>
@@ -1794,6 +1798,34 @@
 
 </UL>
 
+<LI>
+<A NAME="s1-22"></A><B>What does it mean for a module to be tainted?</B>
+</LI>
+
+<UL>
+<LI>
+Some vendors distribute binary modules (i.e. modules without available
+source code under a free software license).
+As the source is not freely available, any bugs uncovered whilst such
+modules are loaded cannot be investigated by the kernel hackers. All
+problems discovered whilst such a module is loaded must be reported
+to the vendor of that module, <I>not</I> the Linux kernel hackers and
+the linux-kernel mailing list. The tainting scheme is used to identify
+bug reports from kernels with binary modules loaded: such kernels are
+marked as "tainted" by means of the <TT>MODULE_LICENSE</TT> tag. If a
+module is loaded that does not specify an approved license, the kernel
+is marked as tainted. The canonical list of approved license strings
+is in <TT>linux/include/module.h</TT>.<BR>
+"oops" reports marked as tainted are of no use to the kernel developers
+and will be ignored. A warning is output when such a module is loaded.
+Note that you may come across module source that is under a compatible
+license, but does not have a suitable <TT>MODULE_LICENSE</TT> tag. If you
+see a warning from <TT>modprobe</TT> or <TT>insmod</TT> for a module
+under a compatible license, please report this bug to the maintainers of
+the module, so that they can add the necessary tag.
+</LI>
+</UL>
+ 
 </OL>
 
 <H2>
