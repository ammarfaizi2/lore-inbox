Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbTEaW7m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 18:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264489AbTEaW7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 18:59:42 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:29709 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP id S264488AbTEaW7k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 18:59:40 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [CHECKER] pcmcia user-pointer dereference
Date: 31 May 2003 22:46:40 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <bbbbcg$616$1@abraham.cs.berkeley.edu>
References: <17ACEE5A-921A-11D7-B8B8-000A95A0560C@us.ibm.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1054421200 6182 128.32.153.211 (31 May 2003 22:46:40 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 31 May 2003 22:46:40 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hollis Blanchard  wrote:
>I contacted David Hinds about this; the behavior is by design. User 
>space passes in a pointer to a kernel data structure, and the kernel 
>verifies it by checking a magic number in that structure.

As you and others point out, this isn't safe, in general.  What if an
attacker can get the magic number at the required offset from interesting
memory location in kernel space?  This seems like a plausible assumption.
Then the attacker can read secret kernel memory, which is bad.

This sounds scary.  I don't know whether there are any exploitable
attacks here, but based on what you said, it seems strange to take this
kind of risk.

Sounds to me like it should be treated as a security hole.  Good catch,
Junfeng et al!
