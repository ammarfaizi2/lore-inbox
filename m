Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbUK1PK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbUK1PK7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 10:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbUK1PK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 10:10:59 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:45278 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261490AbUK1PKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 10:10:53 -0500
Message-ID: <41A9F8F6.3255879A@tv-sign.ru>
Date: Sun, 28 Nov 2004 19:12:38 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] rcu: eliminate rcu_data.last_qsctr
References: <41A9E98F.209C59B0@tv-sign.ru> <20041128144346.GB2714@holomorphy.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>
> On Sun, Nov 28, 2004 at 06:06:55PM +0300, Oleg Nesterov wrote:
> > Is the rcu_data.last_qsctr really needed?
> > It is used in rcu_check_quiescent_state() exclusively.
> > I think we can reset qsctr at the start of the grace period,
> > and then just test qsctr against 0.
>
> That might work if there were only 1 cpu. The local cpu owns ->qsctr,
> ->last_qsctr is stored and loaded by remote cpus under locks.

How can it be?

Afaics, the whole rcu_data is cpu local.

If i am wrong, could you please clarify?

Oleg.
