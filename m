Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbUL3P2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUL3P2c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 10:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbUL3P2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 10:28:32 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:24473 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261654AbUL3P2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 10:28:31 -0500
Message-ID: <41D42D52.A459CA25@tv-sign.ru>
Date: Thu, 30 Dec 2004 19:31:14 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, James.Bottomley@hansenpartnership.com,
       paulus@samba.org, davem@davemloft.net, lethal@linux-sh.org,
       davidm@hpl.hp.com, schwidefsky@de.ibm.com, takata@linux-m32r.org,
       ak@suse.de, rth@twiddle.net, matthew@wil.cx
Subject: Re: [patch] fix sparc64 cpu_idle()
References: <41D033FE.7AD17627@tv-sign.ru>
		 <20041227160848.GC771@holomorphy.com> <2cd57c9004122911073dea0d2c@mail.gmail.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> 
> It's not flexible to enforce  'void cpu_idle(void)'  all over. What If
> someday someone would want  to return value for some arch.
> 

May be you are right, but i can't imagine what could be done
after return from cpu_idle() except panic(). cpu_idle() is the
last call in start_kernel().

Oleg.
