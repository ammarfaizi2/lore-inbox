Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268224AbUIPVMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268224AbUIPVMx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 17:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268268AbUIPVMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 17:12:53 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:28104 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S268224AbUIPVMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 17:12:51 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: offtopic: how to break huge patch into smaller independent patches?
Date: Thu, 16 Sep 2004 23:11:48 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.09.16.21.11.47.825104@smurf.noris.de>
References: <41474B15.8040302@nortelnetworks.com> <20040914201210.GE13788@redhat.com>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: server.smurf.noris.de 1095369108 21578 192.109.102.35 (16 Sep 2004 21:11:48 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Thu, 16 Sep 2004 21:11:48 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dave Jones wrote:

> diffsplit will split it into a patch-per-file, which could be
> a good start. If you have multiple changes touching the same file
> however, things get a bit more fun, and you get to spend a lot
> of time in your favorite text editor glueing bits together.

You can rip the bits apart instead, and leave the glueing and rip-patching
to the computer.

- edit patch file:
  - delete all the parts you don't want applied; freely hand-edit stuff,
    and don't worry about the pesky line numbers
  - save to new patch file
- run "rediff" to fix up the new file
- run "interdiff" to create a second, clean patch file
  containing just the deleted parts
- iterate until finished

All of this is part of the nice patchutils package.

NB: if all else fails, use espdiff(1).
-- 
Matthias Urlichs
