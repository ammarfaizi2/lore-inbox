Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265250AbRF0EmV>; Wed, 27 Jun 2001 00:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265255AbRF0EmM>; Wed, 27 Jun 2001 00:42:12 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:59662 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S265250AbRF0El6>;
	Wed, 27 Jun 2001 00:41:58 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] User chroot
Date: 27 Jun 2001 04:39:38 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9hbo2a$g77$1@abraham.cs.berkeley.edu>
In-Reply-To: <E15F3KH-0003fd-00@pmenage-dt.ensim.com> <3B393222.14273547@haque.net>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 993616778 16615 128.32.45.153 (27 Jun 2001 04:39:38 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 27 Jun 2001 04:39:38 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mohammad A. Haque wrote:
>Why do this in the kernel when it's available in userspace?

Because the userspace implementations aren't equivalent.
In particular, it is not so easy for them to enforce the following
restriction:
  (*) If a non-root user requested the chroot, then setuid/setgid
      bits won't have any effect under the new root.
The proposed kernel patch respects (*), but I'm not aware of any
user-level application that ensures (*) is followed.

(Also, there is the small matter that the user-level implementations
are only usable by root, or are setuid root.  The latter is only a
minor difference, though, IMHO.)
