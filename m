Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbVLRGGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbVLRGGa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 01:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbVLRGGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 01:06:30 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:14775 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751049AbVLRGG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 01:06:29 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
To: Adrian Bunk <bunk@stusta.de>, Andi Kleen <ak@suse.de>,
       Kyle Moffett <mrmacman_g4@mac.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Reply-To: 7eggert@gmx.de
Date: Sun, 18 Dec 2005 06:57:44 +0100
References: <5k8PZ-4xt-9@gated-at.bofh.it> <5k9sD-5yh-13@gated-at.bofh.it> <5knFp-kU-51@gated-at.bofh.it> <5korL-1xX-33@gated-at.bofh.it> <5kpRh-3sK-11@gated-at.bofh.it> <5kq0L-3FB-37@gated-at.bofh.it> <5kOma-4K1-23@gated-at.bofh.it> <5kRk3-xO-11@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EnrYH-00019M-Ep@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:

> I'm with you that we need a safety net, but I don't see a problem with
> this being between 3kB and 4kB. The goal should be to _never_ use more
> than 3kB stack having a 1kB safety net.
> 
> And in my experience, many stack problems don't come from code getting
> more complex but from people allocating 1kB structs or arrays of
> > 2k chars on the stack. In these cases, the code has to be fixed and
> "make checkstack" makes it easy to find such cases.
> 
> And as a data point, my count of bug reports for problems with in-kernel
> code with 4k stacks after Neil's patch went into -mm is still at 0.

Would you run a desktop with an nfs server on xfs on lvm on dm on SCSI?
Or a productive server on -mm?

IMO it's OK to push 4K stacks in -mm, but one week of no error reports from
a few testers don't make a reliable system.

[...]

> Unfortunately, "is not really something to encourage" doesn'a make
> "happens in real-life applications" impossible...

The same applies to using kernel stack. Therefore I'll want to choose
a bigger stack for my server, which runs less than 100 processes.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
