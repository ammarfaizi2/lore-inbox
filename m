Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbVHCAl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVHCAl1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 20:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVHCAl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 20:41:27 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:14562 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S261948AbVHCAl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 20:41:26 -0400
Date: Wed, 3 Aug 2005 02:41:20 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Steven Rostedt <rostedt@goodmis.org>, Sean Bruno <sean.bruno@dsl-only.net>
cc: Lee Revell <rlrevell@joe-job.com>, webmaster@kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Michael Krufky <mkrufky@m1k.net>
Subject: Re: Testing RC kernels [KORG]
Message-ID: <Pine.LNX.4.58.0508030214150.7510@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Bruno <sean.bruno@dsl-only.net> wrote:
> On Tue, 2005-08-02 at 15:21 -0400, Steven Rostedt wrote:

>> I've been complaining about this for some time. Kernel.org really needs
>> to show more information about the rc kernels and how to create them.
>> We want more testers, but I wonder how many people go through the above
>> steps and just give up when things don't work. Luckly Sean was nice
>> enough to email the LKML and ask.
>> 
>> My main gripe is that there's no link to 2.6.12 which is what most of
>> the other patches go against.
>> 
> I would be more than willing to whip up an html how-to(and maintain it).
> Is there any interest in this?

I hacked some changes to create vogon-compatibility. Maybe you like it.
I'm not completely happy, but it's too late now.

Changes:
- Make first column more terse
- Move full download links to a seperate table, where they can be found.
- Add <h2> headings above the patches and above the tarballs
- Add some hints
- Create a dead link to a patching-HOWTO
- Add a 'applies to:' column
- fix legend to match changes


Signed-off-by: Bodo Eggert <7eggert@gmx.de>

