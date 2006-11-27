Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758428AbWK0Tjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758428AbWK0Tjq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 14:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757639AbWK0Tjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 14:39:46 -0500
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:684 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1758538AbWK0Tjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 14:39:45 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Entropy Pool Contents
Date: Mon, 27 Nov 2006 19:33:05 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <ekfehh$kbu$1@taverner.cs.berkeley.edu>
References: <ek2nva$vgk$1@sea.gmane.org> <456B0F53.90209@cfl.rr.com> <456B101D.3040803@nortel.com> <456B3483.4010704@cfl.rr.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1164655985 20862 128.32.168.222 (27 Nov 2006 19:33:05 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Mon, 27 Nov 2006 19:33:05 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi  wrote:
>Why are non root users allowed write access in the first place?  Can't 
>the pollute the entropy pool and thus actually REDUCE the amount of good 
>entropy?

Nope, I don't think so.  If they could, that would be a security hole,
but /dev/{,u}random was designed to try to make this impossible, assuming
the cryptographic algorithms are secure.

After all, some of the entropy sources come from untrusted sources and
could be manipulated by an external adversary who doesn't have any
account on your machine (root or non-root), so the scheme has to be
secure against introduction of maliciously chosen samples in any event.
