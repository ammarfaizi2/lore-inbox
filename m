Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWCTNmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWCTNmS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWCTNmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:42:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:14248 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964790AbWCTNmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:42:17 -0500
Subject: Re: PATCH][1/8] 2.6.15 mlock: make_pages_wired/unwired
From: Arjan van de Ven <arjan@infradead.org>
To: Stone Wang <pwstone@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <bc56f2f0603200536scb87a8ck@mail.gmail.com>
References: <bc56f2f0603200536scb87a8ck@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 14:42:14 +0100
Message-Id: <1142862134.3114.49.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-20 at 08:36 -0500, Stone Wang wrote:
> 1. Add make_pages_unwired routine.
> 2. Replace make_pages_present with make_pages_wired, support rollback.
> 3. Pass 1 more param ("wire") to get_user_pages.

hmm again "wire" is a meaningless name
also.. get_user_pages ALWAYS pins the page ... so might as well make
that automatic (with an unpin when the pinning is released)



