Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbTDRBAB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 21:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbTDRBAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 21:00:00 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:44531 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S262742AbTDRA76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 20:59:58 -0400
Date: Thu, 17 Apr 2003 18:07:45 -0700
From: Chris Wright <chris@wirex.com>
To: richard offer <offer@sgi.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Stephen Tweedie <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <ag@bestbits.at>,
       lsm <linux-security-module@wirex.com>
Subject: Re: [RFC][PATCH] Extended Attributes for Security Modules
Message-ID: <20030417180745.J29431@figure1.int.wirex.com>
Mail-Followup-To: richard offer <offer@sgi.com>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Linus Torvalds <torvalds@transmeta.com>, Ted Ts'o <tytso@mit.edu>,
	Stephen Tweedie <sct@redhat.com>,
	lkml <linux-kernel@vger.kernel.org>,
	Andreas Gruenbacher <ag@bestbits.at>,
	lsm <linux-security-module@wirex.com>
References: <Pine.LNX.4.33.0304140033100.12311-100000@muriel.parsec.at> <1050414107.16051.70.camel@moss-huskers.epoch.ncsc.mil> <385390000.1050425884@changeling.engr.sgi.com> <1050500841.2682.62.camel@moss-huskers.epoch.ncsc.mil> <743940000.1050530541@changeling.engr.sgi.com> <1050553474.1076.88.camel@moss-huskers.epoch.ncsc.mil> <20030417133059.G29431@figure1.int.wirex.com> <1020130000.1050612787@changeling.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1020130000.1050612787@changeling.engr.sgi.com>; from offer@sgi.com on Thu, Apr 17, 2003 at 01:53:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* richard offer (offer@sgi.com) wrote:
> * frm chris@wirex.com "04/17/03 13:30:59 -0700" | sed '1,$s/^/* /'
> * 
> * This is the core issue.  Personally, I'd rather stick to simple strings
> * and per-module attributes rooted at a common point.  This is simplest
> * for userspace tools.  But the attribute namespace is effectively flat,
> * so it's a question of simplicity for locating the attributes.  A simple
> * getxattr(2) vs. a listxattr(2) plus multiple getxattr(2).  Unfortunately,
> * this points at a single standard name I think...
> 
> Good point. Okay you've conviced me enough that while I don't agree more
> than 51%, I'm at least going to shut up until the next time.

Heh, it's a valid question.  I like per-module attributes, but I don't
think they are as nice for userland tools.  I don't acutally like
encoding namesapce into the attribute value, but I'm not sure the
alternative is much different/better.

> Would it make sense to have a single "backup/restore security label" tool
> that is distributed alongside LSM rather than relying on each module writer
> developing their own.

You mean to ensure that labels are accumulated rather than replaced?
Could be useful I suppose.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
