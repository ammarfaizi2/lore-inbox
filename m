Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbTDQUlg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 16:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbTDQUlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 16:41:35 -0400
Received: from zok.SGI.COM ([204.94.215.101]:28893 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262652AbTDQUlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 16:41:31 -0400
Date: Thu, 17 Apr 2003 13:53:07 -0700
From: richard offer <offer@sgi.com>
To: Chris Wright <chris@wirex.com>, Stephen Smalley <sds@epoch.ncsc.mil>
cc: Linus Torvalds <torvalds@transmeta.com>,
       lsm <linux-security-module@wirex.com>, "Ted Ts'o" <tytso@mit.edu>,
       Stephen Tweedie <sct@redhat.com>, Andreas Gruenbacher <ag@bestbits.at>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Extended Attributes for Security Modules
Message-ID: <1020130000.1050612787@changeling.engr.sgi.com>
In-Reply-To: <20030417133059.G29431@figure1.int.wirex.com>
References: <Pine.LNX.4.33.0304140033100.12311-100000@muriel.parsec.at>
 <1050414107.16051.70.camel@moss-huskers.epoch.ncsc.mil>
 <385390000.1050425884@changeling.engr.sgi.com>
 <1050500841.2682.62.camel@moss-huskers.epoch.ncsc.mil>
 <743940000.1050530541@changeling.engr.sgi.com>
 <1050553474.1076.88.camel@moss-huskers.epoch.ncsc.mil>
 <20030417133059.G29431@figure1.int.wirex.com>
X-Mailer: Mulberry/2.2.0 (Linux/x86)
X-HomePage: http://www.whitequeen.com/users/richard/
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



* frm chris@wirex.com "04/17/03 13:30:59 -0700" | sed '1,$s/^/* /'
*
** Stephen Smalley (sds@epoch.ncsc.mil) wrote:
*> On Wed, 2003-04-16 at 18:02, richard offer wrote:
*> > I can see your reasons for the single attribute (known quantity for
*> > production systems), but think its better at this stage to experiment
*> > with multiple attributes and see how people use them before forcing
*> > everyone to a single standard. It allows small steps rather than force
*> > everyone to make a single large one.
*> 
*> Per-module attribute names create no incentive for the security module
*> writers to provide a consistent API and guarantees a forked userland. 
* 
* This is the core issue.  Personally, I'd rather stick to simple strings
* and per-module attributes rooted at a common point.  This is simplest
* for userspace tools.  But the attribute namespace is effectively flat,
* so it's a question of simplicity for locating the attributes.  A simple
* getxattr(2) vs. a listxattr(2) plus multiple getxattr(2).  Unfortunately,
* this points at a single standard name I think...

Good point. Okay you've conviced me enough that while I don't agree more
than 51%, I'm at least going to shut up until the next time.


Would it make sense to have a single "backup/restore security label" tool
that is distributed alongside LSM rather than relying on each module writer
developing their own.

* 
* thanks,
* -chris

richard.

-- 
-----------------------------------------------------------------------
Richard Offer                     Technical Lead, Trust Technology, SGI
"Specialization is for insects"
_______________________________________________________________________

