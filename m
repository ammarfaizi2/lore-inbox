Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264889AbTLFACW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 19:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264892AbTLFACW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 19:02:22 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:16390 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S264889AbTLFACV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 19:02:21 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: partially encrypted filesystem
Date: Fri, 5 Dec 2003 23:59:20 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <bqr64o$coa$1@abraham.cs.berkeley.edu>
References: <1070485676.4855.16.camel@nucleon> <20031204172653.GA12516@wohnheim.fh-wedel.de> <bqo1a2$s8i$1@abraham.cs.berkeley.edu> <20031205130202.GA31855@wohnheim.fh-wedel.de>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1070668760 13066 128.32.153.228 (5 Dec 2003 23:59:20 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Fri, 5 Dec 2003 23:59:20 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel  wrote:
>On Thu, 4 December 2003 19:18:26 +0000, David Wagner wrote:
>> What?  No.  Modern cryptosystems are designed to be secure against
>> known plaintext attacks.  Making your system more convoluted merely to
>> avoid providing known plaintext is a lousy design approach: the extra
>> complexity usually adds more risk than it removes.
>
>All cryptosystems are designed around the hope that noone figures out
>how to break them.  Many smart people trying and failing to do so
>gives a good general feeling, but nothing more.  It remains hope.

What's your point?  Nothing you are saying contradicts my conclusion.
I'll repeat my point: adding extra complexity adds more risk than it
takes away.  Sure, maybe you reduce the risk of a cryptographic failure
a teeny little bit by avoiding known plaintext, but doing so generally
makes the system more convoluted and hard to understand and maintain,
and *that* generally increases the risk of a security failure more than
enough to counterbalance any gains.

Basic principle: All else being equal, it's generally a good idea to
put more effort into defending against the more likely failure modes,
and less effort into less likely failures.

What are the chances that AES gets broken in the next 10 years?
Pretty small, I believe.  What are the chances that there is a bug
in the encrypting filesystem software that is discovered at some point
in the next 10 years?  Considerably higher.  So, focus on the software.
Complexity is your enemy.
