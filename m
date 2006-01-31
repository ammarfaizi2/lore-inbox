Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWAaMfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWAaMfd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 07:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWAaMfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 07:35:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:922 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750790AbWAaMfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 07:35:32 -0500
To: "Jan Beulich" <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] double fault enhancements
References: <43DDF050.76F0.0078.0@novell.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
In-Reply-To: <43DDF050.76F0.0078.0@novell.com.suse.lists.linux.kernel>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Date: 31 Jan 2006 13:35:29 +0100
Message-ID: <p73d5i8mv72.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <JBeulich@novell.com> writes:

> From: Jan Beulich <jbeulich@novell.com>
> 
> Make the double fault handler use CPU-specific stacks. Add some
> abstraction to simplify future change of other exception handlers to go
> through task gates. Change the pointer validity checks in the double
> fault handler to account for the fact that both GDT and TSS aren't in
> static kernel space anymore. Add a new notification of the event
> through the die notifier chain, also providing some environmental
> adjustments so that various infrastructural things work independent of
> the fact that the fault and the callbacks are running on other then the
> normal kernel stack.

Looks good to me. Feel free to include a Acked-by: ak@suse.de
in future versions.

-Andi

