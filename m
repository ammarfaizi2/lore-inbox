Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWGKUMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWGKUMB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 16:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWGKUMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 16:12:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33746 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751220AbWGKUL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 16:11:59 -0400
Subject: Re: [PATCH] x86: Don't randomize stack unless current->personality
	permits it
From: Arjan van de Ven <arjan@infradead.org>
To: Frank van Maarseveen <frankvm@frankvm.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060711152202.GA18149@janus>
References: <20060711152202.GA18149@janus>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 22:11:57 +0200
Message-Id: <1152648717.3128.120.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 17:22 +0200, Frank van Maarseveen wrote:
> Do not randomize stack location unless current->personality permits it.
> 
> Signed-off-by: Frank van Maarseveen <frankvm@frankvm.com>
> ---

hmm I could have sworn this was taken care of already, 

Acked-by: Arjan van de Ven <arjan@linux.intel.com>


thinking about it... prior to adding randomization, there already was 8K
randomization of the stack pointer.. we probably only made the new
randomization conditional on the personality..
(and to be honest for performance reasons you really really want that 8K
at least on the netburst architectures)

