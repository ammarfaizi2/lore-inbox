Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264502AbUHBWzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbUHBWzJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 18:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUHBWzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 18:55:09 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:29715 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S264502AbUHBWzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 18:55:04 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] Delete cryptoloop
Date: Mon, 2 Aug 2004 22:54:48 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <cemgno$hun$2@abraham.cs.berkeley.edu>
References: <1091193219.11944.17.camel@leto.cs.pocnet.net> <200407310044.i6V0iOZe032440@taverner.CS.Berkeley.EDU> <20040731020534.GX5414@waste.org>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1091487288 18391 128.32.168.222 (2 Aug 2004 22:54:48 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Mon, 2 Aug 2004 22:54:48 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall  wrote:
>Here's a probable scenario: encrypted mail spool in maildir format.
>Attacker can send mail of his choosing and then later capture the
>machine with the hope of breaking in.

No, actually, that's the kind of simple scenario where existing Cryptoloop
does a more or less reasonable job (in my opinion).  In a simple scenario,
the attacker can choose or exert partial control over some of the data
stored on your disk, then can steal your hard disk and see what is stored
on it, and you never see the hard disk again.  This is the scenario where
Saarinen's watermarking attack is possible, and if you're unlucky there
may be some partial information leakage as detailed in my previous email,
but nothing much worse than this (as far as I know).

The point I was making is that there are other scenarios where Cryptoloop
falls apart in much more devastating ways.  For instance, if the attacker
can modify the ciphertexts stored on your hard disk and you continue
using the hard disk afterwards, then really nasty attacks become possible.
Other attacks become possible if the attacker can observe the ciphertexts
stored on your hard disk at multiple points in time.  The question I was
asking is this: Does anyone care about these latter types of scenarios?

>Ideally, we'd ship a requirements and specification document that
>describes the security trade-offs of cryptoloop/dm-crypt in some
>detail. There are way too many unstated assumptions here.

Yes, that sounds like something that would make a lot of sense.
