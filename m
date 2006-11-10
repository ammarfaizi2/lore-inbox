Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424294AbWKJFHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424294AbWKJFHv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 00:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424299AbWKJFHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 00:07:50 -0500
Received: from ns1.suse.de ([195.135.220.2]:27838 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1424294AbWKJFHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 00:07:50 -0500
From: Andi Kleen <ak@suse.de>
To: Ernie Petrides <petrides@redhat.com>
Subject: Re: [PATCH] x86_64: fix perms/range of vsyscall vma in /proc/*/maps
Date: Fri, 10 Nov 2006 06:07:45 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200611100121.kAA1L0UN031589@pasta.boston.redhat.com>
In-Reply-To: <200611100121.kAA1L0UN031589@pasta.boston.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611100607.45391.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 November 2006 02:20, Ernie Petrides wrote:
> Hi, Andy.  The final line of /proc/<pid>/maps on x86_64 for native 64-bit
> tasks shows an incorrect ending address and incorrect permissions.  There
> is only a single page mapped in this vsyscall region, and it is accessible
> for both read and execute.

The range reported is how much address space is reserved, but you're
right it is less.

But I don't like hardcoding a page here -- this will likely be extended
soon. Can you please create a new define VSYSCALL_REAL_LENGTH or similar 
in vsyscall.h and use that?

Thanks,
-Andi

