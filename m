Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030810AbWJDKx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030810AbWJDKx6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 06:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030811AbWJDKx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 06:53:58 -0400
Received: from mail.suse.de ([195.135.220.2]:18095 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030810AbWJDKx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 06:53:58 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
Date: Wed, 4 Oct 2006 12:52:48 +0200
User-Agent: KMail/1.9.3
Cc: "Ingo Molnar" <mingo@elte.hu>, "Eric Rannaud" <eric.rannaud@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Chandra Seetharaman" <sekharan@us.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       nagar@watson.ibm.com
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com> <200609302230.24070.ak@suse.de> <45239A38.76E4.0078.0@novell.com>
In-Reply-To: <45239A38.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610041252.48721.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >> > [  138.751306]  [<ffffffff8021ecc0>] search_extable+0x40/0x70
> >
> >After here the unwinder seems to become a bit and it shouldn't print
> >multiple entries. Jan any ideas why?
> 
> Not without raw stack contents.

I suppose those are lost in time. 

Unfortunately lockdep doesn't even print stack contents because it doesn't
save them.
 
> >Proposed patch appended. Jan, what do you think?
> 
> As said above - I thought we added zero-termination already.

For head.S but not for kernel_thread I think. At least I can't
find any existing code for kernel_thread().

-Andi
