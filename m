Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbTIKO6a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 10:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbTIKO6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 10:58:30 -0400
Received: from ns.suse.de ([195.135.220.2]:58025 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261162AbTIKO63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 10:58:29 -0400
Date: Thu, 11 Sep 2003 16:58:26 +0200
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, richard.brunner@amd.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-Id: <20030911165826.06f2fd16.ak@suse.de>
In-Reply-To: <3F6087FC.7090508@pobox.com>
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com>
	<20030911012708.GD3134@wotan.suse.de>
	<20030910184414.7850be57.akpm@osdl.org>
	<20030911014716.GG3134@wotan.suse.de>
	<3F60837D.7000209@pobox.com>
	<20030911162634.64438c7d.ak@suse.de>
	<3F6087FC.7090508@pobox.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003 10:34:36 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> 
> > X86_GENERIC is merely an optimization hint (currently it only changes the cache
> > line size hint) It does not change anything related to correctness. Everything
> > that handles correctness is checked unconditionally.
> 
> When, building non-Pentium4-related code when CONFIG_MPENTIUM4 && 
> !CONFIG_X86_GENERIC, it's OK that the code is incorrect for (picking 
> example) AMD processors.

No 2.6 changed that. On 2.6 you can exchange the kernels.

[that was mainly done for distributions, but helps other users too]
 
> If you're doing crazy LinuxBIOS stuff where flash size is limited, it 
> makes a lot of sense.  (and I do such crazy things)  The core 2.6 kernel 
> has really bloated with optional features, IMO.

If you really want to save text space just use .bz2 compression 
or compile the kernel with -Os. There are also other subsystems
that would benefit much more (better effort/cost ratio) than adding
micro #ifdefs to core code.

-Andi
