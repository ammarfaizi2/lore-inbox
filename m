Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWA3J6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWA3J6i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWA3J6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:58:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17286 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932193AbWA3J6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:58:36 -0500
Subject: Re: [PATCH] double fault enhancements
From: Arjan van de Ven <arjan@infradead.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43DDF050.76F0.0078.0@novell.com>
References: <43DDF050.76F0.0078.0@novell.com>
Content-Type: text/plain
Date: Mon, 30 Jan 2006 10:58:34 +0100
Message-Id: <1138615114.2977.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-30 at 10:54 +0100, Jan Beulich wrote:
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

(the way you sent this patch means that it's not possible to reply
inline to the patch. Please fix your mailer for this)

I would hope TSS and such remain in the kernel static space, because
those are the kind of things I'd like to be read only over time...

Also the last chunk of your patch has nothing to do with what you
describe here... and seems sort of suprious. (it might be a useful
cleanup, but it should be independent)

