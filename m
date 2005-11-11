Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbVKKFGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbVKKFGR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 00:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbVKKFGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 00:06:17 -0500
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:54972 "EHLO
	taverner.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S932359AbVKKFGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 00:06:16 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] getrusage sucks
Date: Fri, 11 Nov 2005 05:06:00 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <dl18ro$l0f$1@taverner.CS.Berkeley.EDU>
References: <200511102334.10926.cloud.of.andor@gmail.com>
Reply-To: daw-usenet@taverner.CS.Berkeley.EDU (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.CS.Berkeley.EDU 1131685560 21519 128.32.168.222 (11 Nov 2005 05:06:00 GMT)
X-Complaints-To: news@taverner.CS.Berkeley.EDU
NNTP-Posting-Date: Fri, 11 Nov 2005 05:06:00 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Claudio Scordino  wrote:
>Does exist any _real_ reason why getrusage can't be invoked by a task to know 
>statistics of another task ?

Probably only super-user should be permitted to read the usage information
about other processes.  Allowing anyone to read anyone else's rusage would
open up a bunch of side channels that sound pretty dangerous.  For instance,
user #1 might be able to mount a timing attack against crypto code being
executed by user #2, and that doesn't sound good.
