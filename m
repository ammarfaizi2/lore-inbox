Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266915AbUFZBcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266915AbUFZBcx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 21:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266917AbUFZBcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 21:32:53 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:9225 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S266915AbUFZBcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 21:32:48 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: 2.6.x signal handler bug
Date: Sat, 26 Jun 2004 01:33:18 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <cbijou$nfa$1@abraham.cs.berkeley.edu>
References: <40DCBBC3.2010308@di.uoa.gr>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1088213598 24042 128.32.153.228 (26 Jun 2004 01:33:18 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Sat, 26 Jun 2004 01:33:18 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neither printf() nor longjmp() are safe to call from within
the sighandler.  Have you tried deleting printf() and replacing
longjmp() with siglongjmp()?  This is a FAQ; search the list archives
for details.
