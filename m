Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751591AbWEZVbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbWEZVbJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 17:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbWEZVbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 17:31:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45966 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751591AbWEZVbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 17:31:08 -0400
Date: Fri, 26 May 2006 14:33:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: rjw@sisk.pl, pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: APM suspend to RAM broken, culprit found
Message-Id: <20060526143353.42a456fe.akpm@osdl.org>
In-Reply-To: <20060526211249.GP24227@waste.org>
References: <20060526211249.GP24227@waste.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> Bisection reveals that the patch entitled:
> 
> [PATCH] swsusp: add check for suspension of X-controlled devices
> 
> breaks resume of ipw2200, synaptics mouse, USB, and probably other
> useful bits on my Thinkpad R51. Notably, I'm using APM.
> 

Would that be because APM remains in X while suspending, but swsusp flicks
back to VT mode?

Anyway, I'll queue a revert patch for 2.6.17, thanks.
