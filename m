Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbTHYG37 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 02:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbTHYG36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 02:29:58 -0400
Received: from [61.34.11.200] ([61.34.11.200]:51422 "EHLO ns.aratech.co.kr")
	by vger.kernel.org with ESMTP id S261523AbTHYG35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 02:29:57 -0400
Date: Mon, 25 Aug 2003 15:31:55 +0900
From: TeJun Huh <tejun@aratech.co.kr>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Race condition in 2.4 tasklet handling (cli() broken?)
Message-ID: <20030825063155.GA11458@atj.dyndns.org>
References: <20030823025448.GA32547@atj.dyndns.org> <20030823040931.GA3872@atj.dyndns.org> <20030823052633.GA4307@atj.dyndns.org> <20030823122813.0c90e241.skraw@ithnet.com> <20030823151315.GA6781@atj.dyndns.org> <20030823173736.13235adc.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030823173736.13235adc.skraw@ithnet.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 23, 2003 at 05:37:36PM +0200, Stephan von Krawczynski wrote:
> 
> Feel free to ask anything about the issue, I will try to help however possible.

 A deadlock occured today on our test machine, and the offending part
was drivers/char/random.c:iplock.  The spinlock is used without _bh
suffix both by the connect and accept paths causing deadlock
occasionally.  This seemed to be already fixed in the latest 2.4 bk
tree.  I believe this will cure our problem. :-)

-- 
tejun
