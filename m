Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbTDXUbW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 16:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263447AbTDXUbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 16:31:21 -0400
Received: from ns.suse.de ([213.95.15.193]:15123 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261301AbTDXUbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 16:31:21 -0400
To: mikpe@csd.uu.se
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc1 on x86_64 oops at shutdown -h
References: <16040.16960.528537.454110@gargle.gargle.HOWL.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 24 Apr 2003 22:43:29 +0200
In-Reply-To: <16040.16960.528537.454110@gargle.gargle.HOWL.suse.lists.linux.kernel>
Message-ID: <p73r87rwrri.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mikpe@csd.uu.se writes:

> 2.4.21-rc1 on x86_64 oopses on me at shutdown -h in certain situations.
> It's repeatable. Here's the raw oops:

Ah I know what the problem is. I already fixed it in CVS two weeks ago, but 
the merge with marcelo was in the brokenness window and I forgot about
it because of the long delay (the patch got only applied three weeks
later or so)

Just copy arch/x86_64/lib/copy_user.S from an 2.4.20 kernel or revert the 
changes in  that file in 2.4.21-rc1, that should fix it.

Thanks for testing,
-Andi
