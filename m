Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbVHJAyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbVHJAyI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 20:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbVHJAyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 20:54:08 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:48330 "EHLO
	taverner.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1751029AbVHJAyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 20:54:07 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: capabilities patch (v 0.1)
Date: Wed, 10 Aug 2005 00:53:54 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <ddbj72$na5$1@taverner.CS.Berkeley.EDU>
References: <4zuQJ-20d-11@gated-at.bofh.it> <20050809205206.GW7762@shell0.pdx.osdl.net> <Pine.LNX.4.58.0508092259570.9779@be1.lrz> <20050809214806.GA2288@clipper.ens.fr>
Reply-To: daw-usenet@taverner.CS.Berkeley.EDU (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.CS.Berkeley.EDU 1123635234 23877 128.32.168.222 (10 Aug 2005 00:53:54 GMT)
X-Complaints-To: news@taverner.CS.Berkeley.EDU
NNTP-Posting-Date: Wed, 10 Aug 2005 00:53:54 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Madore  wrote:
>I intend to add a couple of capabilities which are normally available
>to all user processes, including capability to exec(), [...]

Once you have a mechanism that lets you prevent the untrusted program
from exec-ing a setuid/setgid program (such as your bounding set idea),
I don't see any added value in preventing the program from calling exec().

"Don't forbid what you can't prevent".  The program can always emulate
the effect of exec() in userspace (for non-setuid/setgid programs) --
doing so is tedious, but nothing prevents a malicious userspace program
from implementing such a thing, I think.

This is only a comment on forbidding exec(), not on anything else in
your proposal.
