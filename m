Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbTDQUXN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 16:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTDQUXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 16:23:13 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:4345 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S262219AbTDQUXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 16:23:12 -0400
Date: Thu, 17 Apr 2003 13:30:59 -0700
From: Chris Wright <chris@wirex.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: richard offer <offer@sgi.com>, Linus Torvalds <torvalds@transmeta.com>,
       lsm <linux-security-module@wirex.com>, "Ted Ts'o" <tytso@mit.edu>,
       Stephen Tweedie <sct@redhat.com>, Andreas Gruenbacher <ag@bestbits.at>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Extended Attributes for Security Modules
Message-ID: <20030417133059.G29431@figure1.int.wirex.com>
Mail-Followup-To: Stephen Smalley <sds@epoch.ncsc.mil>,
	richard offer <offer@sgi.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	lsm <linux-security-module@wirex.com>, Ted Ts'o <tytso@mit.edu>,
	Stephen Tweedie <sct@redhat.com>,
	Andreas Gruenbacher <ag@bestbits.at>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0304140033100.12311-100000@muriel.parsec.at> <1050414107.16051.70.camel@moss-huskers.epoch.ncsc.mil> <385390000.1050425884@changeling.engr.sgi.com> <1050500841.2682.62.camel@moss-huskers.epoch.ncsc.mil> <743940000.1050530541@changeling.engr.sgi.com> <1050553474.1076.88.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1050553474.1076.88.camel@moss-huskers.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Thu, Apr 17, 2003 at 12:24:34AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> On Wed, 2003-04-16 at 18:02, richard offer wrote:
> > I can see your reasons for the single attribute (known quantity for
> > production systems), but think its better at this stage to experiment with
> > multiple attributes and see how people use them before forcing everyone to
> > a single standard. It allows small steps rather than force everyone to make
> > a single large one.
> 
> Per-module attribute names create no incentive for the security module
> writers to provide a consistent API and guarantees a forked userland. 

This is the core issue.  Personally, I'd rather stick to simple strings
and per-module attributes rooted at a common point.  This is simplest
for userspace tools.  But the attribute namespace is effectively flat,
so it's a question of simplicity for locating the attributes.  A simple
getxattr(2) vs. a listxattr(2) plus multiple getxattr(2).  Unfortunately,
this points at a single standard name I think...

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
