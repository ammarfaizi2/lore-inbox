Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbUK1Pa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbUK1Pa6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 10:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbUK1Pa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 10:30:57 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:24710 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261495AbUK1Pa4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 10:30:56 -0500
Date: Sun, 28 Nov 2004 21:03:34 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] rcu: eliminate rcu_data.last_qsctr
Message-ID: <20041128153334.GB20894@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <41A9E98F.209C59B0@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A9E98F.209C59B0@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2004 at 06:06:55PM +0300, Oleg Nesterov wrote:
> Hello.
> 
> Is the rcu_data.last_qsctr really needed?
> 
> It is used in rcu_check_quiescent_state() exclusively.
> I think we can reset qsctr at the start of the grace period,
> and then just test qsctr against 0.
> 

No race with interrupt for rdp->qsctr, so it looks good.

Thanks
Dipankar
