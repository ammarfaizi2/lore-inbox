Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751965AbWCOGtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbWCOGtE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 01:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbWCOGtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 01:49:04 -0500
Received: from fmr17.intel.com ([134.134.136.16]:29399 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751965AbWCOGtB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 01:49:01 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Wed, 15 Mar 2006 14:47:48 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B32AB0B@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
thread-index: AcZH+yJGLU8pF9/TQreOfSjKveIdkwAAIzBA
From: "Yu, Luming" <luming.yu@intel.com>
To: "Sanjoy Mahajan" <sanjoy@mrao.cam.ac.uk>
Cc: <linux-kernel@vger.kernel.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       <michael@mihu.de>, <mchehab@infradead.org>,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, <gregkh@suse.de>,
       "Brown, Len" <len.brown@intel.com>, <linux-acpi@vger.kernel.org>,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       <jgarzik@pobox.com>, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
X-OriginalArrivalTime: 15 Mar 2006 06:47:50.0129 (UTC) FILETIME=[60665E10:01C647FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> If you remove the real THM0._TMP, and fake a dummy THM0._TMP in
>> DSDT, and don't change anything in kernel, then if S3 works well, I
>> will be convinced that THM0._TMP was causing trouble.
>
>I'll try it, to test my theory above!  But one clarification first: Do
>you mean that I use a vanilla thermal.c, or should I keep using the
>modified thermal.c with zone_to_keep=0 as the module parameter?  I
>don't think I revert to the vanilla thermal.c.  Suppose that there are
>two bugs, which I think is likely (see previous email).  Commenting
>out only THM0._TMP but preserving everything else in the DSDT & kernel
>might eliminate any bug caused by THM0._TMP.  But if it still hangs --
>and I'm pretty sure it will -- it means there's a another bug
>somewhere else.

Ok, I'm fine whatever way you choose to start, But I think you need to
verify
the findings with the UN-modified kernek ,UN-modified Thermal.c and
others
that can reproduce S3 hang with UN-modified DSDT.



