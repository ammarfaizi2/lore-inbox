Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbUK1Onu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbUK1Onu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 09:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbUK1Onu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 09:43:50 -0500
Received: from holomorphy.com ([207.189.100.168]:46725 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261211AbUK1Ont (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 09:43:49 -0500
Date: Sun, 28 Nov 2004 06:43:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] rcu: eliminate rcu_data.last_qsctr
Message-ID: <20041128144346.GB2714@holomorphy.com>
References: <41A9E98F.209C59B0@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A9E98F.209C59B0@tv-sign.ru>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2004 at 06:06:55PM +0300, Oleg Nesterov wrote:
> Is the rcu_data.last_qsctr really needed?
> It is used in rcu_check_quiescent_state() exclusively.
> I think we can reset qsctr at the start of the grace period,
> and then just test qsctr against 0.

That might work if there were only 1 cpu. The local cpu owns ->qsctr,
->last_qsctr is stored and loaded by remote cpus under locks.


-- wli