--- index.ori	2005-08-03 02:26:03.618204515 +0200
+++ index.html	2005-08-03 02:35:57.326133017 +0200
@@ -16,5 +16,5 @@
 	body{margin:10px;padding:0px;background:#fff;color:#000;font-family:Sans-Serif;}
 	h1{padding:4px;text-align:center;border:4px double #000;background:#ffd;}
-	h2{padding:4px;border:1px solid #888;background:#ffd;}
+	h2{padding:4px;border:1px solid #888;background:#ffd;text-align:center;}
 	table{border:0;margin-left:auto;margin-right:auto;margin-bottom:10px;}
 	th{background:#bbd;padding:2px;}
@@ -31,5 +31,5 @@
 	#sponsors{text-align:center;margin-left:auto;margin-right:auto;}
 	#trademark{font-size:75%;text-align:center;}
-	#versions{text-align:center;}
+	#versions{text-align:left;}
 	.kver{text-align:center;color:#004;font-size:90%;}
 	.pvkey{color:#400;font-size:66%;}
@@ -72,10 +72,29 @@
   <div id="versions">
 
+<h2>Latest kernel patches</h2>
+
   <table class="kver">
 <tr align="left">
-<td>The latest stable version of the Linux kernel is:&nbsp;</td>
+
+<p>Use these patches if you want to upgrade your kernel source within a kernel series.</p>
+<p>Complete tarballs are <a href="#tarballs">below</a></p>
+<p>For a complete list of patches and source tarballs, see the kernel <a href="http://www.kernel.org/pub/linux/kernel/">
+archive</a>.</p>
+<p>Please read the <a href="kernel-patching-HOWTO.html">kernel-patching-HOWTO</a></p>
+
+<td>latest upgrade to stable</td>
+<td><b><a href="/pub/linux/kernel/v2.6/patch-2.6.12.bz2">2.6.12</a></b></td>
+<td>applies to: 2.6.11</td>
+<td>2005-07-15 21:38 UTC</td>
+<td><a href="http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.6%2Fpatch-2.6.12.3.bz2">V</a></td>
+<td><a href="http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.6%2Fincr%2Fpatch-2.6.12.2-3.bz2">VI</a></td>
+<td><a href="http://www.kernel.org/git/?p=linux%2Fkernel%2Fgit%2Fgregkh%2Flinux-2.6.12.y.git;a=summary">C</a></td>
+<td><a href="/pub/linux/kernel/v2.6/ChangeLog-2.6.12.3">Changelog</a></td>
+</tr>
+<tr align="left">
+<td>stability and security patches</td>
 <td><b><a href="/pub/linux/kernel/v2.6/patch-2.6.12.3.bz2">2.6.12.3</a></b></td>
+<td>applies to: 2.6.12</td>
 <td>2005-07-15 21:38 UTC</td>
-<td><a href="/pub/linux/kernel/v2.6/linux-2.6.12.3.tar.bz2">F</a></td>
 <td><a href="http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.6%2Fpatch-2.6.12.3.bz2">V</a></td>
 <td><a href="http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.6%2Fincr%2Fpatch-2.6.12.2-3.bz2">VI</a></td>
@@ -84,8 +103,8 @@
 </tr>
 <tr align="left">
-<td>The latest <a href="http://kernel.org/patchtypes/pre.html">prepatch</a> for the stable Linux kernel tree is:&nbsp;</td>
+<td><a href="http://kernel.org/patchtypes/pre.html">prepatch</a> for the stable</td>
 <td><b><a href="/pub/linux/kernel/v2.6/testing/patch-2.6.13-rc5.bz2">2.6.13-rc5</a></b></td>
+<td>applies to: 2.6.12</td>
 <td>2005-08-02 05:09 UTC</td>
-<td>&nbsp;</td>
 <td><a href="http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.6%2Ftesting%2Fpatch-2.6.13-rc5.bz2">V</a></td>
 <td><a href="http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.6%2Ftesting%2Fincr%2Fpatch-2.6.13-rc4-rc5.bz2">VI</a></td>
@@ -94,8 +113,8 @@
 </tr>
 <tr align="left">
-<td>The latest <a href="http://kernel.org/patchtypes/snapshot.html">snapshot</a> for the stable Linux kernel tree is:&nbsp;</td>
+<td><a href="http://kernel.org/patchtypes/snapshot.html">snapshot</a> for the stable</td>
 <td><b><a href="/pub/linux/kernel/v2.6/snapshots/patch-2.6.12-git10.bz2">2.6.12-git10</a></b></td>
+<td>applies to: 2.6.12</td>
 <td>2005-06-28 09:02 UTC</td>
-<td>&nbsp;</td>
 <td><a href="http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.6%2Fsnapshots%2Fpatch-2.6.12-git10.bz2">V</a></td>
 <td>&nbsp;</td>
@@ -104,8 +123,8 @@
 </tr>
 <tr align="left">
-<td>The latest 2.4 version of the Linux kernel is:&nbsp;</td>
+<td>Version 2.4 series</td>
 <td><b><a href="/pub/linux/kernel/v2.4/patch-2.4.31.bz2">2.4.31</a></b></td>
+<td>applies to: 2.4.30</td>
 <td>2005-06-01 00:57 UTC</td>
-<td><a href="/pub/linux/kernel/v2.4/linux-2.4.31.tar.bz2">F</a></td>
 <td><a href="http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.4%2Fpatch-2.4.31.bz2">V</a></td>
 <td><a href="http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.4%2Ftesting%2Fincr%2Fpatch-2.4.31-rc2-final.bz2">VI</a></td>
@@ -114,8 +133,8 @@
 </tr>
 <tr align="left">
-<td>The latest <a href="http://kernel.org/patchtypes/pre.html">prepatch</a> for the 2.4 Linux kernel tree is:&nbsp;</td>
+<td><a href="http://kernel.org/patchtypes/pre.html">prepatch</a> for the 2.4</td>
 <td><b><a href="/pub/linux/kernel/v2.4/testing/patch-2.4.32-pre2.bz2">2.4.32-pre2</a></b></td>
+<td>applies to: 2.4.31</td>
 <td>2005-07-27 19:56 UTC</td>
-<td>&nbsp;</td>
 <td><a href="http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.4%2Ftesting%2Fpatch-2.4.32-pre2.bz2">V</a></td>
 <td><a href="http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.4%2Ftesting%2Fincr%2Fpatch-2.4.32-pre1-pre2.bz2">VI</a></td>
@@ -124,8 +143,8 @@
 </tr>
 <tr align="left">
-<td>The latest 2.2 version of the Linux kernel is:&nbsp;</td>
+<td>Version 2.2 series</td>
 <td><b><a href="/pub/linux/kernel/v2.2/patch-2.2.26.bz2">2.2.26</a></b></td>
+<td>applies to: 2.2.25</td>
 <td>2004-02-25 00:28 UTC</td>
-<td><a href="/pub/linux/kernel/v2.2/linux-2.2.26.tar.bz2">F</a></td>
 <td><a href="http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.2%2Fpatch-2.2.26.bz2">V</a></td>
 <td>&nbsp;</td>
@@ -134,8 +153,8 @@
 </tr>
 <tr align="left">
-<td>The latest <a href="http://kernel.org/patchtypes/pre.html">prepatch</a> for the 2.2 Linux kernel tree is:&nbsp;</td>
+<td><a href="http://kernel.org/patchtypes/pre.html">prepatch</a> for the 2.2</td>
 <td><b><a href="/pub/linux/kernel/v2.2/testing/patch-2.2.27-rc2.bz2">2.2.27-rc2</a></b></td>
+<td>applies to: 2.2.26</td>
 <td>2005-01-12 23:55 UTC</td>
-<td>&nbsp;</td>
 <td><a href="http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.2%2Ftesting%2Fpatch-2.2.27-rc2.bz2">V</a></td>
 <td><a href="http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.2%2Ftesting%2Fincr%2Fpatch-2.2.27-rc1-rc2.bz2">VI</a></td>
@@ -144,8 +163,8 @@
 </tr>
 <tr align="left">
-<td>The latest 2.0 version of the Linux kernel is:&nbsp;</td>
+<td>Version 2.0 series</td>
 <td><b><a href="/pub/linux/kernel/v2.0/patch-2.0.40.bz2">2.0.40</a></b></td>
+<td>applies to: 2.0.39</td>
 <td>2004-02-08 07:13 UTC</td>
-<td><a href="/pub/linux/kernel/v2.0/linux-2.0.40.tar.bz2">F</a></td>
 <td><a href="http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.0%2Fpatch-2.0.40.bz2">V</a></td>
 <td><a href="http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.0%2Ftesting%2Fincr%2Fpatch-2.0.40-rc8-final.bz2">VI</a></td>
@@ -154,8 +173,8 @@
 </tr>
 <tr align="left">
-<td>The latest <a href="http://kernel.org/patchtypes/ac.html">-ac patch</a> to the stable Linux kernels is:&nbsp;</td>
+<td><a href="http://kernel.org/patchtypes/ac.html">-ac patch</a></td>
 <td><b><a href="/pub/linux/kernel/people/alan/linux-2.6/2.6.11/patch-2.6.11-ac7.bz2">2.6.11-ac7</a></b></td>
+<td>applies to: 2.6.11</td>
 <td>2005-04-11 18:36 UTC</td>
-<td>&nbsp;</td>
 <td><a href="http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fpeople%2Falan%2Flinux-2.6%2F2.6.11%2Fpatch-2.6.11-ac7.bz2">V</a></td>
 <td>&nbsp;</td>
@@ -164,8 +183,8 @@
 </tr>
 <tr align="left">
-<td>The latest <a href="http://kernel.org/patchtypes/mm.html">-mm patch</a> to the stable Linux kernels is:&nbsp;</td>
+<td><a href="http://kernel.org/patchtypes/mm.html">-mm patch</a></td>
 <td><b><a href="/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc4/2.6.13-rc4-mm1/2.6.13-rc4-mm1.bz2">2.6.13-rc4-mm1</a></b></td>
+<td>applies to: <a href="/pub/linux/kernel/v2.6/testing/patch-2.6.13-rc4.bz2">2.6.13-rc4</a></td>
 <td>2005-07-31 08:45 UTC</td>
-<td>&nbsp;</td>
 <td><a href="http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fpeople%2Fakpm%2Fpatches%2F2.6%2F2.6.13-rc4%2F2.6.13-rc4-mm1%2F2.6.13-rc4-mm1.bz2">V</a></td>
 <td>&nbsp;</td>
@@ -176,6 +195,6 @@
   </table>
 
-  <p class="pvkey">
-    <b>F</b> = full source, <b>V</b> = view patch,
+  <p class="pvkey" align="center">
+    <b>V</b> = view patch,
     <b>VI</b> = view incremental, <b>C</b> = current <a href="changeset.html">changesets</a><br />
     Changelogs are provided by the kernel authors directly. Please
@@ -183,4 +202,41 @@
     <a href="diff/config.html">Customize the patch viewer</a>
   </p>
+<a name="tarballs"><h2>Latest kernel archives</h2></a>
+
+<p>This is the complete kernel source. If you don't have an old version from the same
+kernel series, get one of these. Otherwise, you may want to upgrade using the patches
+from above</p>
+
+<table class="kver">
+<tr align="left">
+<td><a href="/pub/linux/kernel/v2.6/linux-2.6.12.3.tar.bz2">2.6.12.3</a></td>
+<td>The current kernel source with stability- and security-fixes from above</td>
+</tr>
+<tr align="left">
+<td><a href="/pub/linux/kernel/v2.6/linux-2.6.12.tar.bz2">2.6.12</a></td>
+<td>The current kernel source, suitable for patching</td>
+</tr>
+<tr align="left">
+<td><a href="/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2">2.6.11</a></td>
+<td>The kernel source suitable for the -ac-patch</td>
+</tr>
+<tr align="left">
+<td><a href="/pub/linux/kernel/v2.4/linux-2.4.31.tar.bz2">2.4.31</a></td>
+<td>The latest 2.4 kernel source</td>
+</tr>
+<tr align="left">
+<td><a href="/pub/linux/kernel/v2.2/linux-2.2.26.tar.bz2">2.2.26</a></td>
+<td>The latest 2.2 kernel source</td>
+</tr>
+<tr align="left">
+<td><a href="/pub/linux/kernel/v2.0/linux-2.0.40.tar.bz2">2.0.40</a></td>
+<td>The latest 2.0 kernel source</td>
+</tr>
+<tr align="left">
+</tr>
+<tr align="left">
+</tr>
+</table>
+
   </div>
 
-- 
Top 100 things you don't want the sysadmin to say:
28. Nobody was using that file /vmunix, were they?
