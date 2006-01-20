Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422711AbWATEsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422711AbWATEsG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 23:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422712AbWATEsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 23:48:06 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:16078 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422711AbWATEsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 23:48:05 -0500
Subject: Re: [PATCH]: Fix regression added by ppoll/pselect code.
From: David Woodhouse <dwmw2@infradead.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060119.164042.74751188.davem@davemloft.net>
References: <20060119.164042.74751188.davem@davemloft.net>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 17:48:06 +1300
Message-Id: <1137732487.30084.194.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 16:40 -0800, David S. Miller wrote:
> The two ROUND_UP() calls upon entry are using {tv,ts}_sec where it
> should instead be using {tv_usec,ts_nsec}, which perfectly explains
> the observed incorrect behavior.

Hm, I thought akpm had already fixed that -- but thanks.

His patch also changed the simple powers of ten to the slightly
confusing 'NSEC_PER_SEC' and 'USEC_PER_SEC' macros, as if those numbers
are subject to change by later decree, and shouldn't be hard-coded. I
suspect we can do without that part, although I don't really care either
way.

-- 
dwmw2

