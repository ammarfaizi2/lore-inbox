Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbTDOQqf (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 12:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbTDOQqf 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 12:46:35 -0400
Received: from rj.SGI.COM ([192.82.208.96]:6103 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S261814AbTDOQqe 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 12:46:34 -0400
Date: Tue, 15 Apr 2003 09:58:04 -0700
From: richard offer <offer@sgi.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: Andreas Gruenbacher <ag@bestbits.at>,
       Linus Torvalds <torvalds@transmeta.com>,
       lsm <linux-security-module@wirex.com>, "Ted Ts'o" <tytso@mit.edu>,
       lkml <linux-kernel@vger.kernel.org>, Stephen Tweedie <sct@redhat.com>
Subject: Re: [RFC][PATCH] Extended Attributes for Security Modules
Message-ID: <385390000.1050425884@changeling.engr.sgi.com>
In-Reply-To: <1050414107.16051.70.camel@moss-huskers.epoch.ncsc.mil>
References: <Pine.LNX.4.33.0304140033100.12311-100000@muriel.parsec.at>
 <1050414107.16051.70.camel@moss-huskers.epoch.ncsc.mil>
X-Mailer: Mulberry/2.2.0 (Linux/x86)
X-HomePage: http://www.whitequeen.com/users/richard/
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



* frm sds@epoch.ncsc.mil "04/15/03 09:41:48 -0400" | sed '1,$s/^/* /'
*
* 
* Note that LSM intentionally does not provide any mechanism itself for
* sharing the security fields of the kernel data structures.  Stacking has
* to be handled by the principal security module.  

I see modules as empheral, but attritbutes as permanant. If I'm running one
LSM module, I reboot and use a different LSM module, what happens to the
attributes that the first module added to the file ?

Either we should guarantee that modules only touch attributes they know
about---ignoring all others (but not overwriting them), or we have separate
namespaces for each module's attributes.

Stacking modules will work with either scheme, but its seems to be that
switching policies over a reboot could easily be broken by a scheme that
shared a single namespace.
 
* -- 
* Stephen Smalley <sds@epoch.ncsc.mil>
* National Security Agency

richard.

-- 
-----------------------------------------------------------------------
Richard Offer                     Technical Lead, Trust Technology, SGI
"Specialization is for insects"
_______________________________________________________________________

