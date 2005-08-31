Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbVHaX3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbVHaX3K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 19:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbVHaX3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 19:29:10 -0400
Received: from ns2.suse.de ([195.135.220.15]:12230 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964986AbVHaX3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 19:29:09 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MAX_ARG_PAGES has no effect?
References: <4314F761.2050908@kundor.org> <20050831121144.GA13578@elte.hu>
From: Andi Kleen <ak@suse.de>
Date: 01 Sep 2005 01:29:07 +0200
In-Reply-To: <20050831121144.GA13578@elte.hu>
Message-ID: <p73psrtr8ho.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:
> 
> MAX_ARG_PAGES should work just fine. I think the 'getconf ARG_MAX' 
> output is hardcoded. (because the kernel does not provide the 
> information dynamically)

Perhaps it would be a good idea to make it a sysctl. Is there 
any reason it should be hardcoded?  I cannot think of any.

Ok if someone lowers the sysctl then execve has to handle
the case of the args/environment possibly not fitting anymore,
but that should be easy.

-Andi
