Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbTHaUX1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 16:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbTHaUX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 16:23:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11323 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262666AbTHaUXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 16:23:25 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Matt Tolentino <metolent@snoqualmie.dp.intel.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       matthew.e.tolentino@intel.com
Subject: Re: [UPDATED PATCH] EFI support for ia32 kernels
References: <200308292019.h7TKJ6FK000649@snoqualmie.dp.intel.com>
	<20030829152939.2692ef14.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <20030829152939.2692ef14.akpm@osdl.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Date: 31 Aug 2003 14:24:07 -0600
Message-ID: <m1bru5r2xk.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Matt Tolentino <metolent@snoqualmie.dp.intel.com> wrote:
> >
> > 
> > Attached is an updated patch against 2.6.0-test4 that enables Extensible
> Firmware
> 
> > Interface (EFI) awareness in ia32 Linux kernels.
> 
> Just for my edification: why does EFI exist?  

As I have heard the story.

The guys at Intel were having problems getting a traditional
PC style BIOS to run on the first Itaniums, realized they
had a opportunity to come up with a cleaner firmware interface
and came up with EFI.  Open Firmware was considered but dropped
because it was not compatible with ACPI, and they did not want to
dilute the momentum that had built up for ACPI.

And now since Intel has something moderately portable, they intend
to back port it to x86 and start using/shipping it sometime early next
year.

What I find interesting is that I don't see it addressed how the 16bit
BIOS calls in setup.S can be bypassed on x86.  And currently while it
works to enter at the kernels 32bit entry point if you know what you
are doing it is still officially not supported. 

Eric
