Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270476AbTGSSuj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 14:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270477AbTGSSuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 14:50:39 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:15065 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S270476AbTGSSuh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 14:50:37 -0400
Date: Sat, 19 Jul 2003 12:05:31 -0700
From: Larry McVoy <lm@bitmover.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Bitkeeper
Message-ID: <20030719190531.GB24698@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0307181603340.21716-100000@chimarrao.boston.redhat.com> <1058560325.2662.31.camel@localhost> <20030719184246.GF7452@lug-owl.de> <20030719184944.GC24197@work.bitmover.com> <20030719185737.GG7452@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030719185737.GG7452@lug-owl.de>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0,
	required 7)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Basically, cvsps sucks off the rlog messages and compares any check-in

Hmm.  I would guess that makes rlog very happy.  And sleepy :)

> texts / times of any files to find out what has been checked-in with a
> single check-in. That is then called a patchset (cvs_ps_). With some
> command line arguments, it'll then output the check-in text as well as a
> unified diff.

We're looking at getting some seperate bandwidth for bkbits.net and 
turning on the patch feature of BK/Web.  Then you'll be able to do a

    wget http://linux.bkbits.net/linux-2.5/gnupatch@1.5234

and get something like the following.  I suspect this is better than
cvsps and it will work for all repositories on bkbits.net, not just 
the mainline one.  Is that good enough for what you want?  The format
below repeats for each file in the changeset.

===== man/man1/bk-config-etc.1 1.23.1.1 vs 1.26 =====
02/05/16 13:44:09 wscott@wscott1.homeip.net 1.24 +16 -0
   Document 'trust_window' parameter
02/10/03 11:24:15 wscott@desk.wscott1.homeip.net 1.23.1.2 +9 -0
   Docuement the BK_CONFIG environmental variable

--- 1.23.1.1/man/man1/bk-config-etc.1   Tue Sep 17 12:33:59 2002
+++ 1.26/man/man1/bk-config-etc.1       Thu Oct  3 09:24:49 2002
@@ -30,6 +30,15 @@
 (/etc/BitKeeper/etc/config) then that setting will override any 
 matching key in local config files.  
 .LP
+Also configuration entries can be overridden with the
+.B BK_CONFIG
+environmental variable.  That variable can contain a list of key:value
+pairs seperated by semicolons.  For example:
+.DS
+.BR BK_CONFIG =\c
+.IR key1 : value2 ; key2 : value2 ; key3 : value3\c
+.DE
+.LP
 Minimum content requirements for the BitKeeper/etc/config file 

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
