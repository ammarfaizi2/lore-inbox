Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317568AbSHCNDs>; Sat, 3 Aug 2002 09:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317570AbSHCNDs>; Sat, 3 Aug 2002 09:03:48 -0400
Received: from smtp-in.sc5.paypal.com ([216.136.155.8]:5329 "EHLO
	smtp-in.sc5.paypal.com") by vger.kernel.org with ESMTP
	id <S317568AbSHCNDs>; Sat, 3 Aug 2002 09:03:48 -0400
Date: Sat, 3 Aug 2002 06:06:24 -0700
From: Brad Heilbrun <bheilbrun@paypal.com>
To: Ognen Duzlevski <ogd116@mail.usask.ca>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Subject: Re: problem compiling 2.5.30
Message-ID: <20020803130624.GA6061@paypal.com>
Mail-Followup-To: Ognen Duzlevski <ogd116@mail.usask.ca>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
References: <1028307201.1719.11.camel@iota>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028307201.1719.11.camel@iota>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2002 at 11:53:21AM -0500, Ognen Duzlevski wrote:
> Hi, sorry if this popped up before. It is a redhat 7.3 box, gcc 2.96.
> this happens when I include devfs into the kernel.

Courtesy of a nice typo... this should fix it (not tested however).

-- 
Brad Heilbrun

--- ./linus-2.5/fs/partitions/check.c	Thu Aug  1 22:48:50 2002
+++ ./brad-2.5/fs/partitions/check.c	Sat Aug  3 05:52:29 2002
@@ -467,7 +467,7 @@
 	for (part = 1; part < max_p; part++) {
 		if ( unregister || (p[part].nr_sects < 1) ) {
 			devfs_unregister(p[part].de);
-			dev->part[p].de = NULL;
+			p[part].de = NULL;
 			continue;
 		}
 		devfs_register_partition (dev, minor, part);
