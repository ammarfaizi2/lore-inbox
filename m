Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269168AbUJKSi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269168AbUJKSi0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 14:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269191AbUJKSi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 14:38:26 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:8056 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269168AbUJKSfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 14:35:31 -0400
Date: Mon, 11 Oct 2004 11:35:26 -0700
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       roland@redhat.com
Subject: Re: Weirdness with suspending jobs in 2.6.9-rc3
Message-ID: <20041011183526.GC3316@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, roland@redhat.com
References: <20041005063324.GA7445@darjeeling.triplehelix.org> <20041009101552.GA3727@stusta.de> <20041009140551.58fce532.akpm@osdl.org> <20041011182518.GA1892@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041011182518.GA1892@stusta.de>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
User-Agent: Mutt/1.5.6+20040722i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 08:25:18PM +0200, Adrian Bunk wrote:
> In Linus' tree, 2.6.9-rc1 is OK, but both 2.6.9-rc2 and 2.6.9-rc4 show 
> this problem.
> 
> What else might matter? Userspace? I'm using a Debian unstable.

I was thinking that maybe our libc not supporting the 'waitid' syscall
might be the problem? (Yes, debian unstable here too.)

Not sure, but every indication points to Roland's waitid patch being the
culprit.

-- 
Joshua Kwan
