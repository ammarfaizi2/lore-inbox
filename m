Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278701AbRJTA0h>; Fri, 19 Oct 2001 20:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278702AbRJTA01>; Fri, 19 Oct 2001 20:26:27 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.247.199]:19986 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S278701AbRJTA0V>;
	Fri, 19 Oct 2001 20:26:21 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Is writing to /dev/ramdom a security flaw (vserver project)
Date: 20 Oct 2001 00:26:45 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9qqgc5$4ht$1@abraham.cs.berkeley.edu>
In-Reply-To: <20011019172309.4219c22e9a53@remtk.solucorp.qc.ca>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1003537605 4669 128.32.45.153 (20 Oct 2001 00:26:45 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 20 Oct 2001 00:26:45 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jacques Gelinas  wrote:
>Is this a security issue if an administrator of a vserver is allowed to write
>in /dev/random ?

If you're talking about write(2), it should be safe, since the entropy
count is not affected.  If you're talking about doing an ioctl(2) on
/dev/random, this is risky (since root can modify the entropy counter),
but it looks like all those code paths are protected by a capability
check, so my guess is that you're probably ok this, too.
