Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWCZLw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWCZLw3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 06:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWCZLw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 06:52:29 -0500
Received: from smtpout.mac.com ([17.250.248.71]:20455 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751282AbWCZLw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 06:52:28 -0500
Date: Sun, 26 Mar 2006 06:52:05 -0500
From: Kyle Moffett <mrmacman_g4@mac.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: nix@esperi.org.uk, rob@landley.net, mmazur@kernel.pl,
       linux-kernel@vger.kernel.org, llh-discuss@lists.pld-linux.org
Subject: [RFC][PATCH 0/2] KABI example conversion and cleanup
Message-Id: <20060326065205.d691539c.mrmacman_g4@mac.com>
In-Reply-To: <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com>
References: <200603141619.36609.mmazur@kernel.pl>
	<200603231811.26546.mmazur@kernel.pl>
	<DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com>
	<200603241623.49861.rob@landley.net>
	<878xqzpl8g.fsf@hades.wkstn.nix>
	<D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com>
X-Mailer: Sylpheed version 2.2.1 (GTK+ 2.8.13; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2006 17:46:27 -0500 Kyle Moffett <mrmacman_g4@mac.com> wrote:
> I'm working on some sample patches now which I'll try to post in a
> few days if I get the time.

Ok, here's a sample of the KABI conversion and cleanup patches that I'm
proposing.  I have a few fundamental goals for these patches:
1)  The Linux kernel compiles and works at every step along the way
2)  Since most of the headers are currently quite broken with respect to
    GLIBC and userspace, I won't spend much extra time preserving
    compatibility with GLIBC, userspace, or non-GCC compilers.
3)  Everything in include/kabi will have a __kabi_ or __KABI_ prefix.
4)  Headers in include/linux that need the KABI interfaces will include
    the corresponding <kabi/*.h> header and define or typedef the
    necessary KABI definitions to the names the kernel wants.
5)  The stuff in include/kabi/*.h should always be completely independent
    of userspace/kernelspace and not require any includes outside of
    <kabi/*>.  This means that the only preprocessor symbols that we can
    assume are present are those provided by the compiler itself.

Cheers,
Kyle Moffett
