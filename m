Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbTDKBQK (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 21:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264287AbTDKBQK (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 21:16:10 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:26382 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP id S264283AbTDKBQJ (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 21:16:09 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] new syscall: flink
Date: 11 Apr 2003 01:02:30 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <b75476$ho0$1@abraham.cs.berkeley.edu>
References: <20030410221040.3631.qmail@email.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1050022950 18176 128.32.153.211 (11 Apr 2003 01:02:30 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 11 Apr 2003 01:02:30 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clayton Weaver wrote:
>One other thing: why O_CANLINK (suggested flag
>to open) instead of O_NOLINK?

Because O_CANLINK fails secure; O_NOLINK fails open.
When security is on the line, you really want a fail-safe solution.

And the failure mode of forgetting to specify an O_NOLINK flag
where it should have been specified is going to be a common one.
