Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161213AbWHDOPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161213AbWHDOPS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 10:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWHDOPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 10:15:18 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:2717 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932359AbWHDOPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 10:15:17 -0400
Date: Fri, 4 Aug 2006 10:14:47 -0400
From: Jeff Dike <jdike@addtoit.com>
To: alessandro salvatori <sandr8@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 10/19] UML - Remove spinlock wrapper functions
Message-ID: <20060804141447.GA3837@ccure.user-mode-linux.org>
References: <200607070033.k670XhQR008707@ccure.user-mode-linux.org> <517e86fb0608040600n52f36b8ci60f4e219f8cd4b5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <517e86fb0608040600n52f36b8ci60f4e219f8cd4b5a@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 01:00:43PM +0000, alessandro salvatori wrote:
>   the new lock irq_lock is still static, but we now have preprocessor
> macros to be included from a header file instead of non-static functions in
> the same module as the static irq_lock.

I don't understand.  The changes in this patch are -
	remove two functions and their declarations
	replace calls to those functions with spin_lock_irq_save and
spin_unlock_irqsave
	move the spinlock declaration above the spin_(un)lock_irq_save
calls

Which of these are you talking about?

				Jeff
