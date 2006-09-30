Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWI3WJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWI3WJg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 18:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWI3WJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 18:09:36 -0400
Received: from ns.suse.de ([195.135.220.2]:16030 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751414AbWI3WJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 18:09:35 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18) II
Date: Sun, 1 Oct 2006 00:09:30 +0200
User-Agent: KMail/1.9.3
Cc: Ingo Molnar <mingo@elte.hu>, Eric Rannaud <eric.rannaud@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Jan Beulich <jbeulich@novell.com>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com> <Pine.LNX.4.64.0609301406340.3952@g5.osdl.org> <200609302357.06215.ak@suse.de>
In-Reply-To: <200609302357.06215.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610010009.30123.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> BTW again let me repeat this particular issue wasn't in the unwinder
> itself, but just in the fallback-to-old code which didn't do enough
> sanity checks. So you can say it's not the new unwinder that
> crashed, but the old one here. I'll add more.

I double checked this now. This case Eric ran into should be already
fixed by a patch from Jan that went in before 2.6.18 even.

He just ran with an old kernel (2.6.18-rc3) that didn't have
that particular fix.

Still the kernel stack termination is probably a good idea. I think
(haven't tested) the current 2.6.18-git* code with termination 
wouldn't have crashed, but reported a (incorrect) stuck.

-Andi
