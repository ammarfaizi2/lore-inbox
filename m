Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbWD0IdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWD0IdA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 04:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWD0IdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 04:33:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21941 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964978AbWD0Ic7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 04:32:59 -0400
Subject: Re: A possibility of turning off file caching for certain
	operations
From: Arjan van de Ven <arjan@infradead.org>
To: Artem Tashkinov <t.artem@lycos.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060427082922.77DB586B12@ws7-1.us4.outblaze.com>
References: <20060427082922.77DB586B12@ws7-1.us4.outblaze.com>
Content-Type: text/plain
Date: Thu, 27 Apr 2006 10:32:56 +0200
Message-Id: <1146126777.2894.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-27 at 00:29 -0800, Artem Tashkinov wrote:
> A nice feature of emptying files and buffer cache was introduced in kernel 2.6.16 but my question is: Is it possible to turn off file caching for certain operations? E.g. I do not want the kernel to cache an ISO image which is being copied from HDD to the LAN or burned to CD.


it's called O_DIRECT and madvise()

but do you rEALLY REALLY want to disable caching? Caching, even a little
bit, is essential to get ok performance; if you disable caching it's
your responsibility to do all the things needed to get good IO
performance.

