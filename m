Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262725AbVD2O0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbVD2O0b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 10:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbVD2O0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:26:30 -0400
Received: from fire.osdl.org ([65.172.181.4]:18052 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262716AbVD2O0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 10:26:08 -0400
Date: Fri, 29 Apr 2005 07:26:00 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: vgoyal@in.ibm.com
Cc: akpm@osdl.org, sharyathi@in.ibm.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, ebiederm@xmission.com
Subject: Re: [Fastboot] Re: [PATCH] Kdump docs.
Message-Id: <20050429072600.67851fde.rddunlap@osdl.org>
In-Reply-To: <20050429050729.GB3636@in.ibm.com>
References: <1114227003.4269c13be5f8b@imap.linux.ibm.com>
	<OFB57B3D45.D8C338C5-ON65256FEE.0042F961-65256FEE.0043D4CB@in.ibm.com>
	<20050425160925.3a48adc5.rddunlap@osdl.org>
	<20050426085448.GB4234@in.ibm.com>
	<20050427122312.358f5bd6.rddunlap@osdl.org>
	<20050428114416.GA5706@in.ibm.com>
	<20050428091119.73568208.rddunlap@osdl.org>
	<20050428200845.5211ec37.rddunlap@osdl.org>
	<20050429050729.GB3636@in.ibm.com>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: SvC&!/v_Hr`MvpQ*|}uez16KH[#EmO2Tn~(r-y+&Jb}?Zhn}c:Eee&zq`cMb_[5`tT(22ms
 (.P84,bq_GBdk@Kgplnrbj;Y`9IF`Q4;Iys|#3\?*[:ixU(UR.7qJT665DxUP%K}kC0j5,UI+"y-Sw
 mn?l6JGvyI^f~2sSJ8vd7s[/CDY]apD`a;s1Wf)K[,.|-yOLmBl0<axLBACB5o^ZAs#&m?e""k/2vP
 E#eG?=1oJ6}suhI%5o#svQ(LvGa=r
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2005 10:37:29 +0530 Vivek Goyal wrote:

| Hi Randy,
| 
| > +  A) First kernel:
| > +   a) Enable "kexec system call" feature (in Processor type and features).
| > +	CONFIG_KEXEC=y
| > +   b) This kernel's physical load address should be the default value of
| > +      0x100000 (0x100000, 1 MB) (in Processor type and features).
| > +	CONFIG_PHYSICAL_START=0x100000
| > +   c) Enable "sysfs file system support" (in Pseudo filesystems).
| > +	CONFIG_SYSFS=y
| > +   d) Boot into first kernel with the command line parameter "crashkernel=Y@X".
| > +      Use appropriate values for X and Y. Y denotes how much memory to reserve
| > +      for the second kernel, and X denotes at what physical address the reserved
| > +      memory section starts. For example: "crashkernel=64M@16M".
| > +
| > +  B) Second kernel:
| > +   a) Enable "kernel crash dumps" feature (in Processor type and features).
| > +	CONFIG_CRASH_DUMP=y
| > +   b) Specify a suitable value for "Physical address where the kernel is
| > +      loaded" (in Processor type and features). Typically this value
| > +      should be same as X (See option b) above, e.g., 16 MB or 0x1000000.
| 
| Should above line be as follows.
| "should be same as X (See option d) above."

Yes, thanks for catching that.  Now how to update it....?

| This will make clear what is X and what should be the new value of 
| CONFIG_PHYSICAL_START. 


---
~Randy
