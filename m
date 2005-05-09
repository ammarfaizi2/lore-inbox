Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVEIOZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVEIOZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 10:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVEIOZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 10:25:28 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:20911 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261388AbVEIOYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 10:24:55 -0400
Message-ID: <427F746E.612E2CB9@tv-sign.ru>
Date: Mon, 09 May 2005 18:32:14 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] Priority Lists for the RT mutex
References: <F989B1573A3A644BAB3920FBECA4D25A0331776B@orsmsx407> <427C6D7D.878935F1@tv-sign.ru> <20050509073043.GA12976@elte.hu> <427F1A99.58BCCB88@tv-sign.ru> <20050509091133.GA25959@elte.hu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> What would be nice to achieve are [low-cost] reductions of the size of
> struct rt_mutex (in include/linux/rt_lock.h), upon which all other
> PI-aware locking objects are based. Right now it's 9 words, of which
> struct plist is 5 words. Would be nice to trim this to 8 words - which
> would give a nice round size of 32 bytes on 32-bit.

Yes, the size of pl_head in that patch is 4 words, it doesn't have ->prio.

Oleg.
