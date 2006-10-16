Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWJPNqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWJPNqY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 09:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWJPNqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 09:46:24 -0400
Received: from ns2.suse.de ([195.135.220.15]:54751 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750761AbWJPNqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 09:46:23 -0400
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: thoughts on potential cleanup of semaphores?
References: <Pine.LNX.4.64.0610101025080.8855@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 16 Oct 2006 15:46:13 +0200
In-Reply-To: <Pine.LNX.4.64.0610101025080.8855@localhost.localdomain>
Message-ID: <p73slhocr16.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert P. J. Day" <rpjday@mindspring.com> writes:

>   after submitting one patch related to semaphores and before i submit
> any others, any thoughts whether any of the following clean-ups are
> valid and/or worthwhile?  (some are admittedly simply aesthetic but
> better aesthetics is never a bad thing.)

Semaphores and rwsems need a lot of cleanup. Some time ago we put
spinlocks which are a lot more time critical than semaphores
out of line. So the same could be done for semaphores too. This
had the advantages that most of the assembler voodoo wouldn't
be needed anymore and they could be simple straight C implementations
shared by all architectures.

-Andi
