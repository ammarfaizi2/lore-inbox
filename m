Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266806AbUGLMHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266806AbUGLMHp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 08:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266815AbUGLMHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 08:07:45 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:28934 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id S266806AbUGLMHn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 08:07:43 -0400
Message-ID: <40F27FE6.A7E4FD96@tv-sign.ru>
Date: Mon, 12 Jul 2004 16:11:18 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] hugetlbfs private mappings.
References: <40F139BA.F1F10B22@tv-sign.ru> <20040712001502.GS21066@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> On Sun, Jul 11, 2004 at 04:59:38PM +0400, Oleg Nesterov wrote:
> > Hugetlbfs silently coerce private mappings of hugetlb files
> > into shared ones. So private writable mapping has MAP_SHARED
> > semantics. I think, such mappings should be disallowed.
> 
> This probably doesn't break anything worth caring about, but it may
> make people happier to just force MAP_SHARED on.

Yes, it was my initial intent. Andrew Morton pointed out, that
this could break existing applications.

Oleg.
