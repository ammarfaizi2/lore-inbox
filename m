Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266591AbUGKNiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266591AbUGKNiu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 09:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266592AbUGKNiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 09:38:50 -0400
Received: from zero.aec.at ([193.170.194.10]:3082 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266591AbUGKNit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 09:38:49 -0400
To: Matthew Wilcox <willy@debian.org>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: serious performance regression due to NX patch
References: <2giKE-67F-1@gated-at.bofh.it> <2gIc8-6pd-29@gated-at.bofh.it>
	<2gJ8a-72b-11@gated-at.bofh.it> <2gJhY-776-21@gated-at.bofh.it>
	<2gJrv-7kp-5@gated-at.bofh.it> <2gLD2-qn-3@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sun, 11 Jul 2004 15:38:44 +0200
In-Reply-To: <2gLD2-qn-3@gated-at.bofh.it> (Matthew Wilcox's message of
 "Sun, 11 Jul 2004 14:30:09 +0200")
Message-ID: <m3wu1a8xzv.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@debian.org> writes:

> On Sun, Jul 11, 2004 at 03:02:25AM -0700, Andrew Morton wrote:
>> Apropos of nothing much, CONFIG_X86 would be preferreed here, but x86_64
>> defines that too.
>
> IMO, x86-64 should stop defining CONFIG_X86.  It's far more common
> to say "X86 && !X86_64" than it is to say X86.  How about defining
> CONFIG_X86_COMMON and migrating usage of X86 to X86_COMMON?

Definitely not in 2.6 because it has far too much potential to 
add subtle bugs, and that is not appropiate for a stable release. 
In 2.7 maybe.

Buy I would prefer to just add an truly i386 specific define 
like Andrew proposed.

-Andi

