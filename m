Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268082AbUHFPJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268082AbUHFPJd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268085AbUHFPJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:09:33 -0400
Received: from zero.aec.at ([193.170.194.10]:30212 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S268082AbUHFPJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:09:25 -0400
To: James Morris <jmorris@redhat.com>
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Re-implemented i586 asm AES (updated)
References: <2qbyt-1Op-45@gated-at.bofh.it> <2qemF-3Pj-49@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 06 Aug 2004 17:09:17 +0200
In-Reply-To: <2qemF-3Pj-49@gated-at.bofh.it> (James Morris's message of
 "Fri, 06 Aug 2004 17:00:21 +0200")
Message-ID: <m3wu0cgv6q.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@redhat.com> writes:
>
>> Does it work on x86 CPUs without MMX?
>
> Yes, Linus removed the MMX stuff.

You could use .altinstructions to patch a jump in at runtime
based on CPU capabilities. Assuming MMX is really faster of course.

See arch/x86_64/lib/copy_page.S for an example.

-Andi

