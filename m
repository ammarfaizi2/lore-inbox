Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbTIKO0i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 10:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbTIKO0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 10:26:38 -0400
Received: from ns.suse.de ([195.135.220.2]:65177 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261186AbTIKO0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 10:26:36 -0400
Date: Thu, 11 Sep 2003 16:26:34 +0200
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, richard.brunner@amd.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-Id: <20030911162634.64438c7d.ak@suse.de>
In-Reply-To: <3F60837D.7000209@pobox.com>
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com>
	<20030911012708.GD3134@wotan.suse.de>
	<20030910184414.7850be57.akpm@osdl.org>
	<20030911014716.GG3134@wotan.suse.de>
	<3F60837D.7000209@pobox.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003 10:15:25 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> Andi Kleen wrote:
> > It could be done but ... we are moving more and more to generic kernels
> > (e.g. see the alternative patch code which is enabled unconditionally)
> > So that when you have a kernel it will boot on near all modern CPUs.
> 
> 
> Only with CONFIG_X86_GENERIC.  That's precisely why CONFIG_X86_GENERIC 
> was created.

It was not created for that (I know that because I created it ;-)

X86_GENERIC is merely an optimization hint (currently it only changes the cache
line size hint) It does not change anything related to correctness. Everything
that handles correctness is checked unconditionally.

is_prefetch is a correctness thing.

> 
> If I disabled CONFIG_X86_GENERIC and select CONFIG_MPENTIUM4, I darned 
> well better not get any Athlon code.  The cpu setup code in particular I 
> want to conditionalize, and there are other bits that need work... but 
> for the most part it works as intended.

Now that's becomming silly. It's alttogether only a few KB and all
__init code anyways.

-Andi
