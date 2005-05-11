Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVEKIan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVEKIan (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 04:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVEKIan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 04:30:43 -0400
Received: from mailfe05.swip.net ([212.247.154.129]:64972 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261917AbVEKIac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 04:30:32 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [Fastboot] Fw: Re: kexec?
From: Alexander Nyberg <alexn@telia.com>
To: ebiederm@xmission.com, vgoyal@in.ibm.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       fastboot@lists.osdl.org, rddunlap@osdl.org, Ralf.Hildebrandt@charite.de,
       petkov@uni-muenster.de, Morton Andrew Morton <akpm@osdl.org>,
       coywolf@gmail.com
In-Reply-To: <20050511080959.GB3799@in.ibm.com>
References: <20050510193225.53192aad.akpm@osdl.org>
	 <20050511030201.GA3799@in.ibm.com>
	 <1115795427.917.10.camel@localhost.localdomain>
	 <20050511080959.GB3799@in.ibm.com>
Content-Type: text/plain
Date: Wed, 11 May 2005 10:30:28 +0200
Message-Id: <1115800228.917.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > kexec-tools-1.101 does not contain your last patch series (that includes
> > --crashdump which is lacking from the above cmdline). Currently you need
> > to patch up 1.101 with the stuff from 
> > [RFC/PATCH 5/17][kexec-tools-1.101] Add command line option
> > "--crash-dump" etc.
> > 
> > It would be good having a 1.2 or something with the patches included on
> > the site...
> 
> We have uploaded the kdump related user space patches which can be 
> accessed at following link.
> 
> http://lse.sourceforge.net/kdump/patches/
> 
> A single consolidated patch can be applied on top of kexec-tools-1.101.tar.gz
> to get kdump working.

I had no idea this address existed, only when looking at my lkml-archive
i saw it posted this monday (!), prior to that I had not seen it and I
watch things quite closely.

How is anyone gonna try it out if it isn't announced and the proper
procedure of getting it going known? Randys recent kdump.txt update made
things alot clearer but it won't help finding the right source and
patches. Although personally I'd put up a complete tarball instead of a
patch so users/testers don't have to manually patch it up.

Also the latest kexec patches are at http://www.xmission.com/~ebiederm/files/kexec/
nowdays and not with Randy. And there is even more confusion to it as there is:
kexec-tools-1.101.tar.gz
kexec-tools-1.99.tar.gz

I don't know about you but if I didn't know i'd definately go with the 1.99 one
even if 1.101 is the latest version.

Index: mm/Documentation/kdump.txt
===================================================================
--- mm.orig/Documentation/kdump.txt	2005-05-06 08:55:43.000000000 +0200
+++ mm/Documentation/kdump.txt	2005-05-11 10:16:38.000000000 +0200
@@ -35,7 +35,9 @@
 SETUP
 =====
 
-1) Download and build the appropriate version of kexec-tools.
+1) Download http://www.xmission.com/~ebiederm/files/kexec/kexec-tools-1.101.tar.gz
+   and apply http://lse.sourceforge.net/kdump/patches/kexec-tools-1.101-kdump.patch
+   and after that build the source.
 
 2) Download and build the appropriate (latest) kexec/kdump (-mm) kernel
    patchset and apply it to the vanilla kernel tree.
Index: mm/MAINTAINERS
===================================================================
--- mm.orig/MAINTAINERS	2005-05-06 08:55:57.000000000 +0200
+++ mm/MAINTAINERS	2005-05-11 10:24:35.000000000 +0200
@@ -1339,7 +1339,6 @@
 M:	ebiederm@xmission.com
 M:	rddunlap@osdl.org
 W:	http://www.xmission.com/~ebiederm/files/kexec/
-W:	http://developer.osdl.org/rddunlap/kexec/
 L:	linux-kernel@vger.kernel.org
 L:	fastboot@osdl.org
 S:	Maintained


