Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317924AbSFSQSk>; Wed, 19 Jun 2002 12:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317925AbSFSQSk>; Wed, 19 Jun 2002 12:18:40 -0400
Received: from revdns.flarg.info ([213.152.47.19]:63180 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S317924AbSFSQSh>;
	Wed, 19 Jun 2002 12:18:37 -0400
Date: Wed, 19 Jun 2002 17:19:19 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: dri-devel@lists.sourceforge.net
Subject: [PATCH] Split up agpgart into per implementation files.
Message-ID: <20020619161919.GA14826@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	dri-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something I've been meaning to do for a long time, and no-one has
beaten me to it, is to do something about agpgart_be.c, which seems
to grow and grow and..

I've just put up a patch at..
 ftp.kernel.org/pub/linux/kernel/people/davej/patches/agp/
which splits up the huge monolithic file into implementation
specific files.

This is a first cut, so I'll not be surprised if you manage to break
the compile, but please do try.. I've tried several combinations,
and it all seems to work out ok, but I can only test on VIA boards
here. You should see absolutely no change in behaviour if all goes
to plan.

I'm particularly interested in hearing if I got the CONFIG_AGP_I180
changes right.  The patch is against 2.5.23, but may apply with
trivial rejects to 2.4-current if you're feeling lucky.

There's lots more that can be done to cut down some of the duplication
that this patch introduces, but it's a good start at making the
backend code a little easier to navigate.

Comments?

		Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
