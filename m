Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbUK0TVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbUK0TVO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 14:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbUK0TVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 14:21:14 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:16136 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S261304AbUK0TVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 14:21:11 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: no entropy and no output at /dev/random  (quick question)
Date: Sat, 27 Nov 2004 19:20:28 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <coak1s$suq$1@abraham.cs.berkeley.edu>
References: <41A7EDA1.5000609@migraciones.gov.ar> <41A804CD.5070007@migraciones.gov.ar>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1101583228 29658 128.32.168.222 (27 Nov 2004 19:20:28 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Sat, 27 Nov 2004 19:20:28 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Javier Villavicencio  wrote:
>it's encouraged to use /dev/urandom instead of /dev/random?

Yes, for almost all purposes, applications should use /dev/urandom,
not /dev/random.  (The names for these devices are unfortunate.)
Sadly, many applications fail to follow these rules, and consequently
/dev/random's entropy pool often ends up getting depleted much faster
than it has to be.
