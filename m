Return-Path: <linux-kernel-owner+w=401wt.eu-S932572AbXARTyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbXARTyw (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 14:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbXARTyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 14:54:51 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3328 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932463AbXARTyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 14:54:51 -0500
Date: Thu, 18 Jan 2007 20:54:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>, ttb@tentacle.dhs.org,
       rml@novell.com, Malte =?iso-8859-1?Q?Schr=F6der?= <MalteSch@gmx.de>,
       "Vladimir V. Saveliev" <vs@namesys.com>, reiserfs-dev@namesys.com,
       Sami Farin <7atbggg02@sneakemail.com>, David Chinner <dgc@sgi.com>,
       xfs-masters@oss.sgi.com, Andrew Clayton <andrew@digital-domain.net>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: 2.6.20-rc5: knwon unfixed regressions (v2) (part2)
Message-ID: <20070118195456.GB9093@stusta.de>
References: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known regressions in 2.6.20-rc5 compared to 2.6.19.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : BUG: at fs/inotify.c:172 set_dentry_child_flags()
References : http://bugzilla.kernel.org/show_bug.cgi?id=7785
Submitter  : Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>
Handled-By : Nick Piggin <nickpiggin@yahoo.com.au>
Status     : problem is being debugged


Subject    : BUG: at mm/truncate.c:60 cancel_dirty_page()  (reiserfs)
References : http://lkml.org/lkml/2007/1/7/117
             http://lkml.org/lkml/2007/1/10/202
Submitter  : Malte Schröder <MalteSch@gmx.de>
Handled-By : Vladimir V. Saveliev <vs@namesys.com>
             Nick Piggin <nickpiggin@yahoo.com.au>
Patch      : http://lkml.org/lkml/2007/1/10/202
Status     : problem is being discussed


Subject    : BUG: at mm/truncate.c:60 cancel_dirty_page()  (XFS)
References : http://lkml.org/lkml/2007/1/5/308
             http://lkml.org/lkml/2007/1/16/15
Submitter  : Sami Farin <7atbggg02@sneakemail.com>
Handled-By : David Chinner <dgc@sgi.com>
Status     : problem is being discussed


Subject    : NFS triggers WARN_ON() in invalidate_inode_pages2_range()
References : http://bugzilla.kernel.org/show_bug.cgi?id=7826
Submitter  : Andrew Clayton <andrew@digital-domain.net>
Caused-By  : Andrew Morton <akpm@osdl.org>
             commit 8258d4a574d3a8c01f0ef68aa26b969398a0e140
Handled-By : Trond Myklebust <trond.myklebust@fys.uio.no>
Status     : Trond: the WARN_ON() needs to be thrown out


