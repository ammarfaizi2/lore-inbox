Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbTHZM2m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 08:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263801AbTHZM2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 08:28:22 -0400
Received: from ns2.uk.superh.com ([193.128.105.170]:64640 "EHLO
	ns2.uk.superh.com") by vger.kernel.org with ESMTP id S263772AbTHZM0q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 08:26:46 -0400
Date: Tue, 26 Aug 2003 13:26:21 +0100
From: Richard Curnow <Richard.Curnow@superh.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Jim Houston <jim.houston@comcast.net>, linux-kernel@vger.kernel.org,
       jim.houston@ccur.com
Subject: Re: [PATCH] Pentium Pro - sysenter - doublefault
Message-ID: <20030826122621.GB3140@malvern.uk.w2k.superh.com>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	Jim Houston <jim.houston@comcast.net>, linux-kernel@vger.kernel.org,
	jim.houston@ccur.com
References: <1061498486.3072.308.camel@new.localdomain> <20030825040514.GA20529@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030825040514.GA20529@mail.jlokier.co.uk>
X-OS: Linux 2.6.0-test2-mm5 i686
User-Agent: Mutt/1.5.4i
X-OriginalArrivalTime: 26 Aug 2003 12:27:03.0477 (UTC) FILETIME=[5AF1CE50:01C36BCD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jamie Lokier <jamie@shareable.org> [2003-08-26]:
> Could you please run this very simple userspace program for me, and
> report the result?
> 
> 	int main() { __asm__ ("sysenter"); return 0; }
> 
> I expect it to die with SIGILL on Pentium and earlier chips, and
> SIGSEGV on "good" PPro and later chips running kernels which don't
> enable the sysenter instruction.

OK, since I get something different to the other reports I saw:

 1:20PM-malvern-0-534-% ./sysenter
 1:20PM-malvern-STKFLT-535-% echo $?
144

/proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 0
cpu MHz         : 333.495
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 657.40

uname -a:
Linux malvern 2.6.0-test2-mm5 #2 Fri Aug 8 12:06:50 BST 2003 i686 unknown

HTH

-- 
Richard \\\ SuperH Core+Debug Architect /// .. At home ..
  P.    /// richard.curnow@superh.com  ///  rc@rc0.org.uk
Curnow  \\\ http://www.superh.com/    ///  www.rc0.org.uk
